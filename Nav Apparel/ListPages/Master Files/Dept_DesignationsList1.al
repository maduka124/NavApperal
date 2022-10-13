page 50810 "Dept_DesignationsList1"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Dept_Designations;
    //CardPageId = "Dept_Designations Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                // field("Department No."; "Department No.")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Department No';
                //     Editable = false;
                // }

                // field("Department Name"; "Department Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Department Name';
                //     Editable = false;
                // }

                field("Designations No."; "Designations No.")
                {
                    ApplicationArea = All;
                    Caption = 'Designations No';

                    trigger OnValidate()
                    var
                    begin
                        "Department No." := DepartmentNoGB;
                        "Department Name" := DepartmentNameGB;
                    end;
                }

                field("Designations Name"; "Designations Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure PassParameters(DeptNoPara: Code[20]; DeptNamePara: Text[50]);
    var
    begin
        "Department No." := DeptNoPara;
        DepartmentNoGB := DeptNoPara;
        "Department Name" := DeptNamePara;
        DepartmentNameGB := DeptNamePara;
    end;

    var
        DepartmentNoGB: Code[20];
        DepartmentNameGB: Text[50];



    trigger OnOpenPage()
    var
    begin
        SetFilter("Department No.", "Department No.");
    end;
}