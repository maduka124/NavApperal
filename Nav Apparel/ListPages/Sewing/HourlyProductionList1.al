page 50517 "Hourly Production List1"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Location;
    Caption = 'Location Filter';
    SourceTableView = sorting(Code) order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }

                field(Name; Name)
                {
                    ApplicationArea = All;
                    Caption = 'Factory';
                }
            }
        }
    }
}