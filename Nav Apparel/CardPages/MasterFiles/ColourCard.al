page 50947 "Colour Card"
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
                field("No.";rec. "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Colour No';
                }

                field("Colour Name"; rec."Colour Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                    begin
                        ColourRec.Reset();
                        ColourRec.SetRange("Colour Name",rec. "Colour Name");
                        if ColourRec.FindSet() then
                            Error('Colour name already exists.');
                    end;
                }
            }
        }
    }
}