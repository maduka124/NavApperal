page 51177 "BuyeWisOdrBook-AllBookListPBi"
{
    SourceTable = BuyerWiseOdrBookingAllBookPBi1;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Year; rec.Year)
                {
                    ApplicationArea = All;
                }

                field(MonthName; rec.MonthName)
                {
                    ApplicationArea = All;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field(Value; rec.Value)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}