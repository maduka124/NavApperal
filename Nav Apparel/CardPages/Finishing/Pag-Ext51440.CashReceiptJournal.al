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
                    GenJRec: Record "Gen. Journal Line";

                begin
                    GenJRec.Reset();
                    GenJRec.SetRange("Journal Template Name", Rec."Journal Template Name");
                    GenJRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    GenJRec.SetRange("Document No.", Rec."Document No.");
                    if GenJRec.FindFirst() then
                        Report.RunModal(51439, true, true, GenJRec);

                end;


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
