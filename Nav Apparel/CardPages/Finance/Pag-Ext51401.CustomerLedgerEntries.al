pageextension 51401 CustomerLedgerEntries extends "Apply Customer Entries"
{
    layout
    {
        addafter("Document Type")
        {
            field("Factory Inv. No"; Rec."Factory Inv. No")
            {
                ApplicationArea = all;
            }
        }
        addbefore("Posting Date")
        {
            field("Applied Line No."; Rec."Applied Line No.")
            {
                ApplicationArea = All;
            }
        }
    }
}
