page 51006 "Special Operation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Special Operation";
    CardPageId = "Special Operation Card";
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
                    Caption = 'Special Operation No';
                }

                field("SpecialOperation Name"; Rec."SpecialOperation Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}