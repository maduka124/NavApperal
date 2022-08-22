page 71012774 "Sample Type Card"
{
    PageType = Card;
    SourceTable = "Sample Type";
    Caption = 'Sample Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type No';
                }

                field("Sample Type Name"; "Sample Type Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SampleTypeRec: Record "Sample Type";
                    begin
                        SampleTypeRec.Reset();
                        SampleTypeRec.SetRange("Sample Type Name", "Sample Type Name");
                        if SampleTypeRec.FindSet() then
                            Error('Sample Type already exists.');
                    end;
                }

                field("Lead Time"; "Lead Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}