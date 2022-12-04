// pageextension 50113 B2B_LC_CardExt extends "B2B LC Card"
// {
//     layout
//     {
//         addafter("  ")
//         {
//             part("Other Chargers"; "Other Charges")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Bank / Other Chargers';
//                 SubPageLink = "Document No." = field("No.");
//             }
//         }
//     }
//     actions
//     {
//         addfirst(Creation)
//         {
//             action("Process Item Charge")
//             {
//                 ApplicationArea = All;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 Image = IssueFinanceCharge;
//                 trigger OnAction()
//                 var
//                     CustMangemnt: Codeunit "Customization Management";
//                 begin
//                     if Confirm('Do you want to process the Item Charges?', true) then
//                         CustMangemnt.CreateItemChargeEntry(Rec);
//                 end;
//             }
//         }
//     }
// }
