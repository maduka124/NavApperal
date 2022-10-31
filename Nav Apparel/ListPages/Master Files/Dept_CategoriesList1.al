page 50810 "Dept_CategoriesList1"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Dept_Categories;
    SourceTableView = sorting(No) order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Category No."; "Category No.")
                {
                    ApplicationArea = All;
                    Caption = 'Category No';

                    trigger OnValidate()
                    var
                    begin
                        "Department No." := DepartmentNoGB;
                        "Department Name" := DepartmentNameGB;
                    end;
                }

                field("Category Name"; "Category Name")
                {
                    ApplicationArea = All;
                }

                field("Factory Code"; "Factory Code")
                {
                    ApplicationArea = All;
                }
                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
                }


                field("Act Budget"; "Act Budget")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        "Final Budget with Absenteesm" := round("Act Budget" * "Absent%", 1);
                    end;
                }

                field("Absent%"; "Absent%")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        "Final Budget with Absenteesm" := round("Act Budget" * "Absent%", 1);
                    end;
                }

                field("Final Budget with Absenteesm"; "Final Budget with Absenteesm")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure PassParameters(DeptNoPara: Code[20]; DeptNamePara: Text[50]; FactoryNoPara: Code[20]; FactoryNamePara: Text[50]);
    var
    begin
        "Department No." := DeptNoPara;
        DepartmentNoGB := DeptNoPara;
        "Department Name" := DeptNamePara;
        DepartmentNameGB := DeptNamePara;

        "Factory Code" := FactoryNoPara;
        FactoryNoGB := FactoryNoPara;
        "Factory Name" := FactoryNamePara;
        FactoryNameGB := FactoryNamePara;

        CurrPage.Update();
    end;

    var
        DepartmentNoGB: Code[20];
        DepartmentNameGB: Text[50];
        FactoryNoGB: Code[20];
        FactoryNameGB: Text[50];



    trigger OnOpenPage()
    var
    begin
        SetFilter("Department No.", "Department No.");
        SetFilter("Factory Code", "Factory Code");
        CurrPage.Update();
    end;
}