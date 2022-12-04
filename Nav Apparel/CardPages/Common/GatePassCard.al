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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Gate Pass No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Vehicle No."; rec."Vehicle No.")
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle No';
                }

                field("Transfer Date"; rec."Transfer Date")
                {
                    ApplicationArea = All;
                }

                field(Type; rec.Type)
                {
                    ApplicationArea = All;
                }

                field("Transfer From Name"; rec."Transfer From Name")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer From';
                    Editable = false;
                }

                field("Transfer To Name"; rec."Transfer To Name")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer To';

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                        ExtLocationRec: Record ExternalLocations;
                    begin

                        if (rec.Type = rec.Type::Internal) then begin
                            LocationRec.Reset();
                            LocationRec.SetRange(name, rec."Transfer To Name");
                            if LocationRec.FindSet() then
                                rec."Transfer To Code" := LocationRec.Code;

                            rec.FromToFactoryCodes := rec."Transfer From Code" + '/' + LocationRec.Code;
                        end
                        else begin
                            ExtLocationRec.Reset();
                            ExtLocationRec.SetRange("location Name", rec."Transfer To Name");
                            if ExtLocationRec.FindSet() then
                                rec."Transfer To Code" := ExtLocationRec."Location Code";

                            rec.FromToFactoryCodes := rec."Transfer From Code" + '/' + ExtLocationRec."Location Code";
                        end;

                        CurrPage.Update();
                    end;
                }

                field("Expected Return Date"; rec."Expected Return Date")
                {
                    ApplicationArea = All;
                }

                field("Sent By"; rec."Sent By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Approved By"; rec."Approved By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Approved/Rejected By';
                }

                field("Approved Date"; rec."Approved Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Approved/Rejected Date';
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Remarks; rec.Remarks)
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
                    if (rec.Status = rec.Status::New) or (rec.Status = rec.Status::Rejected) then begin
                        if rec."Transfer From Code" = FactoryGB then begin
                            UserRec.Reset();
                            UserRec.SetRange("Factory Code", FactoryGB);
                            UserRec.SetFilter("GT Pass Approve", '=%1', true);
                            if not UserRec.FindSet() then
                                Error('Approval user for factory : %1 has not setup.', rec."Transfer From Name")
                            else begin
                                rec.ApprovalSentToUser := UserRec."User ID";
                                rec."Approved By" := '';
                                rec."Approved Date" := 0D;
                                rec.Status := rec.Status::"Pending Approval";
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
                        if rec.Status = rec.Status::New then
                            Error('This Gate Pass has not sent for approval.')
                        else begin
                            if rec.Status = rec.Status::Approved then
                                Error('This Gate Pass has already approved.')
                            else begin
                                if rec.Status = rec.Status::Rejected then
                                    Error('This Gate Pass has already rejeted.')
                                else begin
                                    if (rec."Transfer From Code" = FactoryGB) and (rec.Status = rec.Status::"Pending Approval") then begin
                                        rec.ApprovalSentToUser := '';
                                        rec.Status := rec.Status::Approved;
                                        rec."Approved By" := UserId;
                                        rec."Approved Date" := WorkDate();
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
                        if rec.Status = rec.Status::New then
                            Error('This Gate Pass has not sent for approval.')
                        else begin
                            if rec.Status = rec.Status::Approved then
                                Error('This Gate Pass has already approved.')
                            else begin
                                if rec.Status = rec.Status::Rejected then
                                    Error('This Gate Pass has already rejected.')
                                else begin
                                    if (rec."Transfer From Code" = FactoryGB) and (rec.Status = rec.Status::"Pending Approval") then begin
                                        rec.ApprovalSentToUser := '';
                                        rec.Status := rec.Status::Rejected;
                                        rec."Approved By" := UserId;
                                        rec."Approved Date" := WorkDate();
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

                    if rec.Status <> rec.Status::Approved then
                        Error('Gate Pass has not approved yet. Cannot print.')
                    else begin
                        GatePassReport.Set_Value(rec."No.");
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Gatepass Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        GatePassLineRec: Record "Gate Pass Line";
    begin
        GatePassLineRec.SetRange("No.", rec."No.");
        GatePassLineRec.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        if rec.Status = rec.Status::Approved then
            CurrPage.Editable(false)
        else begin
            UserRec.Reset();
            UserRec.SetRange("User ID", UserId);
            if UserRec.FindSet() then begin
                FactoryGB := UserRec."Factory Code";

                if rec."Transfer From Code" <> '' then begin
                    if (UserRec."Factory Code" = rec."Transfer From Code") then
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