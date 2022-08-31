page 71012597 "Department"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Department;
    CardPageId = "Department Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Department No';
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                }

                field("Show in New Operations"; "Show in New Operations")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}