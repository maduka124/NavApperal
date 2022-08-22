page 71012662 "Action Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Action Type";
    CardPageId = "Action Type Card";


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