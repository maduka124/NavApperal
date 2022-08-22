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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Defects No';
                }

                field(Defects; Defects)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DefectsRec: Record Defects;
                    begin
                        DefectsRec.Reset();
                        DefectsRec.SetRange(Defects, Defects);
                        if DefectsRec.FindSet() then
                            Error('Defects name already exists.');
                    end;
                }
            }
        }
    }
}