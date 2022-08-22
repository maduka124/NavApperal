page 71012748 "Garment Type Lookup Card"
{
    PageType = Card;
    SourceTable = "Garment Type";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type Code';
                    Editable = false;
                }

                field(Selected; Selected)
                {
                    ApplicationArea = All;
                    Editable = true;

                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        GarmentTypRec: Record "Garment Type";
    begin
        GarmentTypRec.Reset();
        repeat
            GarmentTypRec.Selected := false;
        until GarmentTypRec.Next() = 0;

    end;

}