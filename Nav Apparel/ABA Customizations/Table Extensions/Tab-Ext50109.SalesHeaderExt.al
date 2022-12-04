// tableextension 50109 SalesHeaderExt extends "Sales Header"
// {
//     fields
//     {
//         // modify("Shortcut Dimension 1 Code")
//         // {
//         //     trigger OnAfterValidate()
//         //     var
//         //         GenLedSetup: Record "General Ledger Setup";
//         //         DimValues: Record "Dimension Value";
//         //         SalesRecSetup: Record "Sales & Receivables Setup";
//         //     begin
//         //         if "Document Type" = "Document Type"::Order then
//         //             if "Shortcut Dimension 1 Code" <> '' then begin
//         //                 GenLedSetup.Get();
//         //                 DimValues.Get(GenLedSetup."Shortcut Dimension 1 Code", "Shortcut Dimension 1 Code");
//         //                 DimValues.TestField("No. Series - Invoicing");
//         //                 DimValues.TestField("No. Series - Shipping");

//         //                 "Posting No. Series" := DimValues."No. Series - Invoicing";
//         //                 "Shipping No. Series" := DimValues."No. Series - Shipping";
//         //                 TESTFIELD("Posting No.", '');
//         //             end
//         //             else begin
//         //                 SalesRecSetup.Get();
//         //                 Validate("Posting No. Series", SalesRecSetup."Posted Invoice Nos.");
//         //                 Validate("Shipping No. Series", SalesRecSetup."Posted Shipment Nos.");
//         //             end;
//         //     end;
//         // }
//     }
// }
