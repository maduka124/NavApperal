page 50672 GRNColourListPart
{
    PageType = List;
    Caption = 'Colour List';
    SourceTable = "Purch. Rcpt. Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Colour No"; "Color No.")
                {
                    ApplicationArea = All;
                }

                field("Colour Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}