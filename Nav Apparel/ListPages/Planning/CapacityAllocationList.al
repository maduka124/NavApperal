page 50857 CapacityAllocationList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = YearTable;
    CardPageId = CapacityUtilizationSAH;
    SourceTableView = sorting(Year) order(ascending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Year; Year)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}