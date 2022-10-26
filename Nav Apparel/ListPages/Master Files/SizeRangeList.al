page 71012640 SizeRange
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SizeRange;
    CardPageId = "Size Range Card";
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
                    Caption = 'Size Range No';
                }

                field("Size Range"; "Size Range")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}