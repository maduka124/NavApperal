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
            }
        }
    }
}