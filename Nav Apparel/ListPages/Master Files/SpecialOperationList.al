page 71012643 "Special Operation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Special Operation";
    CardPageId = "Special Operation Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Special Operation No';
                }

                field("SpecialOperation Name"; "SpecialOperation Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }   
}