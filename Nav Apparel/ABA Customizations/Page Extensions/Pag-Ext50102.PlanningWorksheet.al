pageextension 50102 PlanningWorksheet extends "Planning Worksheet"
{
    layout
    {

    }
    // actions
    // {
    //     addafter("Calculate &Net Change Plan")
    //     {
    //         action("Merge Lines")
    //         {
    //             ApplicationArea = All;
    //             Image = GetLines;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             trigger OnAction()
    //             var
    //                 CustMangement: Codeunit "Customization Management";
    //             begin
    //                 if not Confirm('Do you want to process the line merge?', false) then
    //                     exit;
    //                 CustMangement.MergePlanningLines(rec."Worksheet Template Name", rec."Journal Batch Name");
    //             end;
    //         }
    //     }
    // }

}
