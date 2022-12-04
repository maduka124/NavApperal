page 50461 "Item Type List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Item Type";
    CardPageId = "Item Type Card";
    SourceTableView = sorting("No.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item Type No';
                }

                field("Item Type Name"; rec."Item Type Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}