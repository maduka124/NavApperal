page 50808 "Dept_Categories Card"
{
    PageType = Card;
    SourceTable = Dept_Categories;
    Caption = 'Dept_Categories';

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

                field("Category No."; "Category No.")
                {
                    ApplicationArea = All;
                }

                field("Category Name"; "Category Name")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}