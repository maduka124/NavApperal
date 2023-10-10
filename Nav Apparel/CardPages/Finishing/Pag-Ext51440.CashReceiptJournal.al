pageextension 51440 CashReceiptJournal extends "Cash Receipt Journal"
{
    layout
    {
        addafter("Credit Amount")
        {
            field(Amounts; rec.Amount)
            {
                ApplicationArea = All;
            }
            field("Amount(LCY)"; Rec."Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Amount (LCY)';
            }
            field("Payment Method Code."; Rec."Payment Method Code")
            {
                ApplicationArea = All;
                Caption = 'Payment Method Code';
            }
        }
    }
}
