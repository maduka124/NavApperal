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

    actions
    {
        addafter("Insert Conv. LCY Rndg. Lines")
        {
            action("Cash Receipt Voucher")
            {
                ApplicationArea = All;
                Image = Print;
                Caption = 'Cash Receipt Voucher';
                trigger OnAction()
                var
                    CashReceiptReport: Report CashReceiptReport;
                begin
                    CashReceiptReport.Set_value(Rec."Document No.");
                    CashReceiptReport.RunModal();
                end;
            }
        }
    }
}
