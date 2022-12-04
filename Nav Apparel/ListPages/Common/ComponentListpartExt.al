pageextension 50796 "Component Listpart Extension" extends "Prod. Order Components"
{

    layout
    {
        addbefore("Item No.")
        {
            field("Prod. Order No."; rec."Prod. Order No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Transfer Order Created"; rec."Transfer Order Created")
            {
                ApplicationArea = All;
            }
        }

        addbefore("Expected Quantity")
        {
            field("Quantity In Stock"; Rec."Quantity In Stock")
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
        ItemLedgerRec.SetRange("Item No.", Rec."Item No.");
        if Rec."Location Code" <> '' then
            ItemLedgerRec.SetRange("Location Code", Rec."Location Code");

        if ItemLedgerRec.FindSet() then begin
            repeat
                Rec."Quantity In Stock" += ItemLedgerRec."Remaining Quantity";
            until ItemLedgerRec.Next() = 0;
        end;
    end;
}