page 51342 GroupWiseCapacityListpart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = GroupWiseCapacity;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Month; rec.Month)
                {
                    ApplicationArea = All;
                }

                field("Capacity Pcs"; rec."Capacity Pcs")
                {
                    ApplicationArea = All;
                }

                field("Planned Pcs"; rec."Planned Pcs")
                {
                    ApplicationArea = All;
                }

                field("Achieved Pcs"; rec."Achieved Pcs")
                {
                    ApplicationArea = All;
                }
                field("Diff."; rec."Diff.")
                {
                    ApplicationArea = All;
                }

                field("Avg SMV"; rec."Avg SMV")
                {
                    ApplicationArea = All;
                }

                field(Finishing; rec.Finishing)
                {
                    ApplicationArea = All;
                }

                field("Ship Qty"; rec."Ship Qty")
                {
                    ApplicationArea = All;
                }

                field("Ship Value"; rec."Ship Value")
                {
                    ApplicationArea = All;
                }

                field("Avg Plan Mnts"; rec."Avg Plan Mnts")
                {
                    ApplicationArea = All;
                }

                field("Avg Prod. Mnts"; rec."Avg Prod. Mnts")
                {
                    ApplicationArea = All;
                }

                field("Plan Hit"; rec."Plan Hit")
                {
                    ApplicationArea = All;
                }

                field("Plan Eff."; rec."Plan Eff.")
                {
                    ApplicationArea = All;
                }

                field("Actual Eff."; rec."Actual Eff.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Refresh Data")
            {
                Image = RefreshText;
                ApplicationArea = all;

                trigger OnAction()
                var

                begin

                end;
            }
        }
    }
}