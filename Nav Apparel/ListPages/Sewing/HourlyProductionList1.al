page 50517 "Hourly Production List1"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Location;
    Caption = 'Locatio Filter';

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