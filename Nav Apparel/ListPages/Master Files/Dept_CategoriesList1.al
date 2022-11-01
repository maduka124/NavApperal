page 50810 "Dept_CategoriesList1"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Dept_Categories;
    SourceTableView = sorting("Factory Name", "Category Name", No) order(ascending);

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
                        // "Factory Code" := FactoryNoGB;
                        // "Factory Name" := FactoryNameGB;
                    end;
                }

                field("Category Name"; "Category Name")
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin
                        LocationRec.Reset();
                        LocationRec.SetRange(name, "Factory Name");
                        if LocationRec.FindSet() then
                            "Factory Code" := LocationRec.Code;
                    end;
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


    // actions
    // {
    //     area(Processing)
    //     {
    //         action("update")
    //         {
    //             ApplicationArea = All;
    //             Image = Calculate;

    //             trigger OnAction()
    //             var
    //                 Dept_Categories: Record Dept_Categories;

    //             begin


    //                 //Get SMV total/Machine SMV TOTAL/Helper SMV Total
    //                 Dept_Categories.Reset();
    //                 Dept_Categories.FindSet();
    //                 Dept_Categories.ModifyAll("Factory Code", FactoryNoGB);
    //                 Dept_Categories.ModifyAll("Factory Name", FactoryNameGB);
    //                 CurrPage.Update();

    //                 Message('Calculation completed.');

    //             end;
    //         }

    //     }
    // }


    procedure PassParameters(DeptNoPara: Code[20]; DeptNamePara: Text[50]);
    var
    begin
        DepartmentNoGB := DeptNoPara;
        DepartmentNameGB := DeptNamePara;
        CurrPage.Update();
    end;

    // procedure PassParameters(DeptNoPara: Code[20]; DeptNamePara: Text[50]; FactoryNoPara: Code[20]; FactoryNamePara: Text[50]);
    // var
    // begin
    //     //"Department No." := DeptNoPara;
    //     DepartmentNoGB := DeptNoPara;
    //     //"Department Name" := DeptNamePara;
    //     DepartmentNameGB := DeptNamePara;

    //     //"Factory Code" := FactoryNoPara;
    //     FactoryNoGB := FactoryNoPara;
    //     //"Factory Name" := FactoryNamePara;
    //     FactoryNameGB := FactoryNamePara;

    //     CurrPage.Update();
    // end;

    var
        DepartmentNoGB: Code[20];
        DepartmentNameGB: Text[50];
    // FactoryNoGB: Code[20];
    // FactoryNameGB: Text[50];



    trigger OnOpenPage()
    var
    begin
        SetFilter("Department No.", DepartmentNoGB);
        //SetFilter("Factory Code", FactoryNoGB);
    end;


}