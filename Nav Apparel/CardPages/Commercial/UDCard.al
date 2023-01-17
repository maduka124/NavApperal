page 51207 "UD Card"
{
    PageType = Card;
    SourceTable = UDHeader;
    Caption = 'Utilization Declaration (UD)';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'UD No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BuyerRec: Record Customer;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        BuyerRec.Reset();
                        BuyerRec.SetRange(Name, rec."Buyer");
                        if BuyerRec.FindSet() then
                            rec."Buyer No." := BuyerRec."No.";

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
                    end;
                }

                field("LC/Contract No."; rec."LC/Contract No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ContLCMasRec: Record "Contract/LCMaster";
                        B2BRec: Record B2BLCMaster;
                        "B2B LC Opened (Value)": Decimal;
                        "Contract/LCStyleRec": Record "Contract/LCStyle";
                        TotalQty: BigInteger;
                    begin
                        ContLCMasRec.Reset();
                        ContLCMasRec.SetRange("Contract No", rec."LC/Contract No.");
                        if ContLCMasRec.FindSet() then begin
                            rec."Value" := ContLCMasRec."Contract Value";
                            rec.Factory := ContLCMasRec.Factory;
                            rec."Factory No." := ContLCMasRec."Factory No.";
                        end;

                        //Calculate B2B LC opened  and %
                        B2BRec.Reset();
                        B2BRec.SetRange("LC/Contract No.", rec."LC/Contract No.");

                        if B2BRec.FindSet() then begin
                            repeat
                                "B2B LC Opened (Value)" += B2BRec."B2B LC Value";
                            until B2BRec.Next() = 0;

                            if rec."Value" > 0 then
                                rec."B2BLC%" := ("B2B LC Opened (Value)" / rec."Value") * 100;
                        end;

                        //Get total order qty
                        "Contract/LCStyleRec".Reset();
                        "Contract/LCStyleRec".SetRange("No.", ContLCMasRec."No.");

                        if "Contract/LCStyleRec".FindSet() then begin
                            repeat
                                TotalQty += "Contract/LCStyleRec".Qty;
                            until "Contract/LCStyleRec".Next() = 0;
                        end;

                        rec.Qantity := TotalQty;

                    end;

                }

                field(Factory; rec.Factory)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Qantity; rec.Qantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Value; rec.Value)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("B2BLC%"; rec."B2BLC%")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            // group("Style PO Information")
            // {
            //     part("Style PO Infor ListPart"; "Style PO Infor ListPart")
            //     {
            //         ApplicationArea = All;
            //         Caption = ' ';
            //         SubPageLink = "No." = FIELD("No.");
            //     }
            // }

            // group("BBL LC Information")
            // {
            //     part("BBL LC Infor ListPart"; "BBL LC Infor ListPart")
            //     {
            //         ApplicationArea = All;
            //         Caption = ' ';
            //         SubPageLink = "No." = FIELD("No.");
            //     }
            // }

            // group("PI Information")
            // {
            //     part("PI Infor ListPart"; "PI Infor ListPart")
            //     {
            //         ApplicationArea = All;
            //         Caption = ' ';
            //         SubPageLink = "No." = FIELD("No.");
            //     }
            // }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action("Transfer to cash receipt journal")
    //         {
    //             ApplicationArea = all;
    //             Image = CashReceiptJournal;

    //             trigger OnAction()
    //             var
    //                 CashRcptJrnl: Page "Cash Receipt Journal";
    //                 GenJournalRec: Record "Gen. Journal Line";
    //                 BankRefCollecLine: Record BankRefCollectionLine;
    //                 SalesInvHeaderRec: Record "Sales Invoice Header";
    //                 CustledgerEntryrec: Record "Cust. Ledger Entry";
    //                 NavAppSetuprec: Record "NavApp Setup";
    //                 LineNo: BigInteger;
    //             begin
    //                 NavAppSetuprec.Reset();
    //                 NavAppSetuprec.FindSet();

    //                 //Get max line no
    //                 GenJournalRec.Reset();
    //                 GenJournalRec.SetRange("Journal Template Name", NavAppSetuprec."Bank Ref. Template Name");
    //                 GenJournalRec.SetRange("Journal Batch Name", NavAppSetuprec."Cash Rec. Batch Name");

    //                 if GenJournalRec.FindLast() then
    //                     LineNo := GenJournalRec."Line No.";

    //                 BankRefCollecLine.Reset();
    //                 BankRefCollecLine.SetRange("BankRefNo.", rec."BankRefNo.");
    //                 BankRefCollecLine.SetFilter("Transferred To Cash Receipt", '=%1', false);

    //                 if BankRefCollecLine.Findset() then
    //                     repeat

    //                         LineNo += 100;
    //                         GenJournalRec.Init();
    //                         GenJournalRec."Journal Template Name" := NavAppSetuprec."Bank Ref. Template Name";
    //                         GenJournalRec."Journal Batch Name" := NavAppSetuprec."Cash Rec. Batch Name";
    //                         GenJournalRec."Line No." := LineNo;
    //                         GenJournalRec."Invoice No" := BankRefCollecLine."Invoice No";
    //                         GenJournalRec."BankRefNo" := BankRefCollecLine."BankRefNo.";
    //                         GenJournalRec.Validate("Document Type", GenJournalRec."Document Type"::Payment);
    //                         GenJournalRec.Validate("Document No.", BankRefCollecLine."Invoice No");
    //                         GenJournalRec."Document Date" := BankRefCollecLine."Invoice Date";
    //                         GenJournalRec."Posting Date" := WorkDate();
    //                         GenJournalRec.Description := 'Bank Ref : ' + rec."BankRefNo." + ' for Invoice : ' + BankRefCollecLine."Invoice No";
    //                         GenJournalRec.Validate("Account Type", GenJournalRec."Account Type"::Customer);

    //                         SalesInvHeaderRec.Reset();
    //                         SalesInvHeaderRec.SetRange("No.", BankRefCollecLine."Invoice No");

    //                         if SalesInvHeaderRec.Findset() then
    //                             GenJournalRec.Validate("Account No.", SalesInvHeaderRec."Sell-to Customer No.");

    //                         GenJournalRec.Validate("Bal. Account Type", GenJournalRec."Bal. Account Type"::"Bank Account");
    //                         GenJournalRec.Validate("Bal. Account No.", rec."Cash Receipt Bank No");
    //                         GenJournalRec.Validate(Amount, BankRefCollecLine."Release Amount" * -1);
    //                         GenJournalRec."Expiration Date" := WorkDate();
    //                         GenJournalRec."Source Code" := 'CASHRECJNL';
    //                         GenJournalRec.Insert();

    //                         //Update relase amount in custledger entry
    //                         CustledgerEntryrec.Reset();
    //                         CustledgerEntryrec.SetRange("Document Type", CustledgerEntryrec."Document Type"::Invoice);
    //                         CustledgerEntryrec.SetRange("Document No.", BankRefCollecLine."Invoice No");
    //                         CustledgerEntryrec.SetRange("Customer No.", SalesInvHeaderRec."Sell-to Customer No.");

    //                         if CustledgerEntryrec.Findset() then begin
    //                             CustledgerEntryrec.Validate("Amount to Apply", BankRefCollecLine."Release Amount");
    //                             CustledgerEntryrec.Modify();
    //                         end;

    //                         rec."Cash Rece. Updated" := true;
    //                         BankRefCollecLine."Transferred To Cash Receipt" := true;
    //                         BankRefCollecLine.Modify();

    //                     until BankRefCollecLine.Next() = 0;

    //                 CurrPage.Update();
    //                 Message('Completed');
    //                 //CashRcptJrnl.Run();

    //             end;
    //         }

    //         action("Transfer to general journal")
    //         {
    //             ApplicationArea = all;
    //             Image = GeneralLedger;

    //             trigger OnAction()
    //             var
    //                 GenJrnl: Page "General Journal";
    //                 GenJournalRec: Record "Gen. Journal Line";
    //                 BankRefDistributionRec: Record BankRefDistribution;
    //                 CustledgerEntryrec: Record "Cust. Ledger Entry";
    //                 NavAppSetuprec: Record "NavApp Setup";
    //                 LineNo: BigInteger;
    //             begin
    //                 NavAppSetuprec.Reset();
    //                 NavAppSetuprec.FindSet();

    //                 //Get max line no
    //                 GenJournalRec.Reset();
    //                 GenJournalRec.SetRange("Journal Template Name", NavAppSetuprec."Bank Ref. Template Name1");
    //                 GenJournalRec.SetRange("Journal Batch Name", NavAppSetuprec."Gen. Jrnl. Batch Name");

    //                 if GenJournalRec.FindLast() then
    //                     LineNo := GenJournalRec."Line No.";

    //                 BankRefDistributionRec.Reset();
    //                 BankRefDistributionRec.SetRange("BankRefNo.", rec."BankRefNo.");
    //                 BankRefDistributionRec.SetFilter("Transferred To Gen. Jrnl.", '=%1', false);

    //                 if BankRefDistributionRec.Findset() then
    //                     repeat

    //                         LineNo += 100;
    //                         GenJournalRec.Init();
    //                         GenJournalRec."Journal Template Name" := NavAppSetuprec."Bank Ref. Template Name1";
    //                         GenJournalRec."Journal Batch Name" := NavAppSetuprec."Gen. Jrnl. Batch Name";
    //                         GenJournalRec."Line No." := LineNo;
    //                         GenJournalRec."BankRefNo" := BankRefDistributionRec."BankRefNo.";
    //                         GenJournalRec.Validate("Document No.", BankRefDistributionRec."BankRefNo.");
    //                         GenJournalRec."Document Date" := WorkDate();
    //                         GenJournalRec."Posting Date" := BankRefDistributionRec."Posting Date";
    //                         GenJournalRec.Description := 'Bank Ref : ' + rec."BankRefNo.";
    //                         GenJournalRec.Validate("Account Type", GenJournalRec."Account Type"::"Bank Account");
    //                         GenJournalRec.Validate("Account No.", BankRefDistributionRec."Debit Bank Account No");
    //                         GenJournalRec.Validate("Bal. Account Type", GenJournalRec."Bal. Account Type"::"Bank Account");
    //                         GenJournalRec.Validate("Bal. Account No.", BankRefDistributionRec."Credit Bank Account No");
    //                         GenJournalRec.Validate(Amount, BankRefDistributionRec."Credit Amount" * -1);
    //                         GenJournalRec."Expiration Date" := WorkDate() + 20;
    //                         GenJournalRec.Insert();

    //                         //rec."Cash Rece. Updated" := true;
    //                         BankRefDistributionRec."Transferred To Gen. Jrnl." := true;
    //                         BankRefDistributionRec.Modify();

    //                     until BankRefDistributionRec.Next() = 0;

    //                 CurrPage.Update();
    //                 Message('Completed');
    //                 //GenJrnl.Run();

    //             end;
    //         }
    //     }
    // }

    // trigger OnDeleteRecord(): Boolean
    // var
    //     BankRefeCollRec: Record BankRefCollectionLine;
    // begin
    //     if rec."Cash Rece. Updated" then
    //         Error('Cash Receipt Journal updated for this Bank Ref. Cannot delete.');

    //     BankRefeCollRec.Reset();
    //     BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
    //     if BankRefeCollRec.FindSet() then
    //         BankRefeCollRec.Delete();
    // end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."UD Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


}