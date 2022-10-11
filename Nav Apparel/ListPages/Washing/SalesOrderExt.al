pageextension 50686 SalesOrderPageExt extends "Sales Order Subform"
{
    layout
    {
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                SalesLineRec: Record "Sales Line";
                TotalQty: Integer;
            begin
                SalesLineRec.Reset();
                SalesLineRec.SetRange("Document Type", "Document Type");
                SalesLineRec.SetRange("Document No.", "Document No.");

                if SalesLineRec.FindSet() then begin
                    // TotalQty := 0;
                    repeat
                        TotalQty += SalesLineRec.Quantity;
                    until SalesLineRec.Next() = 0;

                    "Total Qty" := TotalQty;
                    CurrPage.Update();
                end;

            end;
        }
        addafter("Invoice Disc. Pct.")
        {
            field("Total Qty"; "Total Qty")
            {
                ApplicationArea = All;
                Editable = false;

                // trigger OnValidate()
                // var

                //     TotalQty: Integer;
                // begin

                //     SalesLineRec.Reset();
                //     SalesLineRec.SetRange("", "No.");

                //     if SalesLineRec.FindSet() then
                //         repeat
                //              += SalesLineRec.Quantity;
                //             "Total Qty" := TotalQty;

                //             // SalesLineRec.Modify();
                //             CurrPage.Update();
                //         until SalesLineRec.Next() = 0;

                // end;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }


    trigger OnOpenPage()
    var
        SalesLineRec: Record "Sales Line";
        TotalQty: Integer;
    begin
        SalesLineRec.Reset();
        SalesLineRec.SetRange("Document Type", "Document Type");
        SalesLineRec.SetRange("Document No.", "Document No.");
        //SalesLineRec.SetRange("Line No.", "Line No.");

        if SalesLineRec.FindSet() then begin
            repeat
                TotalQty += SalesLineRec.Quantity;
            until SalesLineRec.Next() = 0;
            "Total Qty" := TotalQty;
            //SalesLineRec.Modify();
        end;

    end;
}