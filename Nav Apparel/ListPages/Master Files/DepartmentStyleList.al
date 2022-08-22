page 71012600 "Department (Style)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Department Style";
    CardPageId = "Department(Style) Card";

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
            }
        }
    }
}