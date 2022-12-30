page 51184 "CountryListPBi"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Country/Region";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = All;
                }

                field("Name"; rec."Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}