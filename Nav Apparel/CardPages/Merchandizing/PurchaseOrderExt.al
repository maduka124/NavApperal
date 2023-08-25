pageextension 50997 PurchaseOrderCardExt extends "Purchase Order"
{
    layout
    {
        modify("Document Date")
        {
            trigger OnAfterValidate()
            var
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
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end
                else begin   //logged in
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end;
            end;
        }

        modify("Vendor Invoice No.")
        {
            trigger OnAfterValidate()
            var
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
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end
                else begin   //logged in
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end;

                // if Rec.Status = Rec.Status::Released then
                //     VisibleGB := true
                // else
                //     VisibleGB := false;
            end;
        }

        addlast(General)
        {
            field("Workflow User Group"; rec."Workflow User Group")
            {
                ApplicationArea = all;
            }

            //Mihiranga 2023/03/02
            field("Cost Center"; Rec."Cost Center")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = true;
            }

            field("Merchandizer Group Name"; rec."Merchandizer Group Name")
            {
                ApplicationArea = all;
                Editable = false;
            }

            // Done By SAchith on 28/03/23
            field("Secondary UserID"; Rec."Secondary UserID")
            {
                ApplicationArea = All;
                Caption = 'Merchandiser Name';
                Editable = false;
            }
        }

        // modify("Invoice Details")
        // {
        //     Editable = EditableGB;
        // }

        // modify("Shipping and Payment")
        // {
        //     Editable = EditableGB;
        // }

        // modify("Foreign Trade")
        // {
        //     Editable = EditableGB;
        // }

        // modify(Prepayment)
        // {
        //     Editable = EditableGB;
        // }

        // // modify("PurchLines")
        // // {
        // //     Editable = EditableGB;
        // // }
    }

    actions
    {
        modify("&Print")
        {
            Visible = false;
            // trigger OnBeforeAction()
            // var

            //     PurchaseorderReportRec: Report PurchaseOrderReportCard;
            // begin
            //     PurchaseorderReportRec.Set_value("No.");
            //     PurchaseorderReportRec.RunModal();
            // end;
        }

        addafter(Statistics)
        {
            action("Upload Lot Tracking Lines")
            {
                Image = CopySerialNo;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ExcelUpload: Codeunit "Customization Management";

                begin
                    if not Confirm('Do you want to upload the Serial lines?', false) then
                        exit;
                    ExcelUpload.ImportPurchaseTrackingExcel(Rec);
                end;
            }
        }

        addafter("Request Approval")
        {
            action("Purchase Order Report (Detail)")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    PurchaseorderReportRec: Report PurchaseOrderReportCard;
                begin
                    PurchaseorderReportRec.Set_value(rec."No.");
                    PurchaseorderReportRec.RunModal();
                end;
            }

            action("Purchase Order Report (Summary)")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    PurchaseorderReportSummaryRec: Report PurchaseOrderReportSummaryCard;
                begin
                    PurchaseorderReportSummaryRec.Set_value(rec."No.");
                    PurchaseorderReportSummaryRec.RunModal();
                end;
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    var
        POLineRec: Record "Purchase Line";
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.Get(UserId);

        if UserRec.UserRole = 'STORE USER' then begin
            if Rec.Status = Rec.Status::Released then begin
                //VisibleGB := true;

                if UserRec."Cost Center" = '' then
                    Error('Cost Center has not setup in the User Card.')
                else begin
                    //Header record
                    rec."Cost Center" := UserRec."Cost Center";

                    //Line records
                    POLineRec.Reset();
                    POLineRec.SetFilter("Document Type", '=%1', POLineRec."Document Type"::Order);
                    POLineRec.SetRange("Document No.", rec."No.");
                    if POLineRec.FindSet() then begin
                        repeat
                            POLineRec."Shortcut Dimension 2 Code" := UserRec."Cost Center";
                            POLineRec.Modify();
                        until POLineRec.Next() = 0;
                    end;
                    //CurrPage.Update();
                end;
            end;
        end;
        // else
        //     VisibleGB := false;
    end;


    //Mihiranga 2023/03/02
    trigger OnOpenPage()
    var
        POLineRec: Record "Purchase Line";
        UserRec: Record "User Setup";
    begin
        UserRec.Reset();
        UserRec.Get(UserId);

        if UserRec.UserRole = 'STORE USER' then begin
            if Rec.Status = Rec.Status::Released then begin

                if UserRec."Cost Center" = '' then
                    Error('Cost Center has not setup in the User Card.')
                else begin
                    //Header record
                    rec."Cost Center" := UserRec."Cost Center";

                    //Line records
                    POLineRec.Reset();
                    POLineRec.SetFilter("Document Type", '=%1', POLineRec."Document Type"::Order);
                    POLineRec.SetRange("Document No.", rec."No.");
                    if POLineRec.FindSet() then begin
                        repeat
                            POLineRec."Shortcut Dimension 2 Code" := UserRec."Cost Center";
                            POLineRec.Modify();
                        until POLineRec.Next() = 0;
                    end;
                    CurrPage.Update();
                end;
            end;
        end;
        // else
        //     VisibleGB := false;

    end;

    var
        EditableGB: Boolean;
        VisibleGB: Boolean;
}