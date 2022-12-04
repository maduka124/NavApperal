// pageextension 50123 POCardExt extends "Purchase Order"
// {
//     actions
//     {
//         addafter(Statistics)
//         {
//             action("Upload Lot Tracking Lines")
//             {
//                 Image = CopySerialNo;
//                 ApplicationArea = All;
//                 Promoted = true;
//                 PromotedCategory = Process;
//                 trigger OnAction()
//                 var
//                     ExcelUpload: Codeunit "Customization Management";
//                 begin
//                     if not Confirm('Do you want to upload the Serial lines?', false) then
//                         exit;

//                     ExcelUpload.ImportPurchaseTrackingExcel(Rec);
//                 end;
//             }
//         }
//     }
// }
