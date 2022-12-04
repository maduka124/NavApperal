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
                field(code; rec.code)
                {
                    ApplicationArea = All;
                }

                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}