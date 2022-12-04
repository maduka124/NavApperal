// tableextension 50113 TransHeddExt extends "Transfer Header"
// {
//     fields
//     {
//         field(50100; "Style Name"; text[50])
//         {
//             DataClassification = ToBeClassified;
//         }

//         field(50101; PO; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Style Master PO"."PO No." where("Style No." = field("Style No."));
//             ValidateTableRelation = false;
//         }
//     }
// }
