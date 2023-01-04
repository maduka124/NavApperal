page 51188 "Customer List Lookup"
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

                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}