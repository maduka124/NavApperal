page 71012641 "Size Range Card"
{
    PageType = Card;
    SourceTable = SizeRange;
    Caption = 'Size Range';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Size Range No';
                }

                field("Size Range"; "Size Range")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SizeRangeRec: Record SizeRange;
                    begin
                        SizeRangeRec.Reset();
                        SizeRangeRec.SetRange("Size Range", "Size Range");

                        if SizeRangeRec.FindSet() then
                            Error('Size Range already exists.');
                    end;
                }
            }
        }
    }
}