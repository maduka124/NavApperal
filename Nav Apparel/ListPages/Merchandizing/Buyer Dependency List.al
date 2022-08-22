page 71012700 "Buyer Dependency List"
{
    PageType = ListPart;
    SourceTable = "Dependency Buyer";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Dependency No."; "Dependency No.")
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }

                field(Dependency; Dependency)
                {
                    ApplicationArea = All;
                    Caption = 'Dependency';
                }
            }
        }
    }
}