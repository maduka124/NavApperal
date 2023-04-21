page 51301 POlist
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchase Line";

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