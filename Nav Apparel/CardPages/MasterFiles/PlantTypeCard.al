page 50966 "Plant Type Card"
{
    PageType = Card;
    SourceTable = "Plant Type";
    Caption = 'Plant Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Plant Type No."; rec."Plant Type No.")
                {
                    ApplicationArea = All;
                    Caption = 'Plant Type No';
                }

                field("Plant Type Name"; rec."Plant Type Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        PlantTypeRec: Record "Plant Type";
                    begin
                        PlantTypeRec.Reset();
                        PlantTypeRec.SetRange("Plant Type Name", rec."Plant Type Name");
                        if PlantTypeRec.FindSet() then
                            Error('Plant Type Name already exists.');
                    end;
                }
            }
        }
    }
}