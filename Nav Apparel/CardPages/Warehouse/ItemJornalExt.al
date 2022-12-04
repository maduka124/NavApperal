pageextension 50833 ItemjournalExt extends "Item Journal"
{
    layout
    {
        // addafter("Location Code")
        // {
        //     field(Department; Department)
        //     {
        //         ApplicationArea = All;
        //         trigger OnValidate()
        //         var
        //             DepartmentRec: Record Department;
        //         begin

        //             DepartmentRec.Reset();
        //             DepartmentRec.SetRange("Department Name", Department);

        //             if DepartmentRec.FindSet() then
        //                 "Department No" := DepartmentRec."No.";

        //         end;
        //     }
        // }
    }

    actions
    {
        addafter("P&osting")
        {
            action(Print)
            {
                ApplicationArea = all;
                Image = Print;

                trigger OnAction()
                var
                    GeneralIssueRec: Report generalIssueReportItem;
                begin
                    GeneralIssueRec.Set_value(Rec."Document No.");
                    GeneralIssueRec.Set_batch(Rec."Location Code");
                    GeneralIssueRec.RunModal();
                end;
            }
        }
    }
}