page 50946 "Chemical Type Card"
{
    PageType = Card;
    SourceTable = ChemicalType;
    Caption = 'Chemical Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Chemical Type No';
                }

                field("Chemical Type Name";rec. "Chemical Type Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ChemicalTypeRec: Record ChemicalType;
                    begin
                        ChemicalTypeRec.Reset();
                        ChemicalTypeRec.SetRange("Chemical Type Name", rec."Chemical Type Name");
                        if ChemicalTypeRec.FindSet() then
                            Error('Chemical Type name already exists.');
                    end;
                }
            }
        }
    }
}