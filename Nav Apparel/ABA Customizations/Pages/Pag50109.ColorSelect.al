page 50109 "Color Select"
{
    Caption = 'Color Select';
    PageType = List;
    SourceTable = AssortmentDetails;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Colour No"; Rec."Colour No")
                {
                    ApplicationArea = All;
                }
                field("Colour Name"; Rec."Colour Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
