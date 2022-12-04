page 71012597 "Department"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Department;
    CardPageId = "Department Card";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Department No';
                }

                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }

                field("Show in New Operations"; Rec."Show in New Operations")
                {
                    ApplicationArea = All;
                }

                field("Show in Manpower Budget"; Rec."Show in Manpower Budget")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}