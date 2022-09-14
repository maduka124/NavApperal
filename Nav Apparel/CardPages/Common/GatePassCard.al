page 71012827 "Gate Pass Card"
{
    PageType = Card;
    SourceTable = "Gate Pass Header";
    Caption = 'Gate Pass';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Gate Pass No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Vehicle No."; "Vehicle No.")
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle No';
                }

                field("Transfer Date"; "Transfer Date")
                {
                    ApplicationArea = All;
                }

                field("Transfer From Name"; "Transfer From Name")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer From';
                    Editable = false;
                }

                field("Transfer To Name"; "Transfer To Name")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer To';

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin
                        LocationRec.Reset();
                        LocationRec.SetRange(name, "Transfer To Name");
                        if LocationRec.FindSet() then
                            "Transfer To Code" := LocationRec.Code;

                        FromToFactoryCodes := "Transfer From Code" + '/' + LocationRec.Code;



                        CurrPage.Update();
                    end;
                }

                field(Type; Type)
                {
                    ApplicationArea = All;
                }

                field("Expected Return Date"; "Expected Return Date")
                {
                    ApplicationArea = All;
                }

                field("Sent By"; "Sent By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Approved By"; "Approved By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Approved/Rejected By';
                }

                field("Approved Date"; "Approved Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Approved/Rejected Date';
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }

            group("Items")
            {
                part("Gate Pass ListPart"; "Gate Pass ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No.");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Send to Approve")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;

                trigger OnAction()
                var
                    UserRec: Record "User Setup";
                begin
                    if (Status = Status::New) or (Status = Status::Rejected) then begin
                        if "Transfer From Code" = FactoryGB then begin
                            UserRec.Reset();
                            UserRec.SetRange("Factory Code", FactoryGB);
                            UserRec.SetFilter("GT Pass Approve", '=%1', true);
                            if not UserRec.FindSet() then
                                Error('Approval user for factory : %1 has not setup.', "Transfer From Name")
                            else begin
                                ApprovalSentToUser := UserRec."User ID";
                                "Approved By" := '';
                                "Approved Date" := 0D;
                                Status := Status::"Pending Approval";
                                CurrPage.Update();
                                Message('Sent to approval');
                            end;
                        end
                        else
                            Error('You are not authorized to send this for approval.');
                    end
                    else
                        Message('This Gate Pass has been already sent for approval or approved.');
                end;
            }

            action(Approve)
            {
                ApplicationArea = All;
                Image = Approve;

                trigger OnAction()
                var
                    UserRec: Record "User Setup";
                begin
                    UserRec.Reset();
                    UserRec.SetRange("User ID", UserId);
                    UserRec.SetFilter("GT Pass Approve", '=%1', true);

                    if not UserRec.FindSet() then
                        Message('You are not authorized to approve Gate Pass.')
                    else begin
                        if Status = Status::New then
                            Error('This Gate Pass has not sent for approval.')
                        else begin
                            if Status = Status::Approved then
                                Error('This Gate Pass has already approved.')
                            else begin
                                if Status = Status::Rejected then
                                    Error('This Gate Pass has already rejeted.')
                                else begin
                                    if ("Transfer From Code" = FactoryGB) and (Status = Status::"Pending Approval") then begin
                                        ApprovalSentToUser := '';
                                        Status := Status::Approved;
                                        "Approved By" := UserId;
                                        "Approved Date" := WorkDate();
                                        CurrPage.Update();
                                        Message('Gate Pass approved');
                                    end
                                    else
                                        Error('You are not authorized to approve this Gate Pass.');
                                end;
                            end
                        end
                    end;
                end;
            }

            action(Reject)
            {
                ApplicationArea = All;
                Image = Reject;

                trigger OnAction()
                var
                    UserRec: Record "User Setup";
                begin
                    UserRec.Reset();
                    UserRec.SetRange("User ID", UserId);
                    UserRec.SetFilter("GT Pass Approve", '=%1', true);

                    if not UserRec.FindSet() then
                        Message('You are not authorized to reject Gate Pass.')
                    else begin
                        if Status = Status::New then
                            Error('This Gate Pass has not sent for approval.')
                        else begin
                            if Status = Status::Approved then
                                Error('This Gate Pass has already approved.')
                            else begin
                                if Status = Status::Rejected then
                                    Error('This Gate Pass has already rejected.')
                                else begin
                                    if ("Transfer From Code" = FactoryGB) and (Status = Status::"Pending Approval") then begin
                                        ApprovalSentToUser := '';
                                        Status := Status::Rejected;
                                        "Approved By" := UserId;
                                        "Approved Date" := WorkDate();
                                        CurrPage.Update();
                                        Message('Gate Pass rejected');
                                    end
                                    else
                                        Error('You are not authorized to reject this Gate Pass.');
                                end;
                            end;
                        end;
                    end;
                end;
            }

            action("Print Gate Pass")
            {
                ApplicationArea = All;
                Image = Print;

                trigger OnAction()
                var
                    UserRec: Record "User Setup";
                    GatePassReport: Report GatePassReport;
                begin

                    if Status <> Status::Approved then
                        Error('Gate Pass has not approved yet. Cannot print.')
                    else begin
                        GatePassReport.Set_Value("No.");
                        GatePassReport.RunModal();
                    end;
                end;
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Gatepass Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        GatePassLineRec: Record "Gate Pass Line";
    begin
        GatePassLineRec.SetRange("No.", "No.");
        GatePassLineRec.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        if Status = Status::Approved then
            CurrPage.Editable(false)
        else begin
            UserRec.Reset();
            UserRec.SetRange("User ID", UserId);
            if UserRec.FindSet() then begin
                FactoryGB := UserRec."Factory Code";

                if "Transfer From Code" <> '' then begin
                    if (UserRec."Factory Code" = "Transfer From Code") then
                        CurrPage.Editable(true)
                    else
                        CurrPage.Editable(false);
                end
                else
                    CurrPage.Editable(true);
            end;
        end;
    end;


    var
        FactoryGB: Code[20];

}