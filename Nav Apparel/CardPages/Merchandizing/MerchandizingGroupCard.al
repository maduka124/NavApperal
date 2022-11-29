page 50847 MerchandizingGroupCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = MerchandizingGroupTable;
    Caption = 'Merchandizing Group';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Group Id"; "Group Id")
                {
                    ApplicationArea = All;
                }

                field("Group Name"; "Group Name")
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