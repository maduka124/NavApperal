page 50654 WashingMachineTypeList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashingMachineType;
    CardPageId = WashingMachineTypeCard;
    Caption = 'Machine Type List';
    SourceTableView = sorting(code) order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(code; code)
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