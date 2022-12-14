page 71012590 Colour
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Colour;
    CardPageId = "Colour Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Colour No';
                }

                field("Colour Name"; "Colour Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}