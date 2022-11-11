pageextension 71012852 PurchaseOrderCardExt extends "Purchase Order"
{
    layout
    {
        modify(General)
        {
            Editable = EditableGB;
        }

        modify("Invoice Details")
        {
            Editable = EditableGB;
        }

        modify("Shipping and Payment")
        {
            Editable = EditableGB;
        }

        modify("Foreign Trade")
        {
            Editable = EditableGB;
        }

        modify(Prepayment)
        {
            Editable = EditableGB;
        }

        // modify("PurchLines")
        // {
        //     Editable = EditableGB;
        // }
    }
    actions
    {
        modify("&Print")
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
                PurchaseorderReportRec: Report PurchaseOrderReportCard;
            begin
                PurchaseorderReportRec.Set_value("No.");
                PurchaseorderReportRec.RunModal();
            end;
        }
    }
    trigger OnAfterGetCurrRecord()
    var
    begin
        if Status = Status::Released then
            EditableGb := false
        else
            EditableGb := true;
    end;

    var
        EditableGB: Boolean;
}