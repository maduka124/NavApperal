pageextension 50686 SalesOrderPageExt extends "Sales Order Subform"
{
    layout
    {
        modify("Qty. to Ship")
        {

            trigger OnAfterValidate()
            var
                SalesLineRec: Record "Sales Line";
            begin
                //Get total qty to ship / value
                "Total Quantity to Ship" := 0;
                "Total Value to Ship" := 0;
                SalesLineRec.Reset();
                SalesLineRec.SetRange("Document No.", rec."Document No.");
                SalesLineRec.SetFilter("Document Type", '=%1', SalesLineRec."Document Type"::Order);
                SalesLineRec.SetFilter(Type, '=%1', SalesLineRec.Type::Item);
                if SalesLineRec.FindSet() then
                    repeat
                        "Total Quantity to Ship" += SalesLineRec."Qty. to Ship";
                        "Total Value to Ship" += SalesLineRec."Qty. to Ship" * SalesLineRec."Unit Price";
                    until SalesLineRec.Next() = 0;
            end;
        }

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

            field("Total Quantity to Ship"; "Total Quantity to Ship")
            {
                ApplicationArea = all;
                Caption = 'Total Qty. To Ship';
                Editable = false;
                ToolTip = 'Specifies the sum of Qty To Ship on all lines in the document.';
            }

            field("Total Value to Ship"; "Total Value to Ship")
            {
                ApplicationArea = all;
                Caption = 'Total Value To Ship';
                Editable = false;
                ToolTip = 'Specifies the sum of Value To Ship on all lines in the document.';
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        SalesInvLineRec: Record "Sales Invoice Line";
        SalesLineRec: Record "Sales Line";
    begin
        //get Total shipped Qty
        SalesInvLineRec.Reset();
        SalesInvLineRec.SetRange("Order No.", rec."Document No.");
        SalesInvLineRec.SetFilter(Type, '=%1', SalesInvLineRec.Type::Item);
        SalesInvLineRec.CalcSums(Quantity);
        "Total Quantity_Shipped" := SalesInvLineRec.Quantity;

        //Get total qty to ship / value
        "Total Quantity to Ship" := 0;
        "Total Value to Ship" := 0;
        SalesLineRec.Reset();
        SalesLineRec.SetRange("Document No.", rec."Document No.");
        SalesLineRec.SetFilter("Document Type", '=%1', SalesLineRec."Document Type"::Order);
        SalesLineRec.SetFilter(Type, '=%1', SalesLineRec.Type::Item);
        if SalesLineRec.FindSet() then
            repeat
                "Total Quantity to Ship" += SalesLineRec."Qty. to Ship";
                "Total Value to Ship" += SalesLineRec."Qty. to Ship" * SalesLineRec."Unit Price";
            until SalesLineRec.Next() = 0;
    end;


    var
        "Total Quantity_Shipped": BigInteger;
        "Total Quantity to Ship": BigInteger;
        "Total Value to Ship": Decimal;
}