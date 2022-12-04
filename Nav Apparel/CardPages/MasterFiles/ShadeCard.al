page 71012638 "Shade Card"
{
    PageType = Card;
    SourceTable = Shade;
    Caption = 'Shade/LOT';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Shade No';
                }

                field(Shade; rec.Shade)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ShadeRec: Record Shade;
                    begin
                        ShadeRec.Reset();
                        ShadeRec.SetRange(Shade, rec.Shade);

                        if ShadeRec.FindSet() then
                            Error('Shade Name already exists.');
                    end;
                }
            }
        }
    }
}