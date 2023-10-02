pageextension 51190 PaymentJrnlList extends "Payment Journal"
{
    layout
    {
        addafter("Document No.")
        {
            field("LC/Contract No."; rec."LC/Contract No.")
            {
                ApplicationArea = all;
                Caption = 'LC/Contract No';
                Editable = false;
            }

            field("B2BLC No"; rec."B2BLC No")
            {
                ApplicationArea = all;
                Caption = 'B2BLC No';
                Editable = false;
            }
        }

        addafter("Bal. Account No.")
        {
            field("Cheque printed"; Rec."Cheque printed")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    actions
    {
        addafter(PrintCheck)
        {
            action("Cheque Print Vendor")
            {
                Caption = 'Cheque Print';
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
                    JnlLin.SETRANGE("Journal Template Name", Rec."Journal Template Name");
                    JnlLin.SETRANGE("Journal Batch Name", Rec."Journal Batch Name");
                    JnlLin.SETRANGE("Document No.", Rec."Document No.");
                    JnlLin.SetRange("Line No.", Rec."Line No.");
                    REPORT.RUNMODAL(51399, true, true, JnlLin);

                    // JnlLin.Reset();
                    // JnlLin.SetRange("Journal Template Name", Rec."Journal Template Name");
                    // JnlLin.SetRange("Journal Batch Name", rec."Journal Batch Name");
                    // JnlLin.SETRANGE("Document No.", Rec."Document No.");
                    // JnlLin.SETRANGE("Line No.", Rec."Line No.");
                    // if JnlLin.FindFirst() then begin
                    //     JnlLin."Cheque printed" := true;
                    //     JnlLin.Modify();
                    // end;
                end;
            }

        }
        addafter(Reconcile)
        {
            action("Payment Voucher")
            {
                Caption = 'Cash Payment Voucher';
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
                    REPORT.RUNMODAL(51405, true, true, JnlLin);


                end;
            }
        }
        addafter("Payment Voucher")
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

    }
}