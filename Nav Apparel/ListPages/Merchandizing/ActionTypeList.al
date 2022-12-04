page 51013 "Action Type List"
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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Action Type No';
                }

                field("Action Type"; Rec."Action Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}