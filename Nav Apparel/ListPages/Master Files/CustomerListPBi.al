page 51183 "CustomerListPBi"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Country/Region Code"; rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}