// pageextension 51402 SalesOrderExt extends "Sales Order"
// {
//     layout
//     {
//         // Add changes to page layout here
//         addlast(General)
//         {
//             field("External Document No.1"; Rec."External Document No.")
//             {
//                 Caption = 'External Document No.';
//                 ApplicationArea = All;
//             }
//         }
//         modify("External Document No.")
//         {
//             Visible = false;
//         }
//     }

//     actions
//     {
//         // Add changes to page actions here
//     }

//     var
//         myInt: Integer;
// }