page 50950 "Department Card"
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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Department No';
                }

                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DepartmentRec: Record Department;
                    begin
                        DepartmentRec.Reset();
                        DepartmentRec.SetRange("Department Name", rec."Department Name");
                        if DepartmentRec.FindSet() then
                            Error('Department name already exists.');
                    end;
                }

                field("Show in New Operations"; rec."Show in New Operations")
                {
                    ApplicationArea = All;
                }

                field("Show in Manpower Budget"; rec."Show in Manpower Budget")
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
            action("Add Categories")
            {
                ApplicationArea = all;
                Image = ViewDescription;

                trigger OnAction();
                var
                    Dept_CategoriesList: Page Dept_CategoriesList1;
                // UserRec: Record "User Setup";
                // LocationRec: Record Location;
                begin

                    Clear(Dept_CategoriesList);
                    Dept_CategoriesList.LookupMode(true);
                    Dept_CategoriesList.PassParameters(rec."No.", rec."Department Name");
                    Dept_CategoriesList.Run();

                    // UserRec.Reset();
                    // UserRec.SetRange("User ID", UserId);

                    // if UserRec.FindSet() then begin
                    //     LocationRec.Reset();
                    //     LocationRec.SetRange(Code, UserRec."Factory Code");
                    //     LocationRec.FindSet();

                    //     Clear(Dept_CategoriesList);
                    //     Dept_CategoriesList.LookupMode(true);
                    //     Dept_CategoriesList.PassParameters("No.", "Department Name", UserRec."Factory Code", LocationRec.Name);
                    //     Dept_CategoriesList.Run();
                    // end
                    // else
                    //     Error('Factory not setup for the User : %1', UserId);

                end;
            }

        }
    }

}