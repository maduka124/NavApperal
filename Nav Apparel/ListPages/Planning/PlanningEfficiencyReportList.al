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
                field(Year; Year)
                {
                    ApplicationArea = All;
                }

                field(MonthName; MonthName)
                {
                    ApplicationArea = All;
                }

                field(MonthNo; MonthNo)
                {
                    ApplicationArea = All;
                }

                field("Factory No."; "Factory No.")
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                    Caption = 'Day 3';
                }

                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                }

                field("Line Name"; "Line Name")
                {
                    ApplicationArea = All;
                }

                field("Style No."; "Style No.")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                }

                field("Factory Eff."; "Factory Eff.")
                {
                    ApplicationArea = All;
                }

                field("Line Eff."; "Line Eff.")
                {
                    ApplicationArea = All;
                }

                field("Style Eff."; "Style Eff.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}