page 50461 "Item Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Type";
    CardPageId = "Item Type Card";


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item Type No';
                }

                field("Item Type Name"; "Item Type Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}