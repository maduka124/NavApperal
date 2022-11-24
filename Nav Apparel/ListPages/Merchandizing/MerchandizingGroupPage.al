page 50848 MerchandizingGroupPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = MerchandizingGroupTable;
    CardPageId = MerchandizingGroupCard;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Group Id"; "Group Id")
                {
                    ApplicationArea = All;
                }

                field("Group Head"; "Group Head")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}