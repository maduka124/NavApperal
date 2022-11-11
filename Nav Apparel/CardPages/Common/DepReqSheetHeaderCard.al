page 50709 "DepReqSheetHeaderCard"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = DeptReqSheetHeader;
    Caption = 'Department Requisition Sheet';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Req No"; "Req No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                        DepRec: Record Department;
                        userRec: Record "User Setup";
                        locationRec: Record Location;
                    begin

                        DepRec.Reset();
                        DepRec.SetRange("Department Name", "Department Name");

                        if DepRec.FindSet() then
                            "Department Code" := DepRec."No.";

                        userRec.Reset();
                        userRec.SetRange("User ID", UserId);

                        if userRec.FindSet() then begin
                            "Factory Code" := userRec."Factory Code";
                            "Global Dimension Code" := userRec."Global Dimension Code";
                        end;

                        locationRec.Reset();
                        locationRec.SetRange(Code, "Factory Code");

                        if locationRec.FindSet() then
                            "Factory Name" := locationRec.Name;
                    end;
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                    Editable = false;
                }

                field("Request Date"; "Request Date")
                {
                    ApplicationArea = All;
                    Editable = EditableGb;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    Editable = EditableGb;
                }

                field("Global Dimension Code"; "Global Dimension Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Completely Received"; "Completely Received")
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
            }

            group("")
            {
                part(DepReqSheetListpart; DepReqSheetListpart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Req No" = field("Req No");
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
                        UserRec.Reset();
                        UserRec.SetRange("Factory Code", FactoryGB);
                        UserRec.SetFilter("Purchasing Approval", '=%1', true);
                        if not UserRec.FindSet() then
                            Error('Approval user for factory : %1 has not setup.', FactoryGB)
                        else begin
                            //ApprovalSentToUser := UserRec."User ID";
                            "Approved By" := '';
                            "Approved Date" := 0D;
                            Status := Status::"Pending Approval";
                            CurrPage.Update();
                            Message('Sent to approval');
                        end;
                    end
                    else
                        Message('This request has been already sent for approval or already approved.');
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
                    UserRec.SetFilter("Purchasing Approval", '=%1', true);

                    if not UserRec.FindSet() then
                        Message('You are not authorized to approve this request.')
                    else begin
                        if Status = Status::New then
                            Error('This request has not sent for approval.')
                        else begin
                            if Status = Status::Approved then
                                Error('This request has already approved.')
                            else begin
                                if Status = Status::Rejected then
                                    Error('This request has already rejeted.')
                                else begin
                                    if (Status = Status::"Pending Approval") then begin
                                        //ApprovalSentToUser := '';
                                        Status := Status::Approved;
                                        "Approved By" := UserId;
                                        "Approved Date" := WorkDate();
                                        CurrPage.Update();
                                        Message('Request approved');
                                    end
                                    else
                                        Error('You are not authorized to approve this request.');
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
                    UserRec.SetFilter("Purchasing Approval", '=%1', true);

                    if not UserRec.FindSet() then
                        Message('You are not authorized to reject requests.')
                    else begin
                        if Status = Status::New then
                            Error('This request has not sent for approval.')
                        else begin
                            if Status = Status::Approved then
                                Error('This request has already approved.')
                            else begin
                                if Status = Status::Rejected then
                                    Error('This request has already rejected.')
                                else begin
                                    if (Status = Status::"Pending Approval") then begin
                                        //ApprovalSentToUser := '';
                                        Status := Status::Rejected;
                                        "Approved By" := UserId;
                                        "Approved Date" := WorkDate();
                                        CurrPage.Update();
                                        Message('Request rejected');
                                    end
                                    else
                                        Error('You are not authorized to reject this request.');
                                end;
                            end;
                        end;
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."DepReq No", xRec."Req No", "Req No") THEN BEGIN
            NoSeriesMngment.SetSeries("Req No");
            EXIT(TRUE);
        END;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        DeptReqSheetLine: Record DeptReqSheetLine;
    begin

        DeptReqSheetLine.Reset();
        DeptReqSheetLine.SetRange("Req No", "Req No");
        if DeptReqSheetLine.FindSet() then
            DeptReqSheetLine.DeleteAll();

    end;


    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        if ("Completely Received" = "Completely Received"::Yes) or (Status = Status::Approved) then
            EditableGb := false
        else
            EditableGb := true;

        UserRec.Reset();
        UserRec.SetRange("User ID", UserId);
        if UserRec.FindSet() then begin
            FactoryGB := UserRec."Factory Code";
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
    begin
        if "Completely Received" = "Completely Received"::Yes then
            EditableGb := false
        else
            EditableGb := true;
    end;


    var
        EditableGb: Boolean;
        FactoryGB: Code[20];

}