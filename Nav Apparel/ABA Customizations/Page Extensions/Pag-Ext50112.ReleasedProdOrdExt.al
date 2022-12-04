// pageextension 50112 ReleasedProdOrdExt extends "Released Production Order"
// {
//     actions
//     {
//         addafter("Change &Status")
//         {
//             action("Washing orders")
//             {
//                 Image = ViewDetails;
//                 ApplicationArea = All;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 PromotedIsBig = true;
//                 trigger OnAction()
//                 var
//                     SalesHedd: Record "Sales Header";
//                     WashSalesHedd: Record "Sales Header";
//                 begin
//                     if not SalesHedd.get(SalesHedd."Document Type"::Order, rec."Source No.") then
//                         Error('Sales Order not found for %1', rec."No.");

//                     if SalesHedd."PO No" = '' then
//                         Error('PO no must have a value');

//                     WashSalesHedd.Reset();
//                     WashSalesHedd.SetRange("PO No", SalesHedd."PO No");
//                     WashSalesHedd.SetFilter("No.", '%1', 'WSH*');
//                     Page.Run(9305, WashSalesHedd);
//                 end;
//             }
//         }
//     }
// }
