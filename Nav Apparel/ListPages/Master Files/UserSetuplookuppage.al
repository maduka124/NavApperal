page 51374 UserSEtupLookup
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "User Setup";
    Caption = 'User Setup';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Merchandizer Group Name"; Rec."Merchandizer Group Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}