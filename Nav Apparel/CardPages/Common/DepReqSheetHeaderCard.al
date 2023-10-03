page 50709 "DepReqSheetHeaderCard"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = DeptReqSheetHeader;
    Caption = 'Department Requisition Sheet Copy';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = EditableGb;
                field("Req No"; rec."Req No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                        DepRec: Record Department;
                        userRec: Record "User Setup";
                        locationRec: Record Location;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin

                        DepRec.Reset();
                        DepRec.SetRange("Department Name", rec."Department Name");
                        if DepRec.FindSet() then
                            rec."Department Code" := DepRec."No.";

                        userRec.Reset();
                        userRec.SetRange("User ID", UserId);
                        if userRec.FindSet() then begin
                            rec."Factory Code" := userRec."Factory Code";
                            rec."Global Dimension Code" := userRec."Global Dimension Code";
                        end;

                        locationRec.Reset();
                        locationRec.SetRange(Code, rec."Factory Code");
                        if locationRec.FindSet() then
                            rec."Factory Name" := locationRec.Name;

                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());
                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;
                    end;
                }

                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                    Editable = false;
                }

                field("Request Date"; rec."Request Date")
                {
                    ApplicationArea = All;
                    Editable = EditableGb;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = All;
                    Editable = EditableGb;
                }

                field("Global Dimension Code"; rec."Global Dimension Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Completely Received"; rec."Completely Received")
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
            }

            group("")
            {
                part(DepReqSheetListpart; DepReqSheetListpart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "Req No" = field("Req No");
                    Editable = EditableGb;
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
                        UserRec.Reset();
                        UserRec.SetRange("Factory Code", FactoryGB);
                        UserRec.SetFilter("Purchasing Approval", '=%1', true);
                        if not UserRec.FindSet() then
                            Error('Approval user for factory : %1 has not setup.', FactoryGB)
                        else begin
                            //ApprovalSentToUser := UserRec."User ID";
                            rec."Approved By" := '';
                            rec."Approved Date" := 0D;
                            rec.Status := rec.Status::"Pending Approval";
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
                        if rec.Status = rec.Status::New then
                            Error('This request has not sent for approval.')
                        else begin
                            if rec.Status = rec.Status::Approved then
                                Error('This request has already approved.')
                            else begin
                                if rec.Status = rec.Status::Rejected then
                                    Error('This request has already rejeted.')
                                else begin
                                    if (rec.Status = rec.Status::"Pending Approval") then begin
                                        //ApprovalSentToUser := '';
                                        rec.Status := rec.Status::Approved;
                                        rec."Approved By" := UserId;
                                        rec."Approved Date" := WorkDate();
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
                        if rec.Status = rec.Status::New then
                            Error('This request has not sent for approval.')
                        else begin
                            if rec.Status = rec.Status::Approved then
                                Error('This request has already approved.')
                            else begin
                                if rec.Status = rec.Status::Rejected then
                                    Error('This request has already rejected.')
                                else begin
                                    if (rec.Status = rec.Status::"Pending Approval") then begin
                                        //ApprovalSentToUser := '';
                                        rec.Status := rec.Status::Rejected;
                                        rec."Approved By" := UserId;
                                        rec."Approved Date" := WorkDate();
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
            action(Copy)
            {
                ApplicationArea = all;
                Image = Copy;
                trigger OnAction()
                var
                    DepReqHRec: Record DeptReqSheetHeader;
                    DepReqSheetHRec: Record DeptReqSheetHeader;
                    DepReqLine: Record DeptReqSheetLine;
                    DepreqLineCopy: Record DeptReqSheetLine;
                    NoSeriesManagementCode: Codeunit NoSeriesManagement;
                    NavAppSetupRec: Record "NavApp Setup";
                    UserRec: Record "User Setup";
                    NextReqNo: Code[20];
                begin
                    DepReqSheetHRec.Reset();
                    DepReqSheetHRec.SetRange("Req No", Rec."Req No");
                    DepReqSheetHRec.SetFilter(Copy, '=%1', 1);
                    if DepReqSheetHRec.FindSet() then begin
                        Error('This Req already copied');
                    end;

                    // DepReqHRec.Reset();
                    // DepReqHRec.SetRange("Req No", Rec."Req No");
                    // if DepReqHRec.FindSet() then begin
                    // end;

                    NavAppSetupRec.Reset();
                    NavAppSetupRec.FindSet();

                    NextReqNo := NoSeriesManagementCode.GetNextNo(NavAppSetupRec."DepReq No", Today(), true);

                    DepReqSheetHRec.Init();
                    DepReqSheetHRec."Req No" := NextReqNo;
                    DepReqSheetHRec."Department Code" := Rec."Department Code";
                    DepReqSheetHRec."Department Name" := Rec."Department Name";
                    DepReqSheetHRec."Factory Code" := Rec."Factory Code";
                    DepReqSheetHRec."Factory Name" := Rec."Factory Name";
                    DepReqSheetHRec."Request Date" := Rec."Request Date";
                    DepReqSheetHRec.Remarks := Rec.Remarks;
                    DepReqSheetHRec."Completely Received" := Rec."Completely Received";
                    DepReqSheetHRec."Approved By" := '';
                    DepReqSheetHRec."Approved Date" := 0D;
                    DepReqSheetHRec.Status := DepReqSheetHRec.Status::New;
                    DepReqSheetHRec.Copy := 1;
                    DepReqSheetHRec.Insert();


                    DepReqLine.Reset();
                    DepReqLine.SetRange("Req No", Rec."Req No");
                    if DepReqLine.FindSet() then begin
                        repeat


                            DepreqLineCopy.Init();
                            DepreqLineCopy."Req No" := NextReqNo;
                            DepreqLineCopy."Line No" := DepReqLine."Line No";
                            DepreqLineCopy."Main Category No." := DepReqLine."Main Category No.";
                            DepreqLineCopy."Main Category Name" := DepReqLine."Main Category Name";
                            DepreqLineCopy."Item No" := DepReqLine."Item No";
                            DepreqLineCopy."Item Name" := DepReqLine."Item Name";
                            DepreqLineCopy."Sub Category No." := DepReqLine."Sub Category No.";
                            DepreqLineCopy."Sub Category Name" := DepReqLine."Sub Category Name";
                            DepreqLineCopy."Article No." := DepReqLine."Article No.";
                            DepreqLineCopy.Article := DepReqLine.Article;
                            DepreqLineCopy."Size Range No." := DepReqLine."Size Range No.";
                            DepreqLineCopy."Dimension No." := DepReqLine."Dimension No.";
                            DepreqLineCopy."Dimension Name." := DepReqLine."Dimension Name.";
                            DepreqLineCopy.Other := DepReqLine.Other;
                            DepreqLineCopy.UOM := DepReqLine.UOM;
                            DepreqLineCopy."UOM Code" := DepReqLine."UOM Code";
                            DepreqLineCopy.Qty := DepReqLine.Qty;
                            DepreqLineCopy."Qty Received" := DepReqLine."Qty Received";
                            DepreqLineCopy."Qty to Received" := DepReqLine."Qty to Received";
                            DepreqLineCopy.Remarks := DepReqLine.Remarks;
                            DepreqLineCopy."PO Raized" := false;
                            DepreqLineCopy.Copy := 1;
                            DepreqLineCopy.Insert();

                        until DepReqLine.Next() = 0;

                        CurrPage.Update();
                    end;
                    Message('Data Copied');
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."DepReq No", xRec."Req No", rec."Req No") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."Req No");
            EXIT(TRUE);
        END;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        DeptReqSheetLine: Record DeptReqSheetLine;
    begin
        DeptReqSheetLine.Reset();
        DeptReqSheetLine.SetRange("Req No", rec."Req No");
        if DeptReqSheetLine.FindSet() then
            DeptReqSheetLine.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        UserRec: Record "User Setup";
    begin
        // if (rec."Completely Received" = rec."Completely Received"::Yes) or (rec.Status = rec.Status::Approved) then
        if rec.Status = rec.Status::Approved then
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
        // if rec."Completely Received" = rec."Completely Received"::Yes then
        //     EditableGb := false
        // else
        //     EditableGb := true;

        if rec.Status = rec.Status::Approved then
            EditableGb := false
        else
            EditableGb := true;
    end;


    var
        EditableGb: Boolean;
        FactoryGB: Code[20];
}