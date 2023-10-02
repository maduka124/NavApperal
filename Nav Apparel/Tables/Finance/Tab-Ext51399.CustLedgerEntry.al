// tableextension 51399 "Cust.LedgerEntry" extends "Cust. Ledger Entry"
// {
//     fields
//     {
//         field(50000; "Factory Inv. No"; Text[35])
//         {
//             //DataClassification = ToBeClassified;
//             FieldClass = FlowField;
//             CalcFormula = lookup("Sales Invoice Header"."Your Reference" where("No." = field("Document No.")));
//         }
//     }

// }
