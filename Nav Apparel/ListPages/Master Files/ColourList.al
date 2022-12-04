page 71012590 Colour
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Colour;
    CardPageId = "Colour Card";
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
                    Caption = 'Colour No';
                }

                field("Colour Name"; Rec."Colour Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}