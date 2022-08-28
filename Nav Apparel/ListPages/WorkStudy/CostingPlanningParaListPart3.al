page 50782 "Costing Plan Para Listpart3"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = CostingPlanningParaLine;
    SourceTableView = sorting("Seq No") where("From SMV" = filter(> 20), "To SMV" = filter(<= 30));
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