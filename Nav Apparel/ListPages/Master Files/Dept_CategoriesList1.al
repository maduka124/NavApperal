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
                field("Category No."; Rec."Category No.")
                {
                    ApplicationArea = All;
                    Caption = 'Category No';

                    trigger OnValidate()
                    var
                    begin
                        Rec."Department No." := DepartmentNoGB;
                        Rec."Department Name" := DepartmentNameGB;
                        // "Factory Code" := FactoryNoGB;
                        // "Factory Name" := FactoryNameGB;
                    end;
                }

                field("Category Name"; Rec."Category Name")
                {
                    ApplicationArea = All;
                }

                field("Factory Name"; Rec."Factory Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin
                        LocationRec.Reset();
                        LocationRec.SetRange(name, Rec."Factory Name");
                        if LocationRec.FindSet() then
                            Rec."Factory Code" := LocationRec.Code;
                    end;
                }

                field("Act Budget"; Rec."Act Budget")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Rec."Final Budget with Absenteesm" := round(Rec."Act Budget" * Rec."Absent%", 1);
                    end;
                }

                field("Absent%"; Rec."Absent%")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        Rec."Final Budget with Absenteesm" := round(Rec."Act Budget" * Rec."Absent%", 1);
                    end;
                }

                field("Final Budget with Absenteesm"; Rec."Final Budget with Absenteesm")
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

        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

        Rec.SetFilter("Department No.", DepartmentNoGB);
        //SetFilter("Factory Code", FactoryNoGB);
    end;

}