page 51249 "Buyer Style PO Search Listpart"
{
    PageType = ListPart;
    SourceTable = "Buyer Style PO Search";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("PO No"; Rec."PO No")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}