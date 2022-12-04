page 50779 "Costing Plan Para Listpart1"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = CostingPlanningParaLine;
    SourceTableView = sorting("Seq No") where("From SMV" = filter(> 0), "To SMV" = filter(<= 16));
    //Caption = 'Costing And Planning Parameter List';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("From SMV"; rec."From SMV")
                {
                    ApplicationArea = All;
                }

                field("To SMV"; rec."To SMV")
                {
                    ApplicationArea = All;
                }


                field("From Qty"; rec."From Qty")
                {
                    ApplicationArea = All;
                }


                field("To Qty"; rec."To Qty")
                {
                    ApplicationArea = All;
                }


                field("Costing Eff%"; rec."Costing Eff%")
                {
                    ApplicationArea = All;
                }


                field("Costing Avg Pro"; rec."Costing Avg Pro")
                {
                    ApplicationArea = All;
                }


                field("Planning Eff%"; rec."Planning Eff%")
                {
                    ApplicationArea = All;
                }


                field("Planning Avg Pro"; rec."Planning Avg Pro")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}