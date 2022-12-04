page 71012657 "Wash Type Card"
{
    PageType = Card;
    SourceTable = "Wash Type";
    Caption = 'Wash Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Type No';
                }

                field("Wash Type Name"; rec."Wash Type Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashTypeRec: Record "Wash Type";
                    begin
                        WashTypeRec.Reset();
                        WashTypeRec.SetRange("Wash Type Name", rec."Wash Type Name");

                        if WashTypeRec.FindSet() then
                            Error('Wash Type Name already exists.');
                    end;
                }
            }
        }
    }
}