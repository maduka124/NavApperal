page 71012603 "Dimension Width"
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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Dimension Width No';
                }

                field("Dimension Width"; "Dimension Width")
                {
                    ApplicationArea = All;
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                }
                field(Length; Length)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}