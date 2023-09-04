pageextension 51413 SalesInvoiceUpdateExt extends "Posted Sales Inv. - Update"
{
    layout
    {
        addafter("Company Bank Account Code")
        {
            field("Export Ref No."; Rec."Export Ref No.")
            {
                ApplicationArea = All;

                trigger OnValidate()
                var
                    ExportReferenceLineRec: Record ExportReferenceLine;
                begin

                    ExportReferenceLineRec.Reset();
                    ExportReferenceLineRec.SetRange("Invoice No", Rec."No.");

                    if ExportReferenceLineRec.FindSet() then
                        Error('This invoice already assigned to %1', ExportReferenceLineRec."No.");

                end;
            }
        }
    }
}