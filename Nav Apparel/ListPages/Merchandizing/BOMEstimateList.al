page 71012693 "Estimate BOM"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "BOM Estimate";
    CardPageId = "BOM Estimate Card";

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
                    Caption = 'BOM Estimate No';
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

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';
                }

                // field(Revision; Revision)
                // {
                //     ApplicationArea = All;
                // }

                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }

                field("Currency No."; "Currency No.")
                {
                    ApplicationArea = All;
                    Caption = 'Currency';
                }

                field("Material Cost Doz."; "Material Cost Doz.")
                {
                    ApplicationArea = All;
                }
                field("Material Cost Pcs."; "Material Cost Pcs.")
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
  

    trigger OnDeleteRecord(): Boolean
    var
        BOMEstimateRec: Record "BOM Estimate";
        BOMLineEstRec: Record "BOM Estimate Line";
    begin
        BOMEstimateRec.SetRange("No.", "No.");
        BOMEstimateRec.DeleteAll();

        BOMLineEstRec.SetRange("No.", "No.");
        BOMLineEstRec.DeleteAll();
    end;
}