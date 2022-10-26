page 50334 "Learning Curve"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Learning Curve";
    CardPageId = "Learning Curve Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Curve No';
                }

                field(Day1; Day1)
                {
                    ApplicationArea = All;
                    Caption = 'Day 1';
                }

                field(Day2; Day2)
                {
                    ApplicationArea = All;
                    Caption = 'Day 2';
                }

                field(Day3; Day3)
                {
                    ApplicationArea = All;
                    Caption = 'Day 3';
                }

                field(Day4; Day4)
                {
                    ApplicationArea = All;
                    Caption = 'Day 4';
                }

                field(Day5; Day5)
                {
                    ApplicationArea = All;
                    Caption = 'Day 5';
                }

                field(Day6; Day6)
                {
                    ApplicationArea = All;
                    Caption = 'Day 6';
                }

                field(Day7; Day7)
                {
                    ApplicationArea = All;
                    Caption = 'Day 7';
                }
            }
        }
    }
}