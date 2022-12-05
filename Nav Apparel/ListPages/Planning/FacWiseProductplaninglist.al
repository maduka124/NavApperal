
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
    trigger OnDeleteRecord(): Boolean
    var
        FacWiseProdPlanLineRec: Record FacWiseProductplaningLineTable;
    begin

        FacWiseProdPlanLineRec.Reset();
        FacWiseProdPlanLineRec.SetRange("No.", Rec.No);

        if FacWiseProdPlanLineRec.FindSet() then
            FacWiseProdPlanLineRec.DeleteAll();

    end;
}

#pragma implicitwith restore
