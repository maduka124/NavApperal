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
                // Visible=EditableGB;
                trigger OnAction()
                var
                    CashReceiptReport: Report CashReceiptReport;
                    CashReceiptGL: Report CashReceiptReportGL;
                    GenJRec: Record "Gen. Journal Line";

                begin
                    GenJRec.Reset();
                    GenJRec.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    GenJRec.SetRange("Document No.", Rec."Document No.");
                    if GenJRec.FindFirst() then
                        // repeat
                                Report.RunModal(51439, true, true, GenJRec);
                    //     end;
                end;

                // until GenJRec.Next() = 0;

                // end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        EditableGB := true;

        if Rec."Account Type" = Rec."Account Type"::"G/L Account" then begin
            EditableGB := false;
        end;
    end;

    var
        EditableGB: Boolean;
}
