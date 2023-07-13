
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

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }

                // field("Cutting Planned"; Rec."Cutting Planned")
                // {
                //     ApplicationArea = All;
                // }

                field("Cutting Achieved"; Rec."Cutting Achieved")
                {
                    ApplicationArea = All;
                }

                // field("Cutting Difference"; Rec."Cutting Difference")
                // {
                //     ApplicationArea = All;
                // }

                field("Sewing Planned"; Rec."Sewing Planned")
                {
                    ApplicationArea = All;
                }

                field("Sewing Achieved"; Rec."Sewing Achieved")
                {
                    ApplicationArea = All;
                }

                field("Sewing Difference"; Rec."Sewing Difference")
                {
                    ApplicationArea = All;
                }

                // field("Finishing Planned"; Rec."Finishing Planned")
                // {
                //     ApplicationArea = All;
                // }

                field("Finishing Achieved"; Rec."Finishing Achieved")
                {
                    ApplicationArea = All;
                }

                // field("Finishing Difference"; Rec."Finishing Difference")
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }
}

