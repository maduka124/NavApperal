pageextension 71012732 UOMCardExt extends "Units of Measure"
{
    layout
    {
        addafter(Description)
        {
            field("Converion Parameter"; rec."Converion Parameter")
            {
                ApplicationArea = All;
                Caption = 'Conversion Parameter';
            }
        }
    }
}
