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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Recipe/Prod. BOM No';
                }

                field("Wash Type"; rec."Wash Type")
                {
                    ApplicationArea = All;

                }

                field("BOM Type"; rec."BOM Type")
                {
                    ApplicationArea = All;
                }

                field("Bulk/Sample"; rec."Bulk/Sample")
                {
                    ApplicationArea = All;
                }

                field("Lot Size (Kg)"; rec."Lot Size (Kg)")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field(Lot; rec.Lot)
                {
                    ApplicationArea = All;
                }

                field(Color; rec.Color)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}