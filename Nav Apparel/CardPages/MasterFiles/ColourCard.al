page 71012591 "Colour Card"
{
    PageType = Card;
    SourceTable = Colour;
    Caption = 'Colour';
    //Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Colour No';
                }

                field("Colour Name"; "Colour Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                    begin
                        ColourRec.Reset();
                        ColourRec.SetRange("Colour Name", "Colour Name");
                        if ColourRec.FindSet() then
                            Error('Colour name already exists.');
                    end;
                }
            }
        }
    }
}