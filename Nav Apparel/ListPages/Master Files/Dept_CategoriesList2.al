page 50811 "Dept_CategoriesList2"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Dept_Categories;
    SourceTableView = sorting("Factory Name", "Department Name", "Category Name", No) order(ascending);
    InsertAllowed = false;
    //ModifyAllowed = false;
    DeleteAllowed = true;

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

                field("Category Name"; "Category Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Factory Name"; "Factory Name")
                {
                    ApplicationArea = All;
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