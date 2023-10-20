report 51439 CashReceiptReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Cash Receipt Voucher';
    RDLCLayout = 'Report_Layouts/Finance/CashReceiptReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = where("Bal. Account Type" = filter('G/L Account'), "Journal Template Name" = filter('CASH RECE'));
            column(Document_No_; "Document No.")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(VendorName; VendorName)
            { }
            column(Description; Description)
            { }
            column(Amount; Amount)
            { }
            column(Account_No_; "Account No.")
            { }
            column(AccountHead; AccountHead)
            { }
            column(Debit_Amount; "Debit Amount")
            { }
            column(Credit_Amount; "Credit Amount")
            { }
            column(Amount__LCY_; "Amount (LCY)")
            { }
            column(HeadAmount; HeadAmount)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(NumberText_2_; NumberText[2])
            { }
            column(NumberText_1_; NumberText[1])
            { }
            column(BillNo; BillNo)
            { }
            // column(factor)
            // { }
            // column()
            // { }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                TotLcy: Decimal;
            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                GenJLineRec.Reset();
                GenJLineRec.SetRange("Document No.", "Document No.");
                GenJLineRec.SetRange("Account Type", GenJLineRec."Account Type"::Customer);
                if GenJLineRec.FindSet() then begin
                    VendorRec.Reset();
                    VendorRec.SetRange("No.", GenJLineRec."Account No.");
                    if VendorRec.FindSet() then begin
                        VendorName := VendorRec.Name;
                    end;
                end;

                AccountHead := '';
                if "Account Type" = "Account Type"::Customer then begin
                    VendorRec.Reset();
                    VendorRec.SetRange("No.", "Account No.");
                    if VendorRec.FindSet() then begin
                        AccountHead := VendorRec.Name;
                    end;
                end
                else begin
                    BankAcountRec.Reset();
                    BankAcountRec.SetRange("No.", "Account No.");
                    if BankAcountRec.FindSet() then begin
                        AccountHead := BankAcountRec.Name;
                    end;
                end;

                GenJLineRec.Reset();
                GenJLineRec.SetRange("Document No.", "Document No.");
                GenJLineRec.SetRange("Account Type", GenJLineRec."Account Type"::"Bank Account");
                if GenJLineRec.FindSet() then begin
                    HeadAmount := GenJLineRec.Amount;
                end;

                TotLcy := 0;
                GenJLineRec.Reset();
                GenJLineRec.SetRange("Document No.", "Document No.");
                GenJLineRec.SetRange("Account Type", GenJLineRec."Account Type"::Customer);
                if GenJLineRec.FindSet() then begin
                    GenJLineRec.CalcSums("Amount (LCY)");
                    TotLcy := GenJLineRec."Amount (LCY)";
                    RPTVCheck.InitTextVariable;
                    // RPTVCheck.FormatNoTextCustomized(NumberText, abs(GenJLineRec."Amount (LCY)"), GenJLineRec."Currency Code" + ' ' + '');
                    RPTVCheck.FormatNoTextCustomized(NumberText, abs(TotLcy), '' + ' ' + '');
                end;

                VendorLeRec.Reset();
                VendorLeRec.SetRange("Applies-to ID", "Document No.");
                if VendorLeRec.FindFirst() then begin
                    // BillNo := VendorLeRec."External Document No.";
                    repeat
                        BillNo := BillNo + '|' + VendorLeRec."External Document No.";
                    until VendorLeRec.Next() = 0;
                end;
            end;

            trigger OnPreDataItem()
            var

            begin
                SetRange("Document No.", FilterDoc);
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Filter By';
                    field(FilterDoc; FilterDoc)
                    {
                        ApplicationArea = All;
                        Caption = 'Document No';
                        Editable = false;

                    }
                }
            }
        }
    }

    procedure Set_value(DocNo: Code[20])
    var
    begin
        FilterDoc := DocNo;
    end;

    var
        VendorLeRec: Record "Vendor Ledger Entry";
        BillNo: Text[35];
        CustLedgRec: Record "Cust. Ledger Entry";
        FilterDoc: Code[20];
        BankAcountRec: Record "Bank Account";
        RPTVCheck: Report "Check-Customized";
        NumberText: array[2] of Text[100];
        comRec: Record "Company Information";
        HeadAmount: Decimal;
        AccountHead: Text[200];
        GenJLineRec: Record "Gen. Journal Line";
        VendorName: Text[200];
        myInt: Integer;
        VendorRec: Record Customer;
}