page 50462 "Item Type Card"
{
    PageType = Card;
    SourceTable = "Item Type";
    Caption = 'Item Type ';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item Type No';
                }

                field("Item Type Name"; rec."Item Type Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ItemTypeRec: Record "Item Type";
                    begin
                        ItemTypeRec.Reset();
                        ItemTypeRec.SetRange("Item Type Name", rec."Item Type Name");
                        if ItemTypeRec.FindSet() then
                            Error('Item Type Name already exists.');
                    end;
                }
            }
        }
    }
}