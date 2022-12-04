page 50446 "Machine Category List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Machine Category";
    CardPageId = "Machine Category Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No.";rec. "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Machine Category No';
                }

                field("Machine Category";rec. "Machine Category")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}