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
                    begin

                        BankRefCollLineRec.Reset();
                        BankRefCollLineRec.SetRange("BankRefNo.", rec."BankRefNo.");

                        if not BankRefCollLineRec.FindSet() then begin

                            BankRefHeaderRec.Reset();
                            BankRefHeaderRec.SetRange("BankRefNo.", rec."BankRefNo.");
                            BankRefHeaderRec.FindSet();

                            BankRefInvRec.Reset();
                            BankRefInvRec.SetRange(BankRefNo, rec."BankRefNo.");
                            if BankRefInvRec.FindSet() then
                                repeat
                                    LineNo += 1;
                                    BankRefCollLineRec.Init();
                                    BankRefCollLineRec."BankRefNo." := rec."BankRefNo.";
                                    BankRefCollLineRec."Airway Bill Date" := BankRefHeaderRec."Airway Bill Date";
                                    BankRefCollLineRec.AirwayBillNo := BankRefHeaderRec.AirwayBillNo;
                                    BankRefCollLineRec."Created User" := UserId;
                                    BankRefCollLineRec."Created Date" := WorkDate();
                                    BankRefCollLineRec."Invoice Amount" := BankRefInvRec."Ship Value";
                                    BankRefCollLineRec."Invoice Date" := BankRefInvRec."Invoice Date";
                                    BankRefCollLineRec."Invoice No" := BankRefInvRec."Invoice No";
                                    BankRefCollLineRec."LineNo." := LineNo;
                                    BankRefCollLineRec."Maturity Date" := BankRefHeaderRec."Maturity Date";
                                    BankRefCollLineRec."Reference Date" := BankRefHeaderRec."Reference Date";
                                    BankRefCollLineRec.Insert();
                                until BankRefInvRec.Next() = 0;
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

                field("Release Amount"; rec."Release Amount")
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
                }

                field("Cash Receipt Bank Account No"; rec."Cash Receipt Bank Account No")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Receipt Bank Account';

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
                    NavAppSetuprec: Record "NavApp Setup";
                    LineNo: BigInteger;
                begin
                    NavAppSetuprec.Reset();
                    NavAppSetuprec.FindSet();

                    //Get max line no
                    GenJournalRec.Reset();
                    GenJournalRec.SetRange("Journal Template Name", NavAppSetuprec."Bank Ref. Template Name");
                    GenJournalRec.SetRange("Journal Batch Name", rec."Journal Batch");

                    if GenJournalRec.FindLast() then
                        LineNo := GenJournalRec."Line No.";

                    BankRefCollecLine.Reset();
                    BankRefCollecLine.SetRange("BankRefNo.", rec."BankRefNo.");
                    //BankRefCollecLine.SetFilter("Transferred To Cash Receipt", '=%1', false);

                    if BankRefCollecLine.Findset() then
                        repeat

                            LineNo += 100;
                            GenJournalRec.Init();
                            GenJournalRec."Journal Template Name" := NavAppSetuprec."Bank Ref. Template Name";
                            GenJournalRec."Journal Batch Name" := rec."Journal Batch";
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
                                CustledgerEntryrec.Modify();
                            end;

                            rec."Cash Rece. Updated" := true;
                            BankRefCollecLine."Transferred To Cash Receipt" := true;
                            BankRefCollecLine.Modify();

                        until BankRefCollecLine.Next() = 0;

                    CurrPage.Update();
                    CashRcptJrnl.Run();

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
                    NavAppSetuprec: Record "NavApp Setup";
                    LineNo: BigInteger;
                begin
                    NavAppSetuprec.Reset();
                    NavAppSetuprec.FindSet();

                    //Get max line no
                    GenJournalRec.Reset();
                    GenJournalRec.SetRange("Journal Template Name", NavAppSetuprec."Bank Ref. Template Name1");
                    GenJournalRec.SetRange("Journal Batch Name", rec."Journal Batch");

                    if GenJournalRec.FindLast() then
                        LineNo := GenJournalRec."Line No.";

                    BankRefDistributionRec.Reset();
                    BankRefDistributionRec.SetRange("BankRefNo.", rec."BankRefNo.");
                    //BankRefDistributionRec.SetFilter("Transferred To Gen. Jrnl.", '=%1', false);

                    if BankRefDistributionRec.Findset() then
                        repeat

                            LineNo += 100;
                            GenJournalRec.Init();
                            GenJournalRec."Journal Template Name" := NavAppSetuprec."Bank Ref. Template Name1";
                            GenJournalRec."Journal Batch Name" := rec."Journal Batch";
                            GenJournalRec."Line No." := LineNo;
                            GenJournalRec."BankRefNo" := BankRefDistributionRec."BankRefNo.";
                            GenJournalRec.Validate("Document Type", GenJournalRec."Document Type"::Payment);
                            GenJournalRec.Validate("Document No.", BankRefDistributionRec."BankRefNo.");
                            GenJournalRec."Document Date" := WorkDate();
                            GenJournalRec."Posting Date" := WorkDate();
                            GenJournalRec.Description := 'Bank Ref : ' + rec."BankRefNo.";
                            GenJournalRec.Validate("Account Type", GenJournalRec."Account Type"::"Bank Account");
                            GenJournalRec.Validate("Account No.", BankRefDistributionRec."Debit Bank Account No");
                            GenJournalRec.Validate("Bal. Account Type", GenJournalRec."Bal. Account Type"::"Bank Account");
                            GenJournalRec.Validate("Bal. Account No.", BankRefDistributionRec."Credit Bank Account No");
                            GenJournalRec.Validate(Amount, BankRefDistributionRec."Credit Amount" * -1);
                            GenJournalRec."Expiration Date" := WorkDate();
                            GenJournalRec."Source Code" := 'ge';
                            GenJournalRec.Insert();

                            // //Update relase amount in custledger entry
                            // CustledgerEntryrec.Reset();
                            // CustledgerEntryrec.SetRange("Document Type", CustledgerEntryrec."Document Type"::Invoice);
                            // CustledgerEntryrec.SetRange("Document No.", BankRefDistributionRec."Invoice No");
                            // CustledgerEntryrec.SetRange("Customer No.", SalesInvHeaderRec."Sell-to Customer No.");

                            // if CustledgerEntryrec.Findset() then begin
                            //     CustledgerEntryrec.Validate("Amount to Apply", BankRefDistributionRec."Release Amount");
                            //     CustledgerEntryrec.Modify();
                            // end;

                            //rec."Cash Rece. Updated" := true;
                            BankRefDistributionRec."Transferred To Gen. Jrnl." := true;
                            BankRefDistributionRec.Modify();

                        until BankRefDistributionRec.Next() = 0;

                    CurrPage.Update();
                    GenJrnl.Run();

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


}