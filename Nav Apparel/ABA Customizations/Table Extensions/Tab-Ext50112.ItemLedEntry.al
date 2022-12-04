// tableextension 50112 ItemLedEntry extends "Item Ledger Entry"
// {
//     fields
//     {
//         field(50100; "Quantity Approved"; Boolean)
//         {
//             Caption = 'Quantity Approved';
//             DataClassification = ToBeClassified;
//         }
//         field(50101; "Qty. Approved UserID"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50102; "Qty. Approved Date/Time"; DateTime)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50103; "Transfer Order Created"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         // field(50104; "Style Name"; text[50])
//         // {
//         //     DataClassification = ToBeClassified;
//         // }

//         // field(50105; "Style No."; Code[20])
//         // {
//         //     DataClassification = ToBeClassified;
//         //     TableRelation = "Style Master"."No.";
//         // }

//         field(50106; PO; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             //TableRelation = "Style Master PO"."PO No." where("Style No." = field("Style No."));
//             //ValidateTableRelation = false;
//         }
//         field(50107; "Daily Consumption Doc. No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50108; "Posted Daily Output"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50109; "Invent. Posting Grp."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50110; "Style Transfer Doc. No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Style transfer Header" where(Status = filter(Approved));
//         }
//         field(50111; "Line Approved"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50112; "Line Approved UserID"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(50113; "Line Approved DateTime"; DateTime)
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(50114; "Main Category Name"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Main Category"."Main Category Name" where("General Issuing" = filter(true));
//             ValidateTableRelation = false;
//         }
//         field(50115; "Requsting Department Name"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Department."Department Name";
//             ValidateTableRelation = false;
//         }
//         field(50116; "Original Daily Requirement"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50117; "Gen. Issue Doc. No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }
// }
