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

                if Rec.Status = Rec.Status::Released then
                    VisibleGB := true
                else
                    VisibleGB := false;
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
                Visible = VisibleGB;

                // trigger OnLookup(var Text: Text): Boolean
                // var
                //     DimensionRec: Record "Dimension Value";
                //     UserRec: Record "User Setup";
                // begin
                //     UserRec.Reset();
                //     UserRec.Get(UserId);
                //     // UserRec.SetRange(SystemCreatedBy, Rec.SystemCreatedBy);
                //     DimensionRec.Reset();
                //     if DimensionRec.FindSet() then begin
                //         repeat
                //             if UserRec."Cost Center" = DimensionRec."Dimension Code" then begin
                //                 if page.RunModal(560, DimensionRec) = Action::LookupOK then begin
                //                     Rec."Cost Center" := DimensionRec."Dimension Code";
                //                 end;
                //             end;

                //         until DimensionRec.Next() = 0;
                // // end;
                // // end;
                // // end;

                //         //
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
            action("Purchase Order Report")
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

        }
    }


    trigger OnAfterGetCurrRecord()
    var
    begin
        if rec.Status = rec.Status::Released then
            EditableGb := false
        else
            EditableGb := true;


    end;
    //Mihiranga 2023/03/02
    trigger OnOpenPage()
    var
        DimensionRec: Record "Dimension Value";
        UserRec: Record "User Setup";
    begin
        if Rec.Status = Rec.Status::Released then
            VisibleGB := true
        else
            VisibleGB := false;
        UserRec.Reset();
        UserRec.Get(UserId);
        DimensionRec.Reset();

        if DimensionRec.FindSet() then begin
            repeat
                if UserRec."Cost Center" = DimensionRec.Code then begin
                    // if page.RunModal(560, DimensionRec) = Action::LookupOK then begin
                    Rec."Cost Center" := UserRec."Cost Center";
                    // end;
                end;

            until DimensionRec.Next() = 0;

        end;
    end;
    ////

    var
        EditableGB: Boolean;
        VisibleGB: Boolean;
}