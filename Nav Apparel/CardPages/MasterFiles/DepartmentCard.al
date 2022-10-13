page 71012598 "Department Card"
{
    PageType = Card;
    SourceTable = Department;
    Caption = 'Department';

    layout
    {

        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Department No';
                }

                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DepartmentRec: Record Department;
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", "Department Name");
                        if DepartmentRec.FindSet() then
                            Error('Department name already exists.');
                    end;
                }

                field("Show in New Operations"; "Show in New Operations")
                {
                    ApplicationArea = All;
                }

                field("Show in Manpower Budget"; "Show in Manpower Budget")
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
            action("Add Designations")
            {
                ApplicationArea = all;
                Image = ViewDescription;

                trigger OnAction();
                var
                    Dept_DesignationsList: Page Dept_DesignationsList1;
                begin
                    Clear(Dept_DesignationsList);
                    Dept_DesignationsList.LookupMode(true);
                    Dept_DesignationsList.PassParameters("No.", "Department Name");
                    Dept_DesignationsList.Run();
                end;
            }

        }
    }

}