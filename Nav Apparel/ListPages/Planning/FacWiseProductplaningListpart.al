page 50860 FacWiseProductplaningPart
{
    PageType = ListPart;
    SourceTable = FacWiseProductplaningLineTable;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTableView = sorting(Date) order(ascending);
    layout
    {
        area(Content)
        {
            repeater(Genaral)
            {

                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Date; Date)
                {
                    ApplicationArea = All;
                }

                field("Cutting Planned"; "Cutting Planned")
                {
                    ApplicationArea = All;
                }

                field("Cutting Achieved"; "Cutting Achieved")
                {
                    ApplicationArea = All;
                }

                field("Cutting Difference"; "Cutting Difference")
                {
                    ApplicationArea = All;
                }

                field("Sewing Planned"; "Sewing Planned")
                {
                    ApplicationArea = All;
                }

                field("Sewing Achieved"; "Sewing Achieved")
                {
                    ApplicationArea = All;
                }

                field("Sewing Difference"; "Sewing Difference")
                {
                    ApplicationArea = All;
                }

                field("Finishing Planned"; "Finishing Planned")
                {
                    ApplicationArea = All;
                }

                field("Finishing Achieved"; "Finishing Achieved")
                {
                    ApplicationArea = All;
                }

                field("Finishing Difference"; "Finishing Difference")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}