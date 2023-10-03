pageextension 51400 GeneralJournal extends "General Journal"
{
    layout
    {
        // addafter("Bal. Account No.")
        // {
        //     field("Cheque printed";Rec."Cheque printed")
        //     {
        //         ApplicationArea= All;
        //         Editable = false;
        //     }
        // }

    }
    actions
    {
        addafter(Reconcile)
        {
            action("Journal Voucher")
            {
                Caption = 'Journal Voucher';
                Image = Check;
                Promoted = true;
                //PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    JnlLin: Record "Gen. Journal Line";
                begin
                    JnlLin.RESET;
                    //JnlLin.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    JnlLin.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    JnlLin.SETRANGE("Document No.", Rec."Document No.");
                    //JnlLin.SetRange("Line No.", Rec."Line No.");
                    REPORT.RUNMODAL(51401, true, true, JnlLin);
                end;
            }
        }
        modify(Post)
        {
            trigger OnBeforeAction()
            begin
                Rec.TestField("Payment Method Code");
            end;
        }

    }
    var

}