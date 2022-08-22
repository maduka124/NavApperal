page 71012677 AssoColourListPart
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
                field("Colour No"; "Colour No")
                {
                    ApplicationArea = All;
                }

                field("Colour Name"; "Colour Name")
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
        Type := '1';
    end;
}