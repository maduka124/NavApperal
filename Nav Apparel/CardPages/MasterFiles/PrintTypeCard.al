page 50967 "Print Type Card"
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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Print Type No';
                }

                field("Print Type Name"; rec."Print Type Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        PrintTypeRec: Record "Print Type";
                    begin
                        PrintTypeRec.Reset();
                        PrintTypeRec.SetRange("Print Type Name", rec."Print Type Name");

                        if PrintTypeRec.FindSet() then
                            Error('Print Type Name already exists.');
                    end;
                }
            }
        }
    }
}