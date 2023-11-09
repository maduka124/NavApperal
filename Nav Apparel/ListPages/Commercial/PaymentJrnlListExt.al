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
        addafter("Debit Amount")
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
                // ToolTip = 'Specifies the value of the Status field.';
            }
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
        modify("Account No.")
        {
            trigger OnAfterValidate()
            var
                GLRec: Record "G/L Account";
                EmpRec: Record Employee;
                BankRec: Record "Bank Account";
                VendorRec: Record Vendor;
                CustomerRec: Record Customer;
                FixREc: Record "Fixed Asset";
            begin
                FixREc.Reset();
                FixREc.SetRange("No.", Rec."Account No.");
                if FixREc.FindSet() then begin
                    Rec."Account Name" := FixREc.Description;
                    Rec.Modify();
                    CurrPage.Update();
                end;

                GLRec.Reset();
                GLRec.SetRange("No.", Rec."Account No.");
                if GLRec.FindSet() then begin
                    Rec."Account Name" := GLRec.Name;
                    Rec.Modify();
                    CurrPage.Update();
                end;

                EmpRec.Reset();
                EmpRec.SetRange("No.", Rec."Account No.");
                if EmpRec.FindSet() then begin
                    Rec."Account Name" := EmpRec."First Name";
                    Rec.Modify();
                    CurrPage.Update();
                end;

                BankRec.Reset();
                BankRec.SetRange("No.", Rec."Account No.");
                if BankRec.FindSet() then begin
                    Rec."Account Name" := BankRec.Name;
                    Rec.Modify();
                    CurrPage.Update();
                end;

                VendorRec.Reset();
                VendorRec.SetRange("No.", Rec."Account No.");
                if VendorRec.FindSet() then begin
                    Rec."Account Name" := VendorRec.Name;
                    Rec.Modify();
                    CurrPage.Update();
                end;

                CustomerRec.Reset();
                CustomerRec.SetRange("No.", Rec."Account No.");
                if CustomerRec.FindSet() then begin
                    Rec."Account Name" := CustomerRec.Name;
                    Rec.Modify();
                    CurrPage.Update();
                end;
            end;
        }
        addafter("Account No.")
        {
            field("Account Name 1"; Rec."Account Name")
            {
                Caption = 'Account Name';
                ApplicationArea = All;
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
        // modify(SendApprovalRequestJournalBatch)
        // {
        //     trigger OnAfterAction()

        //     begin
        //         Rec.Status := Rec.Status::"Pending Approval";
        //     end;
        //     // Visible = false;

        // }

    }
}