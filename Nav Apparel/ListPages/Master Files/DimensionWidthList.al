page 50650 "Dimension Width"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DimensionWidth;
    CardPageId = "Dimension Width Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension Width No';
                }

                field("Dimension Width"; Rec."Dimension Width")
                {
                    ApplicationArea = All;
                }

                field("Main Category Name"; Rec."Main Category Name")
                {
                    ApplicationArea = All;
                }
                field(Length; Rec.Length)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}