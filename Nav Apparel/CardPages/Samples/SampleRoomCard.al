page 50430 "Sample Room Card"
{
    PageType = Card;
    SourceTable = "Sample Room";
    Caption = 'Sample Room';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Sample Room No."; rec."Sample Room No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Room No';
                }

                field("Sample Room Name"; rec."Sample Room Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SampleRoomRec: Record "Sample Room";
                    begin
                        SampleRoomRec.Reset();
                        SampleRoomRec.SetRange("Sample Room Name", rec."Sample Room Name");
                        if SampleRoomRec.FindSet() then
                            Error('Sample Room name already exists.');
                    end;
                }

                field("Global Dimension Code"; rec."Global Dimension Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}