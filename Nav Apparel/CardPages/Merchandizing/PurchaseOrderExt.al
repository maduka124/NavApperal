pageextension 71012852 PurchaseOrderCardExt extends "Purchase Order"
{
    layout
    {
        // modify(General)
        // {
        //     Editable = EditableGB;
        // }

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

    var
        EditableGB: Boolean;
}