page 71012634 "Seasons List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Seasons;
    CardPageId = "Seasons Card";
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
                    Caption = 'Season No';
                }

                field("Season Name"; "Season Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}