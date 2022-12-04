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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Season No';
                }

                field("Season Name"; Rec."Season Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}