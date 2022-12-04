page 50619 "Sample Type Card"
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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type No';
                }

                field("Sample Type Name"; rec."Sample Type Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SampleTypeRec: Record "Sample Type";
                    begin
                        SampleTypeRec.Reset();
                        SampleTypeRec.SetRange("Sample Type Name", rec."Sample Type Name");
                        if SampleTypeRec.FindSet() then
                            Error('Sample Type already exists.');
                    end;
                }

                field("Lead Time"; rec."Lead Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}