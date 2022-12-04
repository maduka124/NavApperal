page 51014 AssoColourListPart
{
    PageType = List;
    Caption = 'Colour List';
    SourceTable = AssortmentDetails;
    SourceTableView = where(Type = filter('1'));
    Editable = false;

    layout
    {
        area(Content)
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
                    Editable = false;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
    begin
        Rec.Type := '1';
    end;
}