page 71012595 "Defects Card"
{
    PageType = Card;
    SourceTable = Defects;
    Caption = 'Defects';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Defects No';
                }

                field(Defects; rec.Defects)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DefectsRec: Record Defects;
                    begin
                        DefectsRec.Reset();
                        DefectsRec.SetRange(Defects, rec.Defects);
                        if DefectsRec.FindSet() then
                            Error('Defects name already exists.');
                    end;
                }
            }
        }
    }
}