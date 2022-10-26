page 50811 "Dept_CategoriesList2"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Dept_Categories;
    SourceTableView = sorting(No) order(descending);
    InsertAllowed = false;
    //ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Category No."; "Category No.")
                {
                    ApplicationArea = All;
                    Caption = 'Category No';
                    Editable = false;
                }

                field("Category Name"; "Category Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Act Budget"; "Act Budget")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Final Budget with Absenteesm"; "Final Budget with Absenteesm")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Absent%"; "Absent%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Show In Report"; "Show In Report")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}