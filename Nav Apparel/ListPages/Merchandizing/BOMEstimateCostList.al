page 50267 "BOM Estimate Cost"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "BOM Estimate Cost";
    CardPageId = "BOM Estimate Cost Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Cost Sheet No';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }

                field("BOM No."; "BOM No.")
                {
                    ApplicationArea = All;
                    Caption = 'BOM No';
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

                field("Store Name"; "Store Name")
                {
                    ApplicationArea = All;
                    Caption = 'Store';
                }

                field("Brand Name"; "Brand Name")
                {
                    ApplicationArea = All;
                    Caption = 'Brand';
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                    Caption = 'Season';
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
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

                field("Currency No."; "Currency No.")
                {
                    ApplicationArea = All;
                    Caption = 'Currency';
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        BOMEstimateCostRec: Record "BOM Estimate Cost";
        BOMEstCostLineRec: Record "BOM Estimate Costing Line";
    begin
        BOMEstimateCostRec.SetRange("No.", "No.");
        BOMEstimateCostRec.DeleteAll();

        BOMEstCostLineRec.SetRange("No.", "No.");
        BOMEstCostLineRec.DeleteAll();
    end;
}