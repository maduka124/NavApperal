page 50965 "Pack Card"
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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Pack No';
                }

                field(Pack; rec.Pack)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        PackRec: Record Pack;
                    begin
                        PackRec.Reset();
                        PackRec.SetRange(Pack, rec.Pack);
                        if PackRec.FindSet() then
                            Error('Pack already exists.');
                    end;
                }
            }
        }
    }
}