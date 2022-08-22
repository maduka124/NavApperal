page 50760 FabricMappingItemListPart
{
    PageType = List;
    Caption = 'Item List';
    SourceTable = "Item Ledger Entry";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item No';
                }

                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}