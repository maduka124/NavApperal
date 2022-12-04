pageextension 50975 UOMCardExt extends "Units of Measure"
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
