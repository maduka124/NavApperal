page 71012626 "Pack Card"
{
    PageType = Card;
    SourceTable = Pack;
    Caption = 'Pack';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Pack No';
                }

                field(Pack; Pack)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        PackRec: Record Pack;
                    begin
                        PackRec.Reset();
                        PackRec.SetRange(Pack, Pack);
                        if PackRec.FindSet() then
                            Error('Pack already exists.');
                    end;
                }
            }
        }
    }
}