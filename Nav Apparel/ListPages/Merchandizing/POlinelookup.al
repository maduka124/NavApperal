page 51301 POlistLookupPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Line";
    Caption = 'PO List';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Buy From Vendor Name"; Rec."Buy From Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Supplier';
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}