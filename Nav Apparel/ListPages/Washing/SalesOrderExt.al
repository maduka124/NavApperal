pageextension 50686 SalesOrderPageExt extends "Sales Order Subform"
{
    layout
    {
        addbefore("Total Amount Excl. VAT")
        {
            field("Total Quantity_TNG"; TotalSalesLine.Quantity)
            {
                ApplicationArea = all;
                DecimalPlaces = 0 : 5;
                Caption = 'Total Quantity';
                Editable = false;
                ToolTip = 'Specifies the sum of the quantity on all lines in the document.';
            }

            field("Total Quantity_Shipped"; "Total Quantity_Shipped")
            {
                ApplicationArea = all;
                Caption = 'Total Qty. Shipped';
                Editable = false;
                ToolTip = 'Specifies the sum of shipped quantity on all lines in the document.';
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        SalesLineRec: Record "Sales Invoice Line";
    begin
        SalesLineRec.Reset();
        SalesLineRec.SetRange("Order No.", rec."Document No.");
        SalesLineRec.SetFilter(Type, '=%1', SalesLineRec.Type::Item);
        SalesLineRec.CalcSums(Quantity);
        "Total Quantity_Shipped" := SalesLineRec.Quantity;
    end;


    var
        "Total Quantity_Shipped": BigInteger;
}