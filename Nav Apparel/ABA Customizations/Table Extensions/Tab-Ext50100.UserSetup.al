// tableextension 50100 UserSetup extends "User Setup"
// {
//     fields
//     {
//         field(50100; "Req. Worksheet Batch"; Code[10])
//         {
//             Caption = 'Req. Worksheet Batch';
//             DataClassification = ToBeClassified;
//             TableRelation = "Requisition Wksh. Name".Name where("Template Type" = filter("Req."));
//         }
//         field(50101; "Consump. Journal Qty. Approve"; Boolean)
//         {
//             Caption = 'Approve Over Quantity Issuing';
//             DataClassification = ToBeClassified;
//         }
//         field(50102; "Head of Department"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50103; "Gen. Issueing Approve"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50104; "Consumption Approve"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50105; "Requsting Department Name"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Department."Department Name";
//             ValidateTableRelation = false;
//         }
//         field(50106; "Daily Requirement Approver"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "User Setup";
//         }
//         field(50107; "Gen. Issueing Approver"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "User Setup";
//         }
//     }
// }
