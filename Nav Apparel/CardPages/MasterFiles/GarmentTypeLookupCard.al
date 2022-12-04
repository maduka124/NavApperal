page 50955 "Garment Type Lookup Card"
{
    PageType = Card;
    SourceTable = "Garment Type";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type Code';
                    Editable = false;
                }

                field(Selected; rec.Selected)
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