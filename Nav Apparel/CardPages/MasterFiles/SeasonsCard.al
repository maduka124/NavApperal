page 71012635 "Seasons Card"
{
    PageType = Card;
    SourceTable = Seasons;
    Caption = 'Seasons';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Season No';
                }

                field("Season Name"; rec."Season Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SeasonsRec: Record Seasons;
                    begin
                        SeasonsRec.Reset();
                        SeasonsRec.SetRange("Season Name", rec."Season Name");

                        if SeasonsRec.FindSet() then
                            Error('Season Name already exists.');
                    end;
                }
            }
        }
    }
}