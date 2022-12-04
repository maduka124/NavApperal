page 50846 "PlanningEfficiencyReportList"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = PlanEffDashboardReportTable;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Year; rec.Year)
                {
                    ApplicationArea = All;
                }

                field(MonthName; rec.MonthName)
                {
                    ApplicationArea = All;
                }

                field(MonthNo; rec.MonthNo)
                {
                    ApplicationArea = All;
                }

                field("Factory No."; rec."Factory No.")
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Day 3';
                }

                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                }

                field("Line Name"; rec."Line Name")
                {
                    ApplicationArea = All;
                }

                field("Style No."; rec."Style No.")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                }

                field("Factory Eff."; rec."Factory Eff.")
                {
                    ApplicationArea = All;
                }

                field("Line Eff."; rec."Line Eff.")
                {
                    ApplicationArea = All;
                }

                field("Style Eff."; rec."Style Eff.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}