page 50634 "Department (Style)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Department Style";
    CardPageId = "Department(Style) Card";
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
            }
        }
    }
}