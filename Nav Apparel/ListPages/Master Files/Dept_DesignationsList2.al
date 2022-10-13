page 50811 "Dept_DesignationsList2"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Dept_Designations;
    SourceTableView = sorting("Department No.", "Designations No.");
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                }

                field("Designations No."; "Designations No.")
                {
                    ApplicationArea = All;
                    Caption = 'Designations No';
                }

                field("Designations Name"; "Designations Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}