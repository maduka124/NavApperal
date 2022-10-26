page 50749 WashingStep
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "WashingStep";
    SourceTableView = sorting(Code) order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }

                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}