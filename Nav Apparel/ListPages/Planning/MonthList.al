page 50876 "MonthList"
{
    PageType = list;
    SourceTable = MonthTable;
    SourceTableView = sorting("Month No");

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Month No"; "Month No")
                {
                    ApplicationArea = All;
                }

                field("Month Name"; "Month Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
