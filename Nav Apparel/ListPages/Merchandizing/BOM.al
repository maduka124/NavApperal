page 71012679 "BOM"
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

                field("No."; "No")
                {
                    ApplicationArea = All;
                    Caption = 'BOM No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                }

                field("Brand Name"; "Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Garment Type Name"; "Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                }

                field(Quantity; Quantity)
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
        BOMAUTOProdBOMRec.SetRange("No.", No);

        if BOMAUTOProdBOMRec.FindSet() then
            Error('"Write TO MRP" process has been completed. You cannot delete the BOM.');


        BOMPOSelectionRec.SetRange("BOM No.", "No");
        BOMPOSelectionRec.DeleteAll();

        BOMLineEstRec.SetRange("No.", "No");
        BOMLineEstRec.DeleteAll();

        BOMLineRec.SetRange("No.", "No");
        BOMLineRec.DeleteAll();

        BOMAUTORec.SetRange("No.", "No");
        BOMAUTORec.DeleteAll();

        BOMRec.SetRange("No", "No");
        BOMRec.DeleteAll();
    end;
}