// pageextension 50103 Req_Worksheet extends "Req. Worksheet"
// {
//     layout
//     {
//         addafter("Replenishment System")
//         {
//             field(SystemCreatedBy; rec."Created User Name")
//             {
//                 Caption = 'Created By';
//                 Editable = false;
//                 ApplicationArea = All;
//             }
//             field(SystemCreatedAt; rec.SystemCreatedAt)
//             {
//                 Caption = 'Created Date/Time';
//                 Editable = false;
//                 ApplicationArea = All;
//             }
//             field(SystemModifiedBy; rec."Modified User Name")
//             {
//                 Caption = 'Modified By';
//                 Editable = false;
//                 ApplicationArea = All;
//             }
//             field(SystemModifiedAt; rec.SystemModifiedAt)
//             {
//                 Caption = 'Modified Date/Time';
//                 Editable = false;
//                 ApplicationArea = All;
//             }
//         }
//         modify("No.")
//         {
//             trigger OnAfterValidate()
//             begin
//                 if rec."Created User Name" = '' then begin
//                     rec."Created User Name" := UserId;
//                     rec."Modified User Name" := UserId;
//                 end
//             end;
//         }
//     }
//     actions
//     {
//         addafter(CalculatePlan)
//         {
//             action("Merge Lines")
//             {
//                 ApplicationArea = All;
//                 Image = GetLines;
//                 Promoted = true;
//                 PromotedCategory = Process;

//                 trigger OnAction()
//                 var
//                     CustMangement: Codeunit "Customization Management";
//                 begin
//                     if not Confirm('Do you want to process the line merge?', false) then
//                         exit;
//                     CustMangement.MergePlanningLines(rec."Worksheet Template Name", rec."Journal Batch Name");
//                 end;
//             }
//         }
//     }
//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     var
//         UserSetup: Record "User Setup";
//     begin
//         UserSetup.Get(UserId);
//         if rec."Journal Batch Name" <> UserSetup."Req. Worksheet Batch" then
//             Error('You do not have permission');
//     end;

//     trigger OnModifyRecord(): Boolean
//     var
//         UserSetup: Record "User Setup";
//     begin
//         UserSetup.Get(UserId);
//         if rec."Journal Batch Name" <> UserSetup."Req. Worksheet Batch" then
//             Error('You do not have permission');

//         rec."Modified User Name" := UserId;
//     end;
// }
