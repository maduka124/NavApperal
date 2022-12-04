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