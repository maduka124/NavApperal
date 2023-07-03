page 51344 FactoryWiseCapacityListpart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FactoryWiseCapacity;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Factory; rec.Factory)
                {
                    ApplicationArea = All;
                }

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

                field("Plan Eff."; rec."Plan Eff.")
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