page 51022 "BOM"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = BOM;
    SourceTableView = sorting(No) order(descending);
    CardPageId = "BOM Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field("No."; rec."No")
                {
                    ApplicationArea = All;
                    Caption = 'BOM No';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Store Name"; rec."Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                }

                field("Brand Name"; rec."Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                }

                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        BOMPOSelectionRec: Record BOMPOSelection;
        BOMLineEstRec: Record "BOM Line Estimate";
        BOMLineRec: Record "BOM Line";
        BOMRec: Record BOM;
        BOMAUTORec: Record "BOM Line AutoGen";
        BOMAUTOProdBOMRec: Record "BOM Line AutoGen ProdBOM";
    begin

        BOMAUTOProdBOMRec.Insert();
        BOMAUTOProdBOMRec.SetRange("No.", rec.No);

        if BOMAUTOProdBOMRec.FindSet() then
            Error('"Write TO MRP" process has been completed. You cannot delete the BOM.');


        BOMPOSelectionRec.SetRange("BOM No.", rec."No");
        BOMPOSelectionRec.DeleteAll();

        BOMLineEstRec.SetRange("No.", rec."No");
        BOMLineEstRec.DeleteAll();

        BOMLineRec.SetRange("No.", rec."No");
        BOMLineRec.DeleteAll();

        BOMAUTORec.SetRange("No.", rec."No");
        BOMAUTORec.DeleteAll();

        BOMRec.SetRange("No", rec."No");
        BOMRec.DeleteAll();
    end;
}