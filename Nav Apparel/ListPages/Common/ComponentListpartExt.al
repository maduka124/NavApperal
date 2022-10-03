pageextension 50796 "Component Listpart Extension" extends "Prod. Order Components"
{

    layout
    {
        addbefore("Expected Quantity")
        {
            field("Quantity In Stock"; "Quantity In Stock")
            {
                ApplicationArea = ALL;
            }
        }
    }


    // trigger OnOpenPage()
    // var
    //     ItemLedgerRec: Record "Item Ledger Entry";
    // begin
    //     ItemLedgerRec.Reset();
    //     ItemLedgerRec.SetRange("Item No.", "Item No.");
    //     ItemLedgerRec.SetRange("Location Code", "Location Code");
    //     if ItemLedgerRec.FindSet() then begin
    //         repeat
    //             "Quantity In Stock" += ItemLedgerRec."Remaining Quantity";
    //         until ItemLedgerRec.Next() = 0;
    //     end;
    // end;

    trigger OnAfterGetCurrRecord()
    var
        ItemLedgerRec: Record "Item Ledger Entry";
    begin
        ItemLedgerRec.Reset();
        ItemLedgerRec.SetRange("Item No.", "Item No.");
        if "Location Code" <> '' then
            ItemLedgerRec.SetRange("Location Code", "Location Code");

        if ItemLedgerRec.FindSet() then begin
            repeat
                "Quantity In Stock" += ItemLedgerRec."Remaining Quantity";
            until ItemLedgerRec.Next() = 0;
        end;
    end;
}