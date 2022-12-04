// pageextension 50118 NavAppRoleCenter extends "Nav Apperal Role Center"
// {
//     layout
//     {

//     }
//     actions
//     {
//         addlast("Merchandizing Group")
//         {
//             action("Style Transfers")
//             {
//                 RunObject = page "Style transfer List";
//                 ApplicationArea = All;
//             }
//             action("Style Transfer Approvals")
//             {
//                 RunObject = page "Style transfer Approvals";
//                 ApplicationArea = All;
//             }
//         }
//         addlast("Merchandizing Reports")
//         {
//             action("Style Transfer Report")
//             {
//                 Caption = 'Style Transfer Report';
//                 Enabled = true;
//                 RunObject = report StyleTransferReport;
//                 ApplicationArea = all;
//             }
//         }
//         addlast(Store)
//         {
//             action("SS Transfers")
//             {
//                 RunObject = page "Style transfer List";
//                 RunPageView = where(Status = filter(Approved));
//                 ApplicationArea = All;
//             }
//             action("Approved General Issuance")
//             {
//                 ApplicationArea = All;
//                 Caption = 'General Item Requisition';
//                 RunObject = page "General Issue List";
//                 RunPageView = where(Status = filter(Approved));
//             }
//             action("Approved Raw Material Issue")
//             {
//                 Caption = 'Raw Material Requisition';
//                 ApplicationArea = All;
//                 RunObject = page "Daily Consumption List";
//                 RunPageView = where(Status = filter(Approved), "Issued UserID" = filter(''));
//             }
//             action("Posted Material Requests")
//             {
//                 Caption = 'Posted Raw Material Requisition';
//                 ApplicationArea = All;
//                 RunObject = page "Daily Consumption List";
//                 RunPageView = where(Status = filter(Approved), "Issued UserID" = filter(<> ''));
//             }
//             action("Bin Card")
//             {
//                 Caption = 'Bin Card';
//                 ApplicationArea = All;
//                 RunObject = page "Item Ledger Entries";
//             }

//         }
//         addlast("Warehouse Reports")
//         {
//             action("General Issue Note Report")
//             {
//                 Caption = 'General Issue Note Report';
//                 Enabled = true;
//                 RunObject = report GeneralIssueReport;
//                 ApplicationArea = all;
//             }
//         }
//         addlast(Common)
//         {
//             action("General Item Requisitions")
//             {
//                 ApplicationArea = All;
//                 Caption = 'General Item Requisition';
//                 RunObject = page "General Issue List";
//                 RunPageView = where(Status = filter(Open | "Pending Approval"));
//             }
//             action("Raw Material Issue")
//             {
//                 Caption = 'Raw Material Requisition';
//                 ApplicationArea = All;
//                 RunObject = page "Daily Consumption List";
//                 RunPageView = where(Status = filter(Open | "Pending Approval"));
//             }
//             // action("Location Transfer Journal")
//             // {
//             //     Caption = 'Location Transfer Journal';
//             //     ApplicationArea = All;
//             //     RunObject = page "Location Transfer Journal";
//             //     //RunPageView = where(Status = filter(Open | "Pending Approval"));
//             // }
//         }
//         modify("Purchase Orders1")
//         {
//             Caption = 'Purchase Orders';
//             ApplicationArea = All;
//         }
//     }
// }
