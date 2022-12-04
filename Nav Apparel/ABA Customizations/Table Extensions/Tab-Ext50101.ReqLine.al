// tableextension 50101 Req_Line extends "Requisition Line"
// {
//     fields
//     {
//         field(50100; "Purchase Order Nos."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "No. Series";
//         }
//         field(50101; "Created User Name"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(50102; "Modified User Name"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         modify("Shortcut Dimension 1 Code")
//         {
//             trigger OnAfterValidate()
//             var
//                 DimValues: Record "Dimension Value";
//                 GenLedSetup: Record "General Ledger Setup";
//             begin
//                 if "Ref. Order Type" = "Ref. Order Type"::Purchase then begin
//                     if "Shortcut Dimension 1 Code" <> '' then begin
//                         GenLedSetup.Get();
//                         DimValues.Get(GenLedSetup."Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
//                         DimValues.TestField("No. Series - PO");
//                         "Purchase Order Nos." := DimValues."No. Series - PO";
//                     end;
//                 end;
//             end;
//         }
//     }
// }
