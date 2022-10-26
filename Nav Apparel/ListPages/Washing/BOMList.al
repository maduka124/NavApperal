page 50659 WashingBOMList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Production BOM Header";
    CardPageId = "Production BOM";
    Caption = 'Recipe/Production BOM';
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Recipe/Prod. BOM No';
                }

                field("Wash Type"; "Wash Type")
                {
                    ApplicationArea = All;

                }

                field("BOM Type"; "BOM Type")
                {
                    ApplicationArea = All;
                }

                field("Bulk/Sample"; "Bulk/Sample")
                {
                    ApplicationArea = All;
                }

                field("Lot Size (Kg)"; "Lot Size (Kg)")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                }

                field(Lot; Lot)
                {
                    ApplicationArea = All;
                }

                field(Color; Color)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}