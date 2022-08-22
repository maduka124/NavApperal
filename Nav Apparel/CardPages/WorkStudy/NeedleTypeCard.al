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
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Needle Type No';
                }

                field("Needle Description"; "Needle Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    } 
}