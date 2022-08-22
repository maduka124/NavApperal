page 71012647 "Stich Gmt Card"
{
    PageType = Card;
    SourceTable = "Stich Gmt";
    Caption = 'Stich Gmt';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Stich Gmt No';
                }

                field("Stich Gmt Name"; "Stich Gmt Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        StichGmtRec: Record "Stich Gmt";
                    begin
                        StichGmtRec.Reset();
                        StichGmtRec.SetRange("Stich Gmt Name", "Stich Gmt Name");

                        if StichGmtRec.FindSet() then
                            Error('Stich Gmt Name already exists.');
                    end;
                }
            }
        }
    }
}