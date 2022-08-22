page 71012613 "Inspection Stage Card"
{
    PageType = Card;
    SourceTable = InspectionStage;
    Caption = 'Inspection Stage';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Inspection Stage No';
                }

                field("Inspection Stage"; "Inspection Stage")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        InspectionStageRec: Record InspectionStage;
                    begin
                        InspectionStageRec.Reset();
                        InspectionStageRec.SetRange("Inspection Stage", "Inspection Stage");
                        if InspectionStageRec.FindSet() then
                            Error('Inspection Stage already exists.');
                    end;
                }
            }
        }
    }
}