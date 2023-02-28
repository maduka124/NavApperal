page 51252 "Buyer Style PO Search List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "BuyerStylePOSearchHeader";
    CardPageId = "Buyer Style PO Search";
    DeleteAllowed = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; rec."No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}