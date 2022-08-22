page 71012632 "Print Type Card"
{
    PageType = Card;
    SourceTable = "Print Type";
    Caption = 'Print Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Print Type No';
                }

                field("Print Type Name"; "Print Type Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        PrintTypeRec: Record "Print Type";
                    begin
                        PrintTypeRec.Reset();
                        PrintTypeRec.SetRange("Print Type Name", "Print Type Name");

                        if PrintTypeRec.FindSet() then
                            Error('Print Type Name already exists.');
                    end;
                }
            }
        }
    }
}