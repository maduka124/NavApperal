page 50770 "Bank Ref Collection Card"
{
    PageType = Card;
    SourceTable = BankRefCollectionHeader;
    Caption = 'Export Bank Ref. Collection';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("BankRefNo."; rec."BankRefNo.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Bank Reference No';

                    trigger OnValidate()
                    var

                        BankRefCollLineRec: Record BankRefCollectionLine;
                        BankRefHeaderRec: Record BankReferenceHeader;
                        BankRefInvRec: Record BankReferenceInvoice;
                        LineNo: Integer;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                        NavAppSetup: Record "NavApp Setup";
                        CurrencyExchangeRate: Record "Currency Exchange Rate";
                        CurrencyFactor: Decimal;
                        ExchangeRateDate: Date;
                        LCMasterRec: Record "Contract/LCMaster";
                        InvoiceAmt: Decimal;
                    begin

                        ExchangeRateDate := Today();
                        CurrencyFactor := CurrencyExchangeRate.GetCurrentCurrencyFactor('USD');
                        CurrencyExchangeRate.GetLastestExchangeRate('USD', ExchangeRateDate, rec."Exchange Rate");

                        BankRefCollLineRec.Reset();
                        BankRefCollLineRec.SetRange("BankRefNo.", rec."BankRefNo.");

                        if not BankRefCollLineRec.FindSet() then begin

                            BankRefHeaderRec.Reset();
                            BankRefHeaderRec.SetRange("BankRefNo.", rec."BankRefNo.");
                            if BankRefHeaderRec.FindSet() then begin

                                rec.Total := BankRefHeaderRec.Total;
                                rec."LC/Contract No." := BankRefHeaderRec."LC/Contract No.";

                                //Get BU code for he style
                                LCMasterRec.Reset();
                                LCMasterRec.SetRange("Contract No", BankRefHeaderRec."LC/Contract No.");
                                if LCMasterRec.FindSet() then begin
                                    rec."Cash Rec. Journal Batch" := LCMasterRec."Global Dimension Code";
                                    rec."Journal Batch" := LCMasterRec."Global Dimension Code";
                                end;

                                BankRefInvRec.Reset();
                                BankRefInvRec.SetRange(BankRefNo, rec."BankRefNo.");
                                if BankRefInvRec.FindSet() then begin
                                    repeat
                                        LineNo += 1;
                                        InvoiceAmt += BankRefInvRec."Ship Value";
                                        BankRefCollLineRec.Init();
                                        BankRefCollLineRec."BankRefNo." := rec."BankRefNo.";
                                        BankRefCollLineRec."Airway Bill Date" := BankRefHeaderRec."Airway Bill Date";
                                        BankRefCollLineRec.AirwayBillNo := BankRefHeaderRec.AirwayBillNo;
                                        BankRefCollLineRec."Created User" := UserId;
                                        BankRefCollLineRec."Created Date" := WorkDate();
                                        BankRefCollLineRec."Invoice Amount" := BankRefInvRec."Ship Value";
                                        BankRefCollLineRec."Exchange Rate" := Rec."Exchange Rate";
                                        BankRefCollLineRec."Invoice Date" := BankRefInvRec."Invoice Date";
                                        BankRefCollLineRec."Invoice No" := BankRefInvRec."Invoice No";
                                        BankRefCollLineRec."LineNo." := LineNo;
                                        BankRefCollLineRec."Maturity Date" := BankRefHeaderRec."Maturity Date";
                                        BankRefCollLineRec."Reference Date" := BankRefHeaderRec."Reference Date";
                                        BankRefCollLineRec."Factory Invoice No" := BankRefInvRec."Factory Inv No";
                                        BankRefCollLineRec.Type := 'R';
                                        BankRefCollLineRec.Insert();
                                    until BankRefInvRec.Next() = 0;

                                end;
                                BankRefCollLineRec.Reset();
                                BankRefCollLineRec.SetRange("BankRefNo.", Rec."BankRefNo.");
                                BankRefCollLineRec.SetFilter(Type, '=%1', 'T');
                                if not BankRefCollLineRec.FindSet() then begin

                                    LineNo += 1;
                                    BankRefCollLineRec.Init();
                                    BankRefCollLineRec."LineNo." := LineNo;
                                    BankRefCollLineRec."BankRefNo." := rec."BankRefNo.";
                                    BankRefCollLineRec.AirwayBillNo := 'Total';
                                    BankRefCollLineRec."Invoice Amount" := InvoiceAmt;
                                    BankRefCollLineRec.Type := 'T';
                                    BankRefCollLineRec.Insert();

                                end;

                            end;

                            //Assign template 
                            NavAppSetup.Reset();
                            if NavAppSetup.FindSet() then begin
                                rec."Bank Ref. Template Name" := NavAppSetup."Bank Ref. Template Name";
                                rec."Bank Ref. Template Name1" := NavAppSetup."Bank Ref. Template Name1";
                            end;

                        end;

                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;

                        CurrPage.Update();
                    end;
                }

                field(Total; rec.Total)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Release Amount"; rec."Release Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin
                        if Rec."Release Amount" > Rec.Total then
                            Error('Release Amount cannot be greater than total');

                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."Release Amount" := (rec."Release Amount" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }

                field("Release Date"; rec."Release Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                    begin
                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            BankRefeCollRec.ModifyAll("Release Date", rec."Release Date");

                        CurrPage.Update();
                    end;
                }

                field("Exchange Rate"; rec."Exchange Rate")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                    begin
                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            BankRefeCollRec.ModifyAll("Exchange Rate", rec."Exchange Rate");

                        CurrPage.Update();
                    end;
                }

                field("Margin A/C Amount"; rec."Margin A/C Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin
                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."Margin A/C Amount" := (rec."Margin A/C Amount" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }

                field("Bank Charges"; rec."Bank Charges")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin
                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."Bank Charges" := (rec."Bank Charges" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }

                field(Tax; rec.Tax)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin
                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."Tax" := (rec."Tax" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }

                field("Currier Charges"; rec."Currier Charges")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin
                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."Currier Charges" := (rec."Currier Charges" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }

                field("FC A/C Amount"; rec."FC A/C Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin
                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."FC A/C Amount" := (rec."FC A/C Amount" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }

                field("Current A/C Amount"; rec."Current A/C Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin

                        "Total Distribution" := Rec."Margin A/C Amount" + Rec."Bank Charges" + Rec.Tax + Rec."Currier Charges" + Rec."FC A/C Amount" + Rec."Current A/C Amount";

                        if "Total Distribution" > Rec.Total then
                            Error('Please check enter values Total Distribution cannot be greater than Total ');

                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."Current A/C Amount" := (rec."Current A/C Amount" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }

                field("Journal Batch"; rec."Journal Batch")
                {
                    ApplicationArea = All;
                    Caption = 'Gen. Jrnl. Batch Name';
                    Visible = false;
                }

                field("Cash Rec. Journal Batch"; rec."Cash Rec. Journal Batch")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Rece. Batch Name';
                    Visible = false;
                }

                field("Cash Receipt Bank Account No"; rec."Cash Receipt Bank Account No")
                {
                    ApplicationArea = All;
                    Caption = 'Money Receivng Bank';

                    trigger OnValidate()
                    var
                        BankAccountRec: Record "Bank Account";
                    begin
                        BankAccountRec.Reset();
                        BankAccountRec.SetRange("Bank Account No.", rec."Cash Receipt Bank Account No");
                        if BankAccountRec.FindSet() then begin
                            rec."Cash Receipt Bank Name" := BankAccountRec.Name;
                            rec."Cash Receipt Bank No" := BankAccountRec."No.";
                        end;


                    end;
                }
                field("Total Distribution"; "Total Distribution")
                {
                    ApplicationArea = All;
                    Editable = false;

                }
            }

            group("Invoices")
            {
                part("Bank Ref Collection ListPart"; "Bank Ref Collection ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "BankRefNo." = FIELD("BankRefNo.");
                }
            }


            group("Collection Distribution")
            {
                part("Bank Ref Colle Dist ListPart"; "Bank Ref Colle Dist ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "BankRefNo." = FIELD("BankRefNo.");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Transfer to cash receipt journal")
            {
                ApplicationArea = all;
                Image = CashReceiptJournal;

                trigger OnAction()
                var
                    CashRcptJrnl: Page "Cash Receipt Journal";
                    GenJournalRec: Record "Gen. Journal Line";
                    BankRefCollecLine: Record BankRefCollectionLine;
                    SalesInvHeaderRec: Record "Sales Invoice Header";
                    CustledgerEntryrec: Record "Cust. Ledger Entry";
                    LineNo: BigInteger;
                begin

                    if rec."Cash Rec. Journal Batch" = '' then
                        Error('Cash Rec. Journal Batch is blank. Please check the BU code of Contract : %1', rec."LC/Contract No.");

                    //Get max line no
                    GenJournalRec.Reset();
                    GenJournalRec.SetRange("Journal Template Name", rec."Bank Ref. Template Name");
                    GenJournalRec.SetRange("Journal Batch Name", rec."Cash Rec. Journal Batch");

                    if GenJournalRec.FindLast() then
                        LineNo := GenJournalRec."Line No.";

                    BankRefCollecLine.Reset();
                    BankRefCollecLine.SetRange("BankRefNo.", rec."BankRefNo.");
                    BankRefCollecLine.SetFilter("Transferred To Cash Receipt", '=%1', false);

                    if BankRefCollecLine.Findset() then
                        repeat

                            LineNo += 100;
                            GenJournalRec.Init();
                            GenJournalRec."Journal Template Name" := rec."Bank Ref. Template Name";
                            GenJournalRec."Journal Batch Name" := rec."Cash Rec. Journal Batch";
                            GenJournalRec."Line No." := LineNo;
                            GenJournalRec."Invoice No" := BankRefCollecLine."Invoice No";
                            GenJournalRec."BankRefNo" := BankRefCollecLine."BankRefNo.";
                            GenJournalRec.Validate("Document Type", GenJournalRec."Document Type"::Payment);
                            GenJournalRec.Validate("Document No.", BankRefCollecLine."Invoice No");
                            GenJournalRec."Document Date" := BankRefCollecLine."Invoice Date";
                            GenJournalRec."Posting Date" := WorkDate();
                            GenJournalRec.Description := 'Bank Ref : ' + rec."BankRefNo." + ' for Invoice : ' + BankRefCollecLine."Invoice No";
                            GenJournalRec.Validate("Account Type", GenJournalRec."Account Type"::Customer);

                            SalesInvHeaderRec.Reset();
                            SalesInvHeaderRec.SetRange("No.", BankRefCollecLine."Invoice No");

                            if SalesInvHeaderRec.Findset() then
                                GenJournalRec.Validate("Account No.", SalesInvHeaderRec."Sell-to Customer No.");

                            GenJournalRec.Validate("Bal. Account Type", GenJournalRec."Bal. Account Type"::"Bank Account");
                            GenJournalRec.Validate("Bal. Account No.", rec."Cash Receipt Bank No");
                            GenJournalRec.Validate(Amount, BankRefCollecLine."Release Amount" * -1);
                            GenJournalRec."Expiration Date" := WorkDate();
                            GenJournalRec."Source Code" := 'CASHRECJNL';
                            GenJournalRec.Insert();

                            //Update relase amount in custledger entry
                            CustledgerEntryrec.Reset();
                            CustledgerEntryrec.SetRange("Document Type", CustledgerEntryrec."Document Type"::Invoice);
                            CustledgerEntryrec.SetRange("Document No.", BankRefCollecLine."Invoice No");
                            CustledgerEntryrec.SetRange("Customer No.", SalesInvHeaderRec."Sell-to Customer No.");

                            if CustledgerEntryrec.Findset() then begin
                                CustledgerEntryrec.Validate("Amount to Apply", BankRefCollecLine."Release Amount");
                                CustledgerEntryrec.Validate("Applies-to ID", BankRefCollecLine."Invoice No");
                                CustledgerEntryrec.Modify();
                            end;

                            rec."Cash Rece. Updated" := true;
                            BankRefCollecLine."Transferred To Cash Receipt" := true;
                            BankRefCollecLine.Modify();

                        until BankRefCollecLine.Next() = 0;

                    CurrPage.Update();
                    Message('Completed');
                    //CashRcptJrnl.Run();

                end;
            }

            action("Transfer to general journal")
            {
                ApplicationArea = all;
                Image = GeneralLedger;

                trigger OnAction()
                var
                    GenJrnl: Page "General Journal";
                    GenJournalRec: Record "Gen. Journal Line";
                    BankRefDistributionRec: Record BankRefDistribution;
                    CustledgerEntryrec: Record "Cust. Ledger Entry";
                    LineNo: BigInteger;
                begin

                    if rec."Journal Batch" = '' then
                        Error('Genral Journal Batch is blank. Please check the BU code of Contract : %1', rec."LC/Contract No.");

                    //Get max line no
                    GenJournalRec.Reset();
                    GenJournalRec.SetRange("Journal Template Name", rec."Bank Ref. Template Name1");
                    GenJournalRec.SetRange("Journal Batch Name", rec."Journal Batch");

                    if GenJournalRec.FindLast() then
                        LineNo := GenJournalRec."Line No.";

                    BankRefDistributionRec.Reset();
                    BankRefDistributionRec.SetRange("BankRefNo.", rec."BankRefNo.");
                    BankRefDistributionRec.SetFilter("Transferred To Gen. Jrnl.", '=%1', false);

                    if BankRefDistributionRec.Findset() then
                        repeat

                            LineNo += 100;
                            GenJournalRec.Init();
                            GenJournalRec."Journal Template Name" := rec."Bank Ref. Template Name1";
                            GenJournalRec."Journal Batch Name" := rec."Journal Batch";
                            GenJournalRec."Line No." := LineNo;
                            GenJournalRec."BankRefNo" := BankRefDistributionRec."BankRefNo.";
                            GenJournalRec.Validate("Document No.", BankRefDistributionRec."BankRefNo.");
                            GenJournalRec."Document Date" := WorkDate();
                            GenJournalRec."Posting Date" := BankRefDistributionRec."Posting Date";
                            GenJournalRec.Description := 'Bank Ref : ' + rec."BankRefNo.";
                            GenJournalRec.Validate("Account Type", GenJournalRec."Account Type"::"Bank Account");
                            GenJournalRec.Validate("Account No.", BankRefDistributionRec."Debit Bank Account No");
                            GenJournalRec.Validate("Bal. Account Type", GenJournalRec."Bal. Account Type"::"Bank Account");
                            GenJournalRec.Validate("Bal. Account No.", BankRefDistributionRec."Credit Bank Account No");
                            GenJournalRec.Validate(Amount, BankRefDistributionRec."Credit Amount" * -1);
                            GenJournalRec."Expiration Date" := WorkDate() + 20;
                            GenJournalRec.Insert();

                            //rec."Cash Rece. Updated" := true;
                            BankRefDistributionRec."Transferred To Gen. Jrnl." := true;
                            BankRefDistributionRec.Modify();

                        until BankRefDistributionRec.Next() = 0;

                    CurrPage.Update();
                    Message('Completed');
                    //GenJrnl.Run();

                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        BankRefeCollRec: Record BankRefCollectionLine;

    begin
        if rec."Cash Rece. Updated" then
            Error('Cash Receipt Journal updated for this Bank Ref. Cannot delete.');

        BankRefeCollRec.Reset();
        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
        if BankRefeCollRec.FindSet() then
            BankRefeCollRec.Delete();

    end;


    procedure get_InvoiceTotal(): Decimal
    var
        BankRefeCollRec: Record BankRefCollectionLine;
        InvoiceTotal: Decimal;
    begin
        BankRefeCollRec.Reset();
        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
        if BankRefeCollRec.FindSet() then
            repeat
                InvoiceTotal += BankRefeCollRec."Invoice Amount";
            until BankRefeCollRec.Next() = 0;
        exit(InvoiceTotal);
    end;

    var
        "Total Distribution": Decimal;

}