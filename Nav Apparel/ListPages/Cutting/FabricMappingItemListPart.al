page 50760 FabricMappingItemListPart
{
    PageType = List;
    Caption = 'Item List';
    SourceTable = "Purch. Rcpt. Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
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