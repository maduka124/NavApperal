tableextension 50685 SalesOrderExt extends "Sales Line"
{
    fields
    {
        // field(200; "Total Qty"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        // }
    }

    // trigger OnAfterDelete()
    // var
    //     SalesLineRec: Record "Sales Line";
    // begin
    //     SalesLineRec.Reset();
    //     SalesLineRec.SetRange("Document Type", "Document Type");
    //     SalesLineRec.SetRange("Document No.", "Document No.");
    //     SalesLineRec.SetRange("Line No.", "Line No.");

    //     if SalesLineRec.FindSet() then begin
    //         SalesLineRec.Delete();
    //         "Total Qty" := "Total Qty" - SalesLineRec.Quantity;
    //         SalesLineRec.Modify();
    //     end;
    // end;
}