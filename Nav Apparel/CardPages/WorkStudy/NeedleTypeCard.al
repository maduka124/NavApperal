page 50450 "Needle Type Card"
{
    PageType = Card;
    SourceTable = NeedleType;
    Caption = 'Needle Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Needle Type No';
                }

                field("Needle Description"; rec."Needle Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}