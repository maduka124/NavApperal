page 51346 LineWiseCapacityListpart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LineWiseCapacity;

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

                field("Resource Name"; rec."Resource Name")
                {
                    ApplicationArea = All;
                    Caption = 'Line';
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