page 71012662 "Action Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Action Type";
    CardPageId = "Action Type Card";
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
                    Caption = 'Action Type No';
                }

                field("Action Type"; "Action Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}