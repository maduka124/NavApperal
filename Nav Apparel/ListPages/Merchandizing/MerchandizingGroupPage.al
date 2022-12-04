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
                field("Group Id"; rec."Group Id")
                {
                    ApplicationArea = All;
                }

                field("Group Name"; rec."Group Name")
                {
                    ApplicationArea = All;
                }

                field("Group Head"; rec."Group Head")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}