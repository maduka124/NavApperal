pageextension 50833 ItemjournalExt extends "Item Journal"
{
    layout
    {
        addafter("Location Code")
        {
            field(Department; Department)
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    DepartmentRec: Record Department;
                begin

                    DepartmentRec.Reset();
                    DepartmentRec.SetRange("Department Name", Department);

                    if DepartmentRec.FindSet() then
                        "Department No" := DepartmentRec."No.";

                end;
            }
        }
    }
}