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
                field("From SMV"; "From SMV")
                {
                    ApplicationArea = All;
                }

                field("To SMV"; "To SMV")
                {
                    ApplicationArea = All;
                }


                field("From Qty"; "From Qty")
                {
                    ApplicationArea = All;
                }


                field("To Qty"; "To Qty")
                {
                    ApplicationArea = All;
                }


                field("Costing Eff%"; "Costing Eff%")
                {
                    ApplicationArea = All;
                }


                field("Costing Avg Pro"; "Costing Avg Pro")
                {
                    ApplicationArea = All;
                }


                field("Planning Eff%"; "Planning Eff%")
                {
                    ApplicationArea = All;
                }


                field("Planning Avg Pro"; "Planning Avg Pro")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}