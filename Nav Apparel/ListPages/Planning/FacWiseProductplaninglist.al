page 50861 FacWiseProductplaningHdrList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = FacWiseProductplaningHdrCard;
    SourceTable = FactWiseProductPlaningHdrtbale;
    Caption = 'Factory Wise Production Planning';
    SourceTableView = sorting(No) order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(No; No)
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                }

                field("From Date"; "From Date")
                {
                    ApplicationArea = All;
                }

                field("To Date"; "To Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}