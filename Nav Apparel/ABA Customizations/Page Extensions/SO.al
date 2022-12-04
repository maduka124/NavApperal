// pageextension 50104 Salesorderext extends "Sales Order"
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         addafter("S&hipments")
//         {
//             action(test)
//             {
//                 Image = Report;
//                 Promoted = true;
//                 ApplicationArea = All;
//                 trigger OnAction()
//                 var
//                     AbaCustmnag: Codeunit "Customization Management";
//                 begin
//                     AbaCustmnag.CreateProdOrder(Rec."No.");
//                 end;
//             }
//         }
//     }

// }