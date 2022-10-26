page 71012841 ColorList
{
    PageType = List;
    SourceTable = Colour;
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