report 51405 "Payment Journal"
{
    ApplicationArea = All;
    Caption = 'Cash Payment Voucher';
    UsageCategory = ReportsAndAnalysis;
    // DefaultLayout = RDLC;
    RDLCLayout = 'Report_Layouts/PaymentJournal.rdl';
    dataset
    {
        dataitem(GenJournalLine; "Gen. Journal Line")
        {
            // column(Debit_Amount; "Debit Amount")
            // { }
            // column(Credit_Amount; "Credit Amount")
            // { }
            column(Document_No_; "Document No.")
            { }
            column(Document_Date; "Document Date")
            { }
            column(Description; Description)
            { }
            column(External_Document_No_; "External Document No.")
            { }
            column(Amount; Amount)
            { }
            column(Account_No_; "Account No.")
            { }
            column(Amount__LCY_; "Amount (LCY)")
            { }
            column(AccName; AccName)
            { }
            column(NumberText_2_; NumberText[2])
            { }
            column(NumberText_1_; NumberText[1])
            { }
            column(LocationName; LocationName)
            { }
            column(LocationAddress1; LocationAddress1)
            { }
            column(LocationAddress2; LocationAddress2)
            { }
            column(CurrencyCode; CurrencyCode)
            { }
            column(DebitUSD; DebitUSD)
            { }
            column(CreditUSD; CreditUSD)
            { }
            column(DebitUSD2; DebitUSD2)
            { }
            column(CreditUSD1; CreditUSD1)
            { }
            column(PaymntMethd; PaymntMethd.Description)
            { }
            column(ExDocNo; ExDocNo)
            { }

            trigger OnAfterGetRecord()
            var
                GLAccRec: Record "G/L Account";
                VendorRec: Record Vendor;
                CustomerRec: Record Customer;
                BankAccRec: Record "Bank Account";
                FixedAsstRec: Record "Fixed Asset";

            begin
                DebitUSD2 := 0;
                CreditUSD1 := 0;
                if "Account Type" = "Account Type"::Customer then begin
                    if CustomerRec.get("Account No.") then;
                    AccName := CustomerRec.Name;
                end
                else
                    if "Account Type" = "Account Type"::"G/L Account" then begin
                        if GLAccRec.get("Account No.") then;
                        AccName := GLAccRec.Name;
                    end
                    else
                        if "Account Type" = "Account Type"::Vendor then begin
                            if VendorRec.get("Account No.") then;
                            AccName := VendorRec.Name;
                        end
                        else
                            if "Account Type" = "Account Type"::"Fixed Asset" then begin
                                if FixedAsstRec.get("Account No.") then;
                                AccName := FixedAsstRec.Description;
                            end
                            else
                                if "Account Type" = "Account Type"::"Bank Account" then begin
                                    if BankAccRec.get("Account No.") then;
                                    AccName := BankAccRec.Name;
                                end;

                RPTVCheck.InitTextVariable;
                RPTVCheck.FormatNoTextCustomized(NumberText, abs("Amount (LCY)"), GenJournalLine."Currency Code" + ' ' + '');
                if Location.Get("Shortcut Dimension 1 Code") then;
                LocationName := Location.Name;
                LocationAddress1 := Location.Address;
                LocationAddress2 := Location."Address 2";

                if "Currency Code" = '' then begin
                    DebitUSD2 := "Debit Amount";
                    CreditUSD1 := "Credit Amount";

                    CurrncyExchngRate.Reset();
                    CurrncyExchngRate.SetRange("Currency Code", 'USD');
                    if CurrncyExchngRate.FindLast() then begin
                        DebitUSD := "Debit Amount" / CurrncyExchngRate."Relational Exch. Rate Amount";
                        CreditUSD := "Credit Amount" / CurrncyExchngRate."Relational Exch. Rate Amount";
                    end;
                end
                else begin

                    CreditUSD1 := "Credit Amount" * ("Amount (LCY)" / Amount);
                    DebitUSD2 := "debit Amount" * ("Amount (LCY)" / Amount);

                    DebitUSD := "Debit Amount";
                    CreditUSD := "Credit Amount";
                end;

                if PaymntMethd.Get("Payment Method Code") then;

                VndrLdgrEntry.Reset();  //Nisal Support - KI 2023.09.12
                VndrLdgrEntry.SetRange("Applies-to ID", GenJournalLine."Document No.");
                if VndrLdgrEntry.FindFirst() then begin
                    ExDocNo := VndrLdgrEntry."External Document No.";
                end;
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    // trigger OnPostReport()
    // begin
    //     if not CurrReport.Preview then begin
    //         GenJurnal."Cheque printed" := true;
    //     end;
    // end;

    var
        GenJurnal: Record "Gen. Journal Line";
        AccName: Text[100];
        CheckCus: Report "Check-Customized";
        NumberText: array[2] of Text[100];
        RPTVCheck: Report "Check-Customized";
        Location: Record Location;
        LocationName: Text[100];
        LocationAddress1: Text[100];
        LocationAddress2: Text[100];
        CurrncyExchngRate: Record "Currency Exchange Rate";
        CreditUSD1: Decimal;
        DebitUSD2: Decimal;
        CurrencyCode: code[20];
        PaymntMethd: Record "Payment Method";
        CreditUSD: Decimal;
        DebitUSD: Decimal;
        VndrLdgrEntry: Record "Vendor Ledger Entry";
        ExDocNo: Code[35];
}
