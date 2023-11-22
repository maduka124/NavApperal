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
        addafter("Debit Amount")
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

            field(Status; Rec.Status)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Status field.';
            }

        }

        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
                GenJurnaLineRec: Record "Gen. Journal Line";
                UserRec: Record "User Setup";
            begin

                UserRec.Reset();
                UserRec.get(UserId);

                if (UserRec."User ID" = 'APPROVAL.PAL') OR (UserRec."User ID" = 'PAL.ACCOUNTS') then begin

                    Rec."Shortcut Dimension 1 Code" := 'PAL';
                    Rec."Shortcut Dimension 2 Code" := 'PAL-SEW';

                    // rec.Validate("Shortcut Dimension 1 Code", "Dimension Set ID");
                    Rec.Modify(true);

                end;
            end;
        }


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

    // trigger OnAfterGetRecord()
    // var
    //     GenJurnaLineRec: Record "Gen. Journal Line";
    //     UserRec: Record "User Setup";
    // begin

    //     UserRec.Reset();
    //     UserRec.get(UserId);

    //     if (UserRec."User ID" = 'APPROVAL.PAL') OR (UserRec."User ID" = 'PAL.ACCOUNTS') then begin
    //         GenJurnaLineRec.Reset();
    //         GenJurnaLineRec.SetRange("Journal Template Name", 'GENERAL');

    //         if GenJurnaLineRec.FindSet() then begin
    //             repeat
    //                 GenJurnaLineRec."Shortcut Dimension 1 Code" := 'PAL';
    //                 GenJurnaLineRec."Shortcut Dimension 2 Code" := 'PAL-SEW';
    //                 GenJurnaLineRec.Modify(true);
    //             until GenJurnaLineRec.Next() = 0;
    //         end;
    //     end
    //     else begin
    //         GenJurnaLineRec.Reset();
    //         GenJurnaLineRec.SetRange("Journal Template Name", 'GENERAL');

    //         if GenJurnaLineRec.FindSet() then begin
    //             repeat
    //                 GenJurnaLineRec."Shortcut Dimension 1 Code" := '';
    //                 GenJurnaLineRec."Shortcut Dimension 2 Code" := '';
    //                 GenJurnaLineRec.Modify(true);
    //             until GenJurnaLineRec.Next() = 0;
    //         end;

    //     end;

    // end;

}
