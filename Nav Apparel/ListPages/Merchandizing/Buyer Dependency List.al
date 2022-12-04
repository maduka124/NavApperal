page 51035 "Buyer Dependency List"
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
                field("Dependency No."; rec."Dependency No.")
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }

                field(Dependency; rec.Dependency)
                {
                    ApplicationArea = All;
                    Caption = 'Dependency';
                }
            }
        }
    }
}