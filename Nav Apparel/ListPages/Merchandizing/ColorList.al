page 71012841 ColorList
{
    PageType = List;
    SourceTable = Colour;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Color Code';
                }

                field("Colour Name"; "Colour Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}