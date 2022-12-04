
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

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; Rec."Factory Name")
                {
                    ApplicationArea = All;
                }

                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                }

                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
#pragma implicitwith restore
