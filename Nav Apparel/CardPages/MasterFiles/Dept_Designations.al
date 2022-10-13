page 50808 "Dept_Designations Card"
{
    PageType = Card;
    SourceTable = Dept_Designations;
    Caption = 'Dept_Designations';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DepartmentRec: Record Department;
                    begin
                        // DepartmentRec.Reset();
                        // DepartmentRec.SetRange("Department Name", "Department Name");
                        // if DepartmentRec.FindSet() then
                        //     Error('Department name already exists.');
                    end;
                }

                field("Designations No."; "Designations No.")
                {
                    ApplicationArea = All;
                }

                field("Designations Name"; "Designations Name")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}