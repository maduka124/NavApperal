pageextension 50824 "Req.Worksheet Ext" extends "Req. Worksheet"
{
    layout
    {
        addafter("Location Code")
        {
            field("Department Name"; Rec."Department Name")
            {
                ApplicationArea = All;
            }

            field("Global Dimension Code"; Rec."Global Dimension Code")
            {
                ApplicationArea = All;
            }
        }

        addafter("Replenishment System")
        {
            field(SystemCreatedBy; rec."Created User Name")
            {
                Caption = 'Created By';
                Editable = false;
                ApplicationArea = All;
            }
            field(SystemCreatedAt; rec.SystemCreatedAt)
            {
                Caption = 'Created Date/Time';
                Editable = false;
                ApplicationArea = All;
            }
            field(SystemModifiedBy; rec."Modified User Name")
            {
                Caption = 'Modified By';
                Editable = false;
                ApplicationArea = All;
            }
            field(SystemModifiedAt; rec.SystemModifiedAt)
            {
                Caption = 'Modified Date/Time';
                Editable = false;
                ApplicationArea = All;
            }
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if rec."Created User Name" = '' then begin
                    rec."Created User Name" := UserId;
                    rec."Modified User Name" := UserId;
                end
            end;
        }

        // Done By Sachith on 02/02/23
        addafter("Vendor No.")
        {
            field("Vendor Name"; Rec."Vendor Name")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addafter(CarryOutActionMessage)
        {
            action("Load Req. Items")
            {
                Caption = 'Load Req. Items';
                Image = AddAction;
                ApplicationArea = All;

                trigger OnAction();
                var
                    DeptReqHeaderRec: Record DeptReqSheetHeader;
                    DeptReqLineRec: Record DeptReqSheetLine;
                    RequLineRec: Record "Requisition Line";
                    RequLineRec1: Record "Requisition Line";
                    ReqLineNo: BigInteger;
                    NavAppSetupRec: Record "NavApp Setup";
                    LoginSessionsRec: Record LoginSessions;
                    LoginRec: Page "Login Card";
                begin

                    //Check whether user logged in or not
                    LoginSessionsRec.Reset();
                    LoginSessionsRec.SetRange(SessionID, SessionId());

                    if not LoginSessionsRec.FindSet() then begin  //not logged in
                        Clear(LoginRec);
                        LoginRec.LookupMode(true);
                        LoginRec.RunModal();

                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());
                        LoginSessionsRec.FindSet();
                    end;


                    NavAppSetupRec.Reset();
                    NavAppSetupRec.FindSet();

                    //Get max line no
                    RequLineRec.Reset();
                    RequLineRec.SetRange("Worksheet Template Name", rec."Worksheet Template Name");
                    RequLineRec.SetRange("Journal Batch Name", rec."Journal Batch Name");

                    // RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Req Worksheet Template Name");
                    // RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Req Journal Batch Name");

                    if RequLineRec.FindLast() then
                        ReqLineNo := RequLineRec."Line No.";

                    DeptReqLineRec.Reset();
                    DeptReqLineRec.SetCurrentKey("Item No");
                    DeptReqLineRec.Ascending(true);
                    DeptReqLineRec.SetFilter("Qty to Received", '>%1', 0);
                    DeptReqLineRec.SetFilter("Item No", '<>%1', '');
                    DeptReqLineRec.SetFilter("PO Raized", '=%1', false);

                    if DeptReqLineRec.FindSet() then begin

                        repeat
                            DeptReqHeaderRec.Reset();
                            DeptReqHeaderRec.SetRange("Req No", DeptReqLineRec."Req No");
                            if DeptReqHeaderRec.FindSet() then begin

                                if DeptReqHeaderRec.Status = DeptReqHeaderRec.Status::Approved then begin
                                    RequLineRec.Reset();
                                    RequLineRec.SetCurrentKey("Worksheet Template Name", "Journal Batch Name", "No.");
                                    // RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Req Worksheet Template Name");
                                    // RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Req Journal Batch Name");
                                    RequLineRec.SetRange("Worksheet Template Name", rec."Worksheet Template Name");
                                    RequLineRec.SetRange("Journal Batch Name", rec."Journal Batch Name");
                                    RequLineRec.SetFilter(Type, '=%1', RequLineRec.Type::Item);
                                    RequLineRec.SetRange("No.", DeptReqLineRec."Item No");
                                    RequLineRec.SetRange("CP Req Code", DeptReqLineRec."Req No");

                                    if not RequLineRec.FindSet() then begin    //Not existing items

                                        ReqLineNo += 1;
                                        RequLineRec1.Init();
                                        // RequLineRec1."Worksheet Template Name" := NavAppSetupRec."Req Worksheet Template Name";
                                        // RequLineRec1."Journal Batch Name" := NavAppSetupRec."Req Journal Batch Name";
                                        RequLineRec1."Worksheet Template Name" := rec."Worksheet Template Name";
                                        RequLineRec1."Journal Batch Name" := rec."Journal Batch Name";
                                        RequLineRec1."Line No." := ReqLineNo;
                                        RequLineRec1.Type := RequLineRec.Type::Item;
                                        RequLineRec1.Validate("No.", DeptReqLineRec."Item No");
                                        RequLineRec1."Action Message" := RequLineRec."Action Message"::New;
                                        RequLineRec1."Accept Action Message" := true;
                                        RequLineRec1."Ending Date" := Today + 7;
                                        RequLineRec1.Quantity := DeptReqLineRec."Qty to Received";
                                        RequLineRec1.Validate("Location Code", DeptReqHeaderRec."Factory Code");
                                        RequLineRec1."Department Code" := DeptReqHeaderRec."Department Code";
                                        RequLineRec1."Department Name" := DeptReqHeaderRec."Department Name";
                                        RequLineRec1.Validate("Global Dimension Code", DeptReqHeaderRec."Global Dimension Code");
                                        RequLineRec1.Validate("Shortcut Dimension 1 Code", DeptReqHeaderRec."Global Dimension Code");
                                        RequLineRec1.EntryType := RequLineRec1.EntryType::"Central Purchasing";
                                        RequLineRec1."CP Req Code" := DeptReqLineRec."Req No";
                                        RequLineRec1."CP Line" := DeptReqLineRec."Line No";
                                        RequLineRec1."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                                        RequLineRec1.Insert();
                                    end;
                                end;
                            end;
                        until DeptReqLineRec.Next() = 0;

                        CurrPage.Update();

                    end;
                end;
            }
        }

        addafter(CalculatePlan)
        {
            action("Merge Lines")
            {
                ApplicationArea = All;
                Image = GetLines;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CustMangement: Codeunit "Customization Management";
                begin
                    if not Confirm('Do you want to process the line merge?', false) then
                        exit;
                    CustMangement.MergePlanningLines(rec."Worksheet Template Name", rec."Journal Batch Name");
                end;
            }
        }

        modify(CarryOutActionMessage)
        {
            trigger OnBeforeAction()
            var
                RequLineRec: Record "Requisition Line";
                NavAppSetupRec: Record "NavApp Setup";
                DeptReqSheetLineRec: Record DeptReqSheetLine;
            begin
                NavAppSetupRec.Reset();
                NavAppSetupRec.FindSet();

                RequLineRec.Reset();
                RequLineRec.SetCurrentKey("Worksheet Template Name", "Journal Batch Name", "No.");
                RequLineRec.SetRange("Worksheet Template Name", rec."Worksheet Template Name");
                RequLineRec.SetRange("Journal Batch Name", rec."Journal Batch Name");
                //  RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Req Worksheet Template Name");
                // RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Req Journal Batch Name");
                RequLineRec.SetFilter(Type, '=%1', RequLineRec.Type::Item);
                RequLineRec.SetFilter("Accept Action Message", '=%1', true);

                if RequLineRec.FindSet() then begin
                    repeat
                        DeptReqSheetLineRec.Reset();
                        DeptReqSheetLineRec.SetRange("Req No", RequLineRec."CP Req Code");
                        DeptReqSheetLineRec.SetRange("Item No", RequLineRec."No.");

                        if DeptReqSheetLineRec.FindSet() then begin
                            DeptReqSheetLineRec."PO Raized" := true;
                            DeptReqSheetLineRec.Modify();
                        end;
                    until RequLineRec.Next() = 0;

                    Commit();
                end
            end;


            trigger OnAfterAction()
            var
                RequLineRec: Record "Requisition Line";
                NavAppSetupRec: Record "NavApp Setup";
                DeptReqSheetLineRec: Record DeptReqSheetLine;
            begin
                NavAppSetupRec.Reset();
                NavAppSetupRec.FindSet();

                RequLineRec.Reset();
                RequLineRec.SetCurrentKey("Worksheet Template Name", "Journal Batch Name", "No.");
                // RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Req Worksheet Template Name");
                // RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Req Journal Batch Name");
                RequLineRec.SetRange("Worksheet Template Name", rec."Worksheet Template Name");
                RequLineRec.SetRange("Journal Batch Name", rec."Journal Batch Name");
                RequLineRec.SetFilter(Type, '=%1', RequLineRec.Type::Item);
                RequLineRec.SetFilter("Accept Action Message", '=%1', true);

                if RequLineRec.FindSet() then begin
                    repeat
                        DeptReqSheetLineRec.Reset();
                        DeptReqSheetLineRec.SetRange("Req No", RequLineRec."CP Req Code");
                        DeptReqSheetLineRec.SetRange("Item No", RequLineRec."No.");

                        if DeptReqSheetLineRec.FindSet() then begin
                            DeptReqSheetLineRec."PO Raized" := false;
                            DeptReqSheetLineRec.Modify();
                        end;
                    until RequLineRec.Next() = 0;

                    Commit();
                end
            end;
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if rec."Journal Batch Name" <> UserSetup."Req. Worksheet Batch" then
            Error('You do not have permission');
    end;

    trigger OnModifyRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if rec."Journal Batch Name" <> UserSetup."Req. Worksheet Batch" then
            Error('You do not have permission');

        rec."Modified User Name" := UserId;
    end;
}