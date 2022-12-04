// pageextension 50120 Item_JournalExt extends "Item Journal"
// {
//     layout
//     {

//     }
//     actions
//     {
//         addafter("P&osting")
//         {
//             action(Print)
//             {
//                 ApplicationArea = all;
//                 Image = Print;

//                 trigger OnAction()
//                 var
//                     GeneralIssueRec: Report generalIssueReportItem;
//                 begin
//                     GeneralIssueRec.Set_value(Rec."Document No.");
//                     GeneralIssueRec.Set_batch(Rec."Location Code");
//                     GeneralIssueRec.RunModal();
//                 end;
//             }
//         }
//     }
//     // trigger OnAfterGetCurrRecord()
//     // var
//     //     InventSetup: Record "Inventory Setup";
//     // begin
//     //     BooVis := false;
//     //     InventSetup.Get();
//     //     if InventSetup."Gen. Issue Template" = rec."Journal Template Name" then
//     //         BooVis := true;
//     //     Message('%1 / %2 / %3', InventSetup."Gen. Issue Template", rec."Journal Template Name", BooVis);
//     // end;

//     // var
//     //     BooVis: Boolean;
// }
