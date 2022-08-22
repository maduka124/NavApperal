page 71012644 "Special Operation Card"
{
    PageType = Card;
    SourceTable = "Special Operation";
    Caption = 'Special Operation';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Special Operation No';
                }

                field("SpecialOperation Name"; "SpecialOperation Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SpecialOperationRec: Record "Special Operation";
                    begin
                        SpecialOperationRec.Reset();
                        SpecialOperationRec.SetRange("SpecialOperation Name", "SpecialOperation Name");

                        if SpecialOperationRec.FindSet() then
                            Error('Special Operation Name already exists.');
                    end;
                }
            }
        }
    }
}