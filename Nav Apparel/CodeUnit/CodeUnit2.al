codeunit 50822 NavAppCodeUnit2
{
    procedure CalB2BLC_Perccentage(ContractNoPara: Code[20]): Decimal
    var
        "Contract/LCStyleRec": Record "Contract/LCStyle";
        StyelCostRec: Record "BOM Estimate Cost";
        StyleQty: BigInteger;
        StyleFOBPcs: Decimal;
        "SubTotalDz%": Decimal;
        Temp1: Decimal;
        Temp2: Decimal;
        FinalB2B: Decimal;
    begin

        //Get total order qty
        "Contract/LCStyleRec".Reset();
        "Contract/LCStyleRec".SetRange("No.", ContractNoPara);

        if "Contract/LCStyleRec".FindSet() then begin
            repeat
                StyleFOBPcs := 0;
                "SubTotalDz%" := 0;

                //Get Style Qty
                StyleQty := "Contract/LCStyleRec".Qty;

                //Get Style cost parameter
                StyelCostRec.Reset();
                StyelCostRec.SetRange("Style No.", "Contract/LCStyleRec"."Style No.");
                if StyelCostRec.FindSet() then begin
                    StyleFOBPcs := StyelCostRec."FOB Pcs";
                    "SubTotalDz%" := StyelCostRec."Sub Total (Dz.)%";
                end
                else
                    Error('Estimate Costing is not completed for the Style : %1', "Contract/LCStyleRec"."Style Name");

                Temp1 += (StyleQty * StyleFOBPcs * "SubTotalDz%") / 100;
                Temp2 += StyleQty * StyleFOBPcs;

            until "Contract/LCStyleRec".Next() = 0;

            if Temp2 <> 0 then
                FinalB2B := (Temp1 / Temp2) * 100
            else
                FinalB2B := 0;
        end;
        exit(FinalB2B);

    end;

    //

    procedure CalB2BLC_PerccentageMasterLC(ContractNoPara: Code[20]): Decimal
    var
        "Contract/LCStyleRec": Record "LC Style 2";
        StyelCostRec: Record "BOM Estimate Cost";
        StyleQty: BigInteger;
        StyleFOBPcs: Decimal;
        "SubTotalDz%": Decimal;
        Temp1: Decimal;
        Temp2: Decimal;
        FinalB2B: Decimal;
    begin

        //Get total order qty
        "Contract/LCStyleRec".Reset();
        "Contract/LCStyleRec".SetRange("LC No", ContractNoPara);

        if "Contract/LCStyleRec".FindSet() then begin
            repeat
                StyleFOBPcs := 0;
                "SubTotalDz%" := 0;

                //Get Style Qty
                StyleQty := "Contract/LCStyleRec".Qty;

                //Get Style cost parameter
                StyelCostRec.Reset();
                StyelCostRec.SetRange("Style No.", "Contract/LCStyleRec"."Style No.");
                if StyelCostRec.FindSet() then begin
                    StyleFOBPcs := StyelCostRec."FOB Pcs";
                    "SubTotalDz%" := StyelCostRec."Sub Total (Dz.)%";
                end
                else
                    Error('Estimate Costing is not completed for the Style : %1', "Contract/LCStyleRec"."Style Name");

                Temp1 += (StyleQty * StyleFOBPcs * "SubTotalDz%") / 100;
                Temp2 += StyleQty * StyleFOBPcs;

            until "Contract/LCStyleRec".Next() = 0;

            if Temp2 <> 0 then
                FinalB2B := (Temp1 / Temp2) * 100
            else
                FinalB2B := 0;
        end;
        exit(FinalB2B);

    end;

    //


    //SingleInstance = true;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnAfterSalesDeltaUpdateTotals', '', false, false)]
    local procedure DocumentTotals_OnAfterSalesDeltaUpdateTotals(var TotalSalesLine: Record "Sales Line"; var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line")
    begin
        TotalSalesLine."Quantity" += SalesLine."Quantity" - xSalesLine."Quantity";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document Totals", 'OnAfterCalculateSalesSubPageTotals', '', false, false)]
    local procedure DocumentTotals_OnAfterCalculateSalesSubPageTotals(var TotalSalesLine2: Record "Sales Line")
    begin
        TotalSalesLine2.CalcSums(Quantity);
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Prod. Order from Sale", 'OnCreateProdOrderOnBeforeProdOrderInsert', '', false, false)]
    local procedure OnCreateProdOrderOnBeforeProdOrderInsert(var ProductionOrder: Record "Production Order"; SalesLine: Record "Sales Line")
    var
        SalesOrderRec: Record "Sales Header";
    begin

        SalesOrderRec.get(SalesLine."Document Type", SalesLine."Document No.");
        ProductionOrder."Style Name" := SalesOrderRec."Style Name";
        ProductionOrder."Style No." := SalesOrderRec."Style No";
        ProductionOrder.PO := SalesOrderRec."PO No";
        ProductionOrder.validate(BuyerCode, SalesOrderRec."Sell-to Customer No.");
        ProductionOrder."Secondary UserID" := SalesOrderRec."Secondary UserID";
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure OnBeforePostGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        Y: Integer;
        M: Integer;
        SuppPayRec: Record SupplierPayments;
        NavAppSetupRec: Record "NavApp Setup";
        AcceptHeaderRec: Record AcceptanceHeader;
        BankRefCollecLine: Record BankRefCollectionLine;
        BankRefDistributionRec: Record BankRefDistribution;
        LoginSessionsRec: Record LoginSessions;
        TempValue1: Decimal;
        TempValue2: Decimal;
    begin
        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        if GenJournalLine."AccNo." <> '' then begin

            //Update status 
            AcceptHeaderRec.Reset();
            AcceptHeaderRec.SetRange("AccNo.", GenJournalLine."Document No.");
            if AcceptHeaderRec.FindSet() then begin
                AcceptHeaderRec.Paid := true;
                AcceptHeaderRec.PaidDate := WorkDate();
                AcceptHeaderRec.Modify();

                evaluate(Y, copystr(Format(WorkDate), 1, 2));
                Y := Y + 2000;
                evaluate(M, copystr(Format(WorkDate), 4, 2));

                SuppPayRec.Reset();
                SuppPayRec.SetRange("Suppler No.", GenJournalLine.SupplierNo);
                SuppPayRec.SetRange(Year, Y);

                if SuppPayRec.FindSet() then begin

                    case M of
                        1:
                            begin
                                Evaluate(TempValue1, SuppPayRec.January);
                                TempValue2 := TempValue1 + GenJournalLine."Amount";
                                SuppPayRec.January := format(TempValue2);
                            end;
                        2:
                            begin
                                Evaluate(TempValue1, SuppPayRec.February);
                                TempValue2 := TempValue1 + GenJournalLine."Amount";
                                SuppPayRec.January := format(TempValue2);
                            end;
                        3:
                            begin
                                Evaluate(TempValue1, SuppPayRec.March);
                                TempValue2 := TempValue1 + GenJournalLine."Amount";
                                SuppPayRec.January := format(TempValue2);
                            end;
                        4:
                            begin
                                Evaluate(TempValue1, SuppPayRec.April);
                                TempValue2 := TempValue1 + GenJournalLine."Amount";
                                SuppPayRec.January := format(TempValue2);
                            end;
                        5:
                            begin
                                Evaluate(TempValue1, SuppPayRec.May);
                                TempValue2 := TempValue1 + GenJournalLine."Amount";
                                SuppPayRec.January := format(TempValue2);
                            end;
                        6:
                            begin
                                Evaluate(TempValue1, SuppPayRec.June);
                                TempValue2 := TempValue1 + GenJournalLine."Amount";
                                SuppPayRec.January := format(TempValue2);
                            end;
                        7:
                            begin
                                Evaluate(TempValue1, SuppPayRec.July);
                                TempValue2 := TempValue1 + GenJournalLine."Amount";
                                SuppPayRec.January := format(TempValue2);
                            end;
                        8:
                            begin
                                Evaluate(TempValue1, SuppPayRec.August);
                                TempValue2 := TempValue1 + GenJournalLine."Amount";
                                SuppPayRec.January := format(TempValue2);
                            end;
                        9:
                            begin
                                Evaluate(TempValue1, SuppPayRec.September);
                                TempValue2 := TempValue1 + GenJournalLine."Amount";
                                SuppPayRec.January := format(TempValue2);
                            end;
                        10:
                            begin
                                Evaluate(TempValue1, SuppPayRec.October);
                                TempValue2 := TempValue1 + GenJournalLine."Amount";
                                SuppPayRec.January := format(TempValue2);
                            end;
                        11:
                            begin
                                Evaluate(TempValue1, SuppPayRec.November);
                                TempValue2 := TempValue1 + GenJournalLine."Amount";
                                SuppPayRec.January := format(TempValue2);
                            end;
                        12:
                            begin
                                Evaluate(TempValue1, SuppPayRec.December);
                                TempValue2 := TempValue1 + GenJournalLine."Amount";
                                SuppPayRec.January := format(TempValue2);
                            end;
                    end;

                    SuppPayRec.Modify();

                end
                else begin
                    SuppPayRec.Init();
                    SuppPayRec."Suppler No." := GenJournalLine.SupplierNo;
                    SuppPayRec."Suppler Name" := GenJournalLine.SupplierName;
                    SuppPayRec.Year := Y;

                    case M of
                        1:
                            begin
                                SuppPayRec.January := format(GenJournalLine."Amount");
                                SuppPayRec.February := '0';
                                SuppPayRec.March := '0';
                                SuppPayRec.April := '0';
                                SuppPayRec.May := '0';
                                SuppPayRec.June := '0';
                                SuppPayRec.July := '0';
                                SuppPayRec.August := '0';
                                SuppPayRec.September := '0';
                                SuppPayRec.October := '0';
                                SuppPayRec.November := '0';
                                SuppPayRec.December := '0';
                            end;
                        2:
                            begin
                                SuppPayRec.January := '0';
                                SuppPayRec.February := format(GenJournalLine."Amount");
                                SuppPayRec.March := '0';
                                SuppPayRec.April := '0';
                                SuppPayRec.May := '0';
                                SuppPayRec.June := '0';
                                SuppPayRec.July := '0';
                                SuppPayRec.August := '0';
                                SuppPayRec.September := '0';
                                SuppPayRec.October := '0';
                                SuppPayRec.November := '0';
                                SuppPayRec.December := '0';
                            end;
                        3:
                            begin
                                SuppPayRec.January := '0';
                                SuppPayRec.February := '0';
                                SuppPayRec.March := format(GenJournalLine."Amount");
                                SuppPayRec.April := '0';
                                SuppPayRec.May := '0';
                                SuppPayRec.June := '0';
                                SuppPayRec.July := '0';
                                SuppPayRec.August := '0';
                                SuppPayRec.September := '0';
                                SuppPayRec.October := '0';
                                SuppPayRec.November := '0';
                                SuppPayRec.December := '0';
                            end;
                        4:
                            begin
                                SuppPayRec.January := '0';
                                SuppPayRec.February := '0';
                                SuppPayRec.March := '0';
                                SuppPayRec.April := format(GenJournalLine."Amount");
                                SuppPayRec.May := '0';
                                SuppPayRec.June := '0';
                                SuppPayRec.July := '0';
                                SuppPayRec.August := '0';
                                SuppPayRec.September := '0';
                                SuppPayRec.October := '0';
                                SuppPayRec.November := '0';
                                SuppPayRec.December := '0';
                            end;
                        5:
                            begin
                                SuppPayRec.January := '0';
                                SuppPayRec.February := '0';
                                SuppPayRec.March := '0';
                                SuppPayRec.April := '0';
                                SuppPayRec.May := format(GenJournalLine."Amount");
                                SuppPayRec.June := '0';
                                SuppPayRec.July := '0';
                                SuppPayRec.August := '0';
                                SuppPayRec.September := '0';
                                SuppPayRec.October := '0';
                                SuppPayRec.November := '0';
                                SuppPayRec.December := '0';
                            end;
                        6:
                            begin
                                SuppPayRec.January := '0';
                                SuppPayRec.February := '0';
                                SuppPayRec.March := '0';
                                SuppPayRec.April := '0';
                                SuppPayRec.May := '0';
                                SuppPayRec.June := format(GenJournalLine."Amount");
                                SuppPayRec.July := '0';
                                SuppPayRec.August := '0';
                                SuppPayRec.September := '0';
                                SuppPayRec.October := '0';
                                SuppPayRec.November := '0';
                                SuppPayRec.December := '0';
                            end;
                        7:
                            begin
                                SuppPayRec.January := '0';
                                SuppPayRec.February := '0';
                                SuppPayRec.March := '0';
                                SuppPayRec.April := '0';
                                SuppPayRec.May := '0';
                                SuppPayRec.June := '0';
                                SuppPayRec.July := format(GenJournalLine."Amount");
                                SuppPayRec.August := '0';
                                SuppPayRec.September := '0';
                                SuppPayRec.October := '0';
                                SuppPayRec.November := '0';
                                SuppPayRec.December := '0';
                            end;
                        8:
                            begin
                                SuppPayRec.January := '0';
                                SuppPayRec.February := '0';
                                SuppPayRec.March := '0';
                                SuppPayRec.April := '0';
                                SuppPayRec.May := '0';
                                SuppPayRec.June := '0';
                                SuppPayRec.July := '0';
                                SuppPayRec.August := format(GenJournalLine."Amount");
                                SuppPayRec.September := '0';
                                SuppPayRec.October := '0';
                                SuppPayRec.November := '0';
                                SuppPayRec.December := '0';
                            end;
                        9:
                            begin
                                SuppPayRec.January := '0';
                                SuppPayRec.February := '0';
                                SuppPayRec.March := '0';
                                SuppPayRec.April := '0';
                                SuppPayRec.May := '0';
                                SuppPayRec.June := '0';
                                SuppPayRec.July := '0';
                                SuppPayRec.August := '0';
                                SuppPayRec.September := format(GenJournalLine."Amount");
                                SuppPayRec.October := '0';
                                SuppPayRec.November := '0';
                                SuppPayRec.December := '0';
                            end;
                        10:
                            begin
                                SuppPayRec.January := '0';
                                SuppPayRec.February := '0';
                                SuppPayRec.March := '0';
                                SuppPayRec.April := '0';
                                SuppPayRec.May := '0';
                                SuppPayRec.June := '0';
                                SuppPayRec.July := '0';
                                SuppPayRec.August := '0';
                                SuppPayRec.September := '0';
                                SuppPayRec.October := format(GenJournalLine."Amount");
                                SuppPayRec.November := '0';
                                SuppPayRec.December := '0';
                            end;
                        11:
                            begin
                                SuppPayRec.January := '0';
                                SuppPayRec.February := '0';
                                SuppPayRec.March := '0';
                                SuppPayRec.April := '0';
                                SuppPayRec.May := '0';
                                SuppPayRec.June := '0';
                                SuppPayRec.July := '0';
                                SuppPayRec.August := '0';
                                SuppPayRec.September := '0';
                                SuppPayRec.October := '0';
                                SuppPayRec.November := format(GenJournalLine."Amount");
                                SuppPayRec.December := '0';
                            end;
                        12:
                            begin
                                SuppPayRec.January := '0';
                                SuppPayRec.February := '0';
                                SuppPayRec.March := '0';
                                SuppPayRec.April := '0';
                                SuppPayRec.May := '0';
                                SuppPayRec.June := '0';
                                SuppPayRec.July := '0';
                                SuppPayRec.August := '0';
                                SuppPayRec.September := '0';
                                SuppPayRec.October := '0';
                                SuppPayRec.November := '0';
                                SuppPayRec.December := format(GenJournalLine."Amount");
                            end;
                    end;

                    //Check whether user logged in or not
                    LoginSessionsRec.Reset();
                    LoginSessionsRec.SetRange(SessionID, SessionId());
                    if LoginSessionsRec.FindSet() then
                        SuppPayRec."Secondary UserID" := LoginSessionsRec."Secondary UserID";

                    SuppPayRec.Insert();
                end;
            end;

        end;

        //Cash receipt
        if (GenJournalLine."Invoice No" <> '') and (GenJournalLine.BankRefNo <> '') then begin

            BankRefCollecLine.Reset();
            BankRefCollecLine.SetRange("Invoice No", GenJournalLine."Invoice No");
            BankRefCollecLine.SetRange("BankRefNo.", GenJournalLine.BankRefNo);

            if BankRefCollecLine.Findset() then begin
                BankRefCollecLine."Payment Posted" := true;
                BankRefCollecLine.Modify();
            end;

        end;

        //Collection distribution
        if (GenJournalLine."Invoice No" = '') and (GenJournalLine.BankRefNo <> '') then begin

            BankRefDistributionRec.Reset();
            BankRefDistributionRec.SetRange("BankRefNo.", GenJournalLine.BankRefNo);
            //BankRefDistributionRec.SetRange("Debit Bank Account No", GenJournalLine."Account No.");

            if BankRefDistributionRec.Findset() then begin
                BankRefDistributionRec."Payment Posted" := true;
                BankRefDistributionRec.Modify();
            end;

        end;

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostVendOnAfterInitVendLedgEntry', '', false, false)]
    local procedure OnPostVendOnAfterInitVendLedgEntry(var GenJnlLine: Record "Gen. Journal Line"; var VendLedgEntry: Record "Vendor Ledger Entry")
    var
    begin
        VendLedgEntry."LC/Contract No." := GenJnlLine."LC/Contract No.";
        VendLedgEntry."B2BLC No" := GenJnlLine."B2BLC No";
        VendLedgEntry."AccNo." := GenJnlLine."Document No.";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', false, false)]
    local procedure OnAfterInitBankAccLedgEntry(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
    begin
        BankAccountLedgerEntry."LC/Contract No." := GenJournalLine."LC/Contract No.";
        BankAccountLedgerEntry."B2BLC No" := GenJournalLine."B2BLC No";
        BankAccountLedgerEntry."AccNo." := GenJournalLine."Document No.";
        BankAccountLedgerEntry."BankRefNo" := GenJournalLine.BankRefNo;
        BankAccountLedgerEntry."Invoice No" := GenJournalLine."Invoice No";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostCustOnAfterInitCustLedgEntry', '', false, false)]
    local procedure OnPostCustOnAfterInitCustLedgEntry(var GenJournalLine: Record "Gen. Journal Line"; var CustLedgEntry: Record "Cust. Ledger Entry"; Cust: Record Customer; CustPostingGr: Record "Customer Posting Group")
    var
    begin
        CustLedgEntry."BankRefNo" := GenJournalLine."BankRefNo";
        CustLedgEntry."Invoice No" := GenJournalLine."Invoice No";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Reverse", 'OnReverseVendLedgEntryOnAfterInsertVendLedgEntry', '', false, false)]
    local procedure OnReverseVendLedgEntryOnAfterInsertVendLedgEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry")
    var
        AcceptHeaderRec: Record AcceptanceHeader;
        SuppPayRec: Record SupplierPayments;
        Y: Integer;
        M: Integer;
        TempValue1: Decimal;
        TempValue2: Decimal;
    begin
        AcceptHeaderRec.Reset();
        AcceptHeaderRec.SetRange("AccNo.", VendorLedgerEntry."AccNo.");
        if AcceptHeaderRec.FindSet() then begin
            AcceptHeaderRec.Paid := false;
            AcceptHeaderRec.PaidDate := 0D;

            evaluate(Y, copystr(Format(Today), 1, 2));
            Y := Y + 2000;
            evaluate(M, copystr(Format(Today), 4, 2));

            SuppPayRec.Reset();
            SuppPayRec.SetRange("Suppler No.", AcceptHeaderRec."Suppler No.");
            SuppPayRec.SetRange(Year, Y);

            if SuppPayRec.FindSet() then begin

                case M of
                    1:
                        begin
                            Evaluate(TempValue1, SuppPayRec.January);
                            TempValue2 := TempValue1 - AcceptHeaderRec."Accept Value";
                            SuppPayRec.January := format(TempValue2);
                        end;
                    2:
                        begin
                            Evaluate(TempValue1, SuppPayRec.February);
                            TempValue2 := TempValue1 - AcceptHeaderRec."Accept Value";
                            SuppPayRec.January := format(TempValue2);
                        end;
                    3:
                        begin
                            Evaluate(TempValue1, SuppPayRec.March);
                            TempValue2 := TempValue1 - AcceptHeaderRec."Accept Value";
                            SuppPayRec.January := format(TempValue2);
                        end;
                    4:
                        begin
                            Evaluate(TempValue1, SuppPayRec.April);
                            TempValue2 := TempValue1 - AcceptHeaderRec."Accept Value";
                            SuppPayRec.January := format(TempValue2);
                        end;
                    5:
                        begin
                            Evaluate(TempValue1, SuppPayRec.May);
                            TempValue2 := TempValue1 - AcceptHeaderRec."Accept Value";
                            SuppPayRec.January := format(TempValue2);
                        end;
                    6:
                        begin
                            Evaluate(TempValue1, SuppPayRec.June);
                            TempValue2 := TempValue1 - AcceptHeaderRec."Accept Value";
                            SuppPayRec.January := format(TempValue2);
                        end;
                    7:
                        begin
                            Evaluate(TempValue1, SuppPayRec.July);
                            TempValue2 := TempValue1 - AcceptHeaderRec."Accept Value";
                            SuppPayRec.January := format(TempValue2);
                        end;
                    8:
                        begin
                            Evaluate(TempValue1, SuppPayRec.August);
                            TempValue2 := TempValue1 - AcceptHeaderRec."Accept Value";
                            SuppPayRec.January := format(TempValue2);
                        end;
                    9:
                        begin
                            Evaluate(TempValue1, SuppPayRec.September);
                            TempValue2 := TempValue1 - AcceptHeaderRec."Accept Value";
                            SuppPayRec.January := format(TempValue2);
                        end;
                    10:
                        begin
                            Evaluate(TempValue1, SuppPayRec.October);
                            TempValue2 := TempValue1 - AcceptHeaderRec."Accept Value";
                            SuppPayRec.January := format(TempValue2);
                        end;
                    11:
                        begin
                            Evaluate(TempValue1, SuppPayRec.November);
                            TempValue2 := TempValue1 - AcceptHeaderRec."Accept Value";
                            SuppPayRec.January := format(TempValue2);
                        end;
                    12:
                        begin
                            Evaluate(TempValue1, SuppPayRec.December);
                            TempValue2 := TempValue1 - AcceptHeaderRec."Accept Value";
                            SuppPayRec.January := format(TempValue2);
                        end;
                end;

                SuppPayRec.Modify();

            end;

            AcceptHeaderRec.Modify();
        end;
    end;


    procedure CapacityByPcsReports(YearPara: Integer; Count: Integer)
    var
        BuyWisOdrBookAllBookRec: Record BuyerWiseOdrBookingAllBook;
        BuyWisOdrBookAllBook1Rec: Record BuyerWiseOdrBookingAllBook;
        BuyerWiseOdrBookinBalatoSewRec: Record BuyerWiseOrderBookinBalatoSew;
        BuyerWiseOdrBookinBalatoSewTotRec: Record BuyerWiseOrderBookinBalatoSew;
        BuyerWiseOdrBookinBalatoShipRec: Record BuyerWiseOrderBookinBalatoShip;
        BuyerWiseOdrBookinBalatoShipTotRec: Record BuyerWiseOrderBookinBalatoShip;
        BuyerWiseOdrBookinGRWiseBookRec: Record BuyerWiseOrderBookinGRWiseBook;
        PostSalesInvHeaderRec: Record "Sales Invoice Header";
        PostSalesInvLineRec: Record "Sales Invoice Line";
        ProductionOutHeaderRec: Record ProductionOutHeader;
        MerchanGroupTableRec: Record MerchandizingGroupTable;
        StyleMasterRec: Record "Style Master";
        StyleMasterPORec: Record "Style Master PO";
        CustomerRec: Record Customer;
        codeunit1: Codeunit "CodeUnitJobQueue-AllBooking";
        i: Integer;
        StartDate: date;
        FinishDate: Date;
        SeqNo: BigInteger;
        StyleNo: Code[20];
        //StyleNo1: Code[20];
        xxx: Integer;
        Tot: BigInteger;
    begin
        if YearPara > 0 then begin

            /////////////////////////////All booking
            //Delete old data
            BuyWisOdrBookAllBookRec.Reset();
            BuyWisOdrBookAllBookRec.SetRange(Year, YearPara);
            if BuyWisOdrBookAllBookRec.FindSet() then
                BuyWisOdrBookAllBookRec.DeleteAll();

            //Get max record
            BuyWisOdrBookAllBookRec.Reset();
            if BuyWisOdrBookAllBookRec.Findlast() then
                SeqNo := BuyWisOdrBookAllBookRec."No.";

            SeqNo += 1;

            //Insert Grand total line
            BuyWisOdrBookAllBookRec.Init();
            BuyWisOdrBookAllBookRec."No." := SeqNo;
            BuyWisOdrBookAllBookRec.Year := YearPara;
            BuyWisOdrBookAllBookRec."Buyer Code" := ' ';
            BuyWisOdrBookAllBookRec."Buyer Name" := 'Total';
            BuyWisOdrBookAllBookRec.Type := 'T';
            BuyWisOdrBookAllBookRec."Created User" := UserId;
            BuyWisOdrBookAllBookRec."Created Date" := WorkDate();
            BuyWisOdrBookAllBookRec.Insert();

            for i := 1 to 12 do begin

                StartDate := DMY2DATE(1, i, YearPara);

                case i of
                    1:
                        FinishDate := DMY2DATE(31, i, YearPara);
                    2:
                        begin
                            if YearPara mod 4 = 0 then
                                FinishDate := DMY2DATE(29, i, YearPara)
                            else
                                FinishDate := DMY2DATE(28, i, YearPara);
                        end;
                    3:
                        FinishDate := DMY2DATE(31, i, YearPara);
                    4:
                        FinishDate := DMY2DATE(30, i, YearPara);
                    5:
                        FinishDate := DMY2DATE(31, i, YearPara);
                    6:
                        FinishDate := DMY2DATE(30, i, YearPara);
                    7:
                        FinishDate := DMY2DATE(31, i, YearPara);
                    8:
                        FinishDate := DMY2DATE(31, i, YearPara);
                    9:
                        FinishDate := DMY2DATE(30, i, YearPara);
                    10:
                        FinishDate := DMY2DATE(31, i, YearPara);
                    11:
                        FinishDate := DMY2DATE(30, i, YearPara);
                    12:
                        FinishDate := DMY2DATE(31, i, YearPara);
                end;


                //Get styles within the period
                StyleMasterPORec.Reset();
                StyleMasterPORec.SetCurrentKey("Style No.");
                StyleMasterPORec.Ascending(true);
                StyleMasterPORec.SetRange("Ship Date", StartDate, FinishDate);
                if StyleMasterPORec.FindSet() then begin

                    repeat

                        //Get buyer Name/Code
                        StyleMasterRec.Reset();
                        StyleMasterRec.SetRange("No.", StyleMasterPORec."Style No.");
                        StyleMasterRec.SetFilter("Buyer Name", '<>%1', '');
                        StyleMasterRec.SetFilter(Status, '=%1', StyleMasterRec.Status::Confirmed);
                        if StyleMasterRec.FindSet() then begin

                            // if StyleMasterRec."Buyer Name" = 'AMAZON' then
                            //     Message('AMAZON');

                            //Done By Sachith on 16/02/23 (insert brand filter line)
                            //Check for existing records            
                            BuyWisOdrBookAllBookRec.Reset();
                            BuyWisOdrBookAllBookRec.SetRange(Year, YearPara);
                            BuyWisOdrBookAllBookRec.SetRange("Buyer Code", StyleMasterRec."Buyer No.");
                            BuyWisOdrBookAllBookRec.SetRange("Brand Name", StyleMasterRec."Brand Name");
                            BuyWisOdrBookAllBookRec.SetFilter(Type, '<>%1', 'T');
                            if not BuyWisOdrBookAllBookRec.FindSet() then begin  //insert

                                SeqNo += 1;
                                //Insert new line
                                //Done By Sachith on 16/02/23 (insert Brand No and Name)
                                BuyWisOdrBookAllBookRec.Init();
                                BuyWisOdrBookAllBookRec."No." := SeqNo;
                                BuyWisOdrBookAllBookRec.Year := YearPara;
                                BuyWisOdrBookAllBookRec."Buyer Code" := StyleMasterRec."Buyer No.";
                                BuyWisOdrBookAllBookRec."Buyer Name" := StyleMasterRec."Buyer Name";
                                BuyWisOdrBookAllBookRec."Brand No" := StyleMasterRec."Brand No.";
                                BuyWisOdrBookAllBookRec."Brand Name" := StyleMasterRec."Brand Name";
                                BuyWisOdrBookAllBookRec.Type := 'L';

                                case i of
                                    1:
                                        BuyWisOdrBookAllBookRec.JAN := StyleMasterPORec.Qty;
                                    2:
                                        BuyWisOdrBookAllBookRec.FEB := StyleMasterPORec.Qty;
                                    3:
                                        BuyWisOdrBookAllBookRec.MAR := StyleMasterPORec.Qty;
                                    4:
                                        BuyWisOdrBookAllBookRec.APR := StyleMasterPORec.Qty;
                                    5:
                                        BuyWisOdrBookAllBookRec.MAY := StyleMasterPORec.Qty;
                                    6:
                                        BuyWisOdrBookAllBookRec.JUN := StyleMasterPORec.Qty;
                                    7:
                                        BuyWisOdrBookAllBookRec.JUL := StyleMasterPORec.Qty;
                                    8:
                                        BuyWisOdrBookAllBookRec.AUG := StyleMasterPORec.Qty;
                                    9:
                                        BuyWisOdrBookAllBookRec.SEP := StyleMasterPORec.Qty;
                                    10:
                                        BuyWisOdrBookAllBookRec.OCT := StyleMasterPORec.Qty;
                                    11:
                                        BuyWisOdrBookAllBookRec.NOV := StyleMasterPORec.Qty;
                                    12:
                                        BuyWisOdrBookAllBookRec.DEC := StyleMasterPORec.Qty;
                                end;

                                BuyWisOdrBookAllBookRec."Created User" := UserId;
                                BuyWisOdrBookAllBookRec."Created Date" := WorkDate();
                                BuyWisOdrBookAllBookRec.Total := StyleMasterPORec.Qty;
                                BuyWisOdrBookAllBookRec.Insert();

                            end
                            else begin  //Modify

                                case i of
                                    1:
                                        BuyWisOdrBookAllBookRec.JAN := BuyWisOdrBookAllBookRec.JAN + StyleMasterPORec.Qty;
                                    2:
                                        BuyWisOdrBookAllBookRec.FEB := BuyWisOdrBookAllBookRec.FEB + StyleMasterPORec.Qty;
                                    3:
                                        BuyWisOdrBookAllBookRec.MAR := BuyWisOdrBookAllBookRec.MAR + StyleMasterPORec.Qty;
                                    4:
                                        BuyWisOdrBookAllBookRec.APR := BuyWisOdrBookAllBookRec.APR + StyleMasterPORec.Qty;
                                    5:
                                        BuyWisOdrBookAllBookRec.MAY := BuyWisOdrBookAllBookRec.MAY + StyleMasterPORec.Qty;
                                    6:
                                        BuyWisOdrBookAllBookRec.JUN := BuyWisOdrBookAllBookRec.JUN + StyleMasterPORec.Qty;
                                    7:
                                        BuyWisOdrBookAllBookRec.JUL := BuyWisOdrBookAllBookRec.JUL + StyleMasterPORec.Qty;
                                    8:
                                        BuyWisOdrBookAllBookRec.AUG := BuyWisOdrBookAllBookRec.AUG + StyleMasterPORec.Qty;
                                    9:
                                        BuyWisOdrBookAllBookRec.SEP := BuyWisOdrBookAllBookRec.SEP + StyleMasterPORec.Qty;
                                    10:
                                        BuyWisOdrBookAllBookRec.OCT := BuyWisOdrBookAllBookRec.OCT + StyleMasterPORec.Qty;
                                    11:
                                        BuyWisOdrBookAllBookRec.NOV := BuyWisOdrBookAllBookRec.NOV + StyleMasterPORec.Qty;
                                    12:
                                        BuyWisOdrBookAllBookRec.DEC := BuyWisOdrBookAllBookRec.DEC + StyleMasterPORec.Qty;
                                end;

                                BuyWisOdrBookAllBookRec.Total := BuyWisOdrBookAllBookRec.Total + StyleMasterPORec.Qty;
                                BuyWisOdrBookAllBookRec.Modify();
                            end;

                            // //Update Grand total
                            // BuyWisOdrBookAllBookRec.Reset();
                            // BuyWisOdrBookAllBookRec.SetRange(Year,YearPara);
                            // BuyWisOdrBookAllBookRec.SetFilter(Type, '=%1', 'T');
                            // if BuyWisOdrBookAllBookRec.FindSet() then begin
                            //     case i of
                            //         1:
                            //             BuyWisOdrBookAllBookRec.JAN := BuyWisOdrBookAllBookRec.JAN + StyleMasterPORec.Qty;
                            //         2:
                            //             BuyWisOdrBookAllBookRec.FEB := BuyWisOdrBookAllBookRec.FEB + StyleMasterPORec.Qty;
                            //         3:
                            //             BuyWisOdrBookAllBookRec.MAR := BuyWisOdrBookAllBookRec.MAR + StyleMasterPORec.Qty;
                            //         4:
                            //             BuyWisOdrBookAllBookRec.APR := BuyWisOdrBookAllBookRec.APR + StyleMasterPORec.Qty;
                            //         5:
                            //             BuyWisOdrBookAllBookRec.MAY := BuyWisOdrBookAllBookRec.MAY + StyleMasterPORec.Qty;
                            //         6:
                            //             BuyWisOdrBookAllBookRec.JUN := BuyWisOdrBookAllBookRec.JUN + StyleMasterPORec.Qty;
                            //         7:
                            //             BuyWisOdrBookAllBookRec.JUL := BuyWisOdrBookAllBookRec.JUL + StyleMasterPORec.Qty;
                            //         8:
                            //             BuyWisOdrBookAllBookRec.AUG := BuyWisOdrBookAllBookRec.AUG + StyleMasterPORec.Qty;
                            //         9:
                            //             BuyWisOdrBookAllBookRec.SEP := BuyWisOdrBookAllBookRec.SEP + StyleMasterPORec.Qty;
                            //         10:
                            //             BuyWisOdrBookAllBookRec.OCT := BuyWisOdrBookAllBookRec.OCT + StyleMasterPORec.Qty;
                            //         11:
                            //             BuyWisOdrBookAllBookRec.NOV := BuyWisOdrBookAllBookRec.NOV + StyleMasterPORec.Qty;
                            //         12:
                            //             BuyWisOdrBookAllBookRec.DEC := BuyWisOdrBookAllBookRec.DEC + StyleMasterPORec.Qty;
                            //     end;
                            //     BuyWisOdrBookAllBookRec.Total := BuyWisOdrBookAllBookRec.Total + StyleMasterPORec.Qty;
                            //     BuyWisOdrBookAllBookRec.Modify();
                            // end;
                        end;

                    until StyleMasterPORec.Next() = 0;
                end;

                //Update Grand total
                BuyWisOdrBookAllBookRec.Reset();
                BuyWisOdrBookAllBookRec.SetRange(Year, YearPara);
                BuyWisOdrBookAllBookRec.SetFilter(Type, '=%1', 'T');
                BuyWisOdrBookAllBookRec.FindSet();

                case i of
                    1:
                        begin
                            BuyWisOdrBookAllBook1Rec.Reset();
                            BuyWisOdrBookAllBook1Rec.SetRange(Year, YearPara);
                            BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                            if BuyWisOdrBookAllBook1Rec.FindSet() then
                                repeat
                                    BuyWisOdrBookAllBookRec.JAN := BuyWisOdrBookAllBookRec.JAN + BuyWisOdrBookAllBook1Rec.JAN;
                                until BuyWisOdrBookAllBook1Rec.Next() = 0;
                        end;

                    2:
                        begin
                            BuyWisOdrBookAllBook1Rec.Reset();
                            BuyWisOdrBookAllBook1Rec.SetRange(Year, YearPara);
                            BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                            if BuyWisOdrBookAllBook1Rec.FindSet() then
                                repeat
                                    BuyWisOdrBookAllBookRec.FEB := BuyWisOdrBookAllBookRec.FEB + BuyWisOdrBookAllBook1Rec.FEB;
                                until BuyWisOdrBookAllBook1Rec.Next() = 0;
                        end;
                    3:
                        begin
                            BuyWisOdrBookAllBook1Rec.Reset();
                            BuyWisOdrBookAllBook1Rec.SetRange(Year, YearPara);
                            BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                            if BuyWisOdrBookAllBook1Rec.FindSet() then
                                repeat
                                    BuyWisOdrBookAllBookRec.MAR := BuyWisOdrBookAllBookRec.MAR + BuyWisOdrBookAllBook1Rec.MAR;
                                until BuyWisOdrBookAllBook1Rec.Next() = 0;
                        end;
                    4:
                        begin
                            BuyWisOdrBookAllBook1Rec.Reset();
                            BuyWisOdrBookAllBook1Rec.SetRange(Year, YearPara);
                            BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                            if BuyWisOdrBookAllBook1Rec.FindSet() then
                                repeat
                                    BuyWisOdrBookAllBookRec.APR := BuyWisOdrBookAllBookRec.APR + BuyWisOdrBookAllBook1Rec.APR;
                                until BuyWisOdrBookAllBook1Rec.Next() = 0;
                        end;
                    5:
                        begin
                            BuyWisOdrBookAllBook1Rec.Reset();
                            BuyWisOdrBookAllBook1Rec.SetRange(Year, YearPara);
                            BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                            if BuyWisOdrBookAllBook1Rec.FindSet() then
                                repeat
                                    BuyWisOdrBookAllBookRec.MAY := BuyWisOdrBookAllBookRec.MAY + BuyWisOdrBookAllBook1Rec.MAY;
                                until BuyWisOdrBookAllBook1Rec.Next() = 0;
                        end;
                    6:
                        begin
                            BuyWisOdrBookAllBook1Rec.Reset();
                            BuyWisOdrBookAllBook1Rec.SetRange(Year, YearPara);
                            BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                            if BuyWisOdrBookAllBook1Rec.FindSet() then
                                repeat
                                    BuyWisOdrBookAllBookRec.JUN := BuyWisOdrBookAllBookRec.JUN + BuyWisOdrBookAllBook1Rec.JUN;
                                until BuyWisOdrBookAllBook1Rec.Next() = 0;
                        end;
                    7:
                        begin
                            BuyWisOdrBookAllBook1Rec.Reset();
                            BuyWisOdrBookAllBook1Rec.SetRange(Year, YearPara);
                            BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                            if BuyWisOdrBookAllBook1Rec.FindSet() then
                                repeat
                                    BuyWisOdrBookAllBookRec.JUL := BuyWisOdrBookAllBookRec.JUL + BuyWisOdrBookAllBook1Rec.JUL;
                                until BuyWisOdrBookAllBook1Rec.Next() = 0;
                        end;
                    8:
                        begin
                            BuyWisOdrBookAllBook1Rec.Reset();
                            BuyWisOdrBookAllBook1Rec.SetRange(Year, YearPara);
                            BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                            if BuyWisOdrBookAllBook1Rec.FindSet() then
                                repeat
                                    BuyWisOdrBookAllBookRec.AUG := BuyWisOdrBookAllBookRec.AUG + BuyWisOdrBookAllBook1Rec.AUG;
                                until BuyWisOdrBookAllBook1Rec.Next() = 0;
                        end;
                    9:
                        begin
                            BuyWisOdrBookAllBook1Rec.Reset();
                            BuyWisOdrBookAllBook1Rec.SetRange(Year, YearPara);
                            BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                            if BuyWisOdrBookAllBook1Rec.FindSet() then
                                repeat
                                    BuyWisOdrBookAllBookRec.SEP := BuyWisOdrBookAllBookRec.SEP + BuyWisOdrBookAllBook1Rec.SEP;
                                until BuyWisOdrBookAllBook1Rec.Next() = 0;
                        end;
                    10:
                        begin
                            BuyWisOdrBookAllBook1Rec.Reset();
                            BuyWisOdrBookAllBook1Rec.SetRange(Year, YearPara);
                            BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                            if BuyWisOdrBookAllBook1Rec.FindSet() then
                                repeat
                                    BuyWisOdrBookAllBookRec.OCT := BuyWisOdrBookAllBookRec.OCT + BuyWisOdrBookAllBook1Rec.OCT;
                                until BuyWisOdrBookAllBook1Rec.Next() = 0;
                        end;
                    11:
                        begin
                            BuyWisOdrBookAllBook1Rec.Reset();
                            BuyWisOdrBookAllBook1Rec.SetRange(Year, YearPara);
                            BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                            if BuyWisOdrBookAllBook1Rec.FindSet() then
                                repeat
                                    BuyWisOdrBookAllBookRec.NOV := BuyWisOdrBookAllBookRec.NOV + BuyWisOdrBookAllBook1Rec.NOV;
                                until BuyWisOdrBookAllBook1Rec.Next() = 0;
                        end;
                    12:
                        begin
                            BuyWisOdrBookAllBook1Rec.Reset();
                            BuyWisOdrBookAllBook1Rec.SetRange(Year, YearPara);
                            BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                            if BuyWisOdrBookAllBook1Rec.FindSet() then
                                repeat
                                    BuyWisOdrBookAllBookRec.DEC := BuyWisOdrBookAllBookRec.DEC + BuyWisOdrBookAllBook1Rec.DEC;
                                until BuyWisOdrBookAllBook1Rec.Next() = 0;
                        end;
                end;

                BuyWisOdrBookAllBookRec.Modify();
            end;


            //Update Grand total of last column
            BuyWisOdrBookAllBookRec.Reset();
            BuyWisOdrBookAllBookRec.SetRange(Year, YearPara);
            BuyWisOdrBookAllBookRec.SetFilter(Type, '=%1', 'T');
            if BuyWisOdrBookAllBookRec.FindSet() then begin

                BuyWisOdrBookAllBook1Rec.Reset();
                BuyWisOdrBookAllBook1Rec.SetRange(Year, YearPara);
                BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                if BuyWisOdrBookAllBook1Rec.FindSet() then
                    repeat
                        BuyWisOdrBookAllBookRec.Total := BuyWisOdrBookAllBookRec.Total + BuyWisOdrBookAllBook1Rec.Total;
                    until BuyWisOdrBookAllBook1Rec.Next() = 0;

                BuyWisOdrBookAllBookRec.Modify();

            end;


            if Count >= 2 then begin
                /////////////////////////////////Balance to Sew
                //Delete old data
                BuyerWiseOdrBookinBalatoSewRec.Reset();
                BuyerWiseOdrBookinBalatoSewRec.SetRange(Year, YearPara);
                if BuyerWiseOdrBookinBalatoSewRec.FindSet() then
                    BuyerWiseOdrBookinBalatoSewRec.DeleteAll();

                //Get max record  
                SeqNo := 0;
                BuyerWiseOdrBookinBalatoSewRec.Reset();
                if BuyerWiseOdrBookinBalatoSewRec.Findlast() then
                    SeqNo := BuyerWiseOdrBookinBalatoSewRec."No.";

                //Insert all bookings
                BuyWisOdrBookAllBookRec.Reset();
                BuyWisOdrBookAllBookRec.SetCurrentKey("No.", "Buyer Name");
                BuyWisOdrBookAllBookRec.Ascending(false);
                BuyWisOdrBookAllBookRec.SetRange(Year, YearPara);
                BuyWisOdrBookAllBookRec.SetFilter(Type, '<>%1', 'T');
                if BuyWisOdrBookAllBookRec.FindSet() then begin
                    repeat
                        //
                        //Insert new line
                        //Done By Sachith on 16/02/23 (insert Brand No and Name)
                        SeqNo += 1;
                        BuyerWiseOdrBookinBalatoSewRec.Init();
                        BuyerWiseOdrBookinBalatoSewRec."No." := SeqNo;
                        BuyerWiseOdrBookinBalatoSewRec.Year := BuyWisOdrBookAllBookRec.Year;
                        BuyerWiseOdrBookinBalatoSewRec."Buyer Code" := BuyWisOdrBookAllBookRec."Buyer Code";
                        BuyerWiseOdrBookinBalatoSewRec."Buyer Name" := BuyWisOdrBookAllBookRec."Buyer Name";
                        BuyerWiseOdrBookinBalatoSewRec."Brand No" := BuyWisOdrBookAllBookRec."Brand No";
                        BuyerWiseOdrBookinBalatoSewRec."Brand Name" := BuyWisOdrBookAllBookRec."Brand Name";
                        BuyerWiseOdrBookinBalatoSewRec.JAN := BuyWisOdrBookAllBookRec.JAN;
                        BuyerWiseOdrBookinBalatoSewRec.FEB := BuyWisOdrBookAllBookRec.FEB;
                        BuyerWiseOdrBookinBalatoSewRec.MAR := BuyWisOdrBookAllBookRec.MAR;
                        BuyerWiseOdrBookinBalatoSewRec.APR := BuyWisOdrBookAllBookRec.APR;
                        BuyerWiseOdrBookinBalatoSewRec.MAY := BuyWisOdrBookAllBookRec.MAY;
                        BuyerWiseOdrBookinBalatoSewRec.JUN := BuyWisOdrBookAllBookRec.JUN;
                        BuyerWiseOdrBookinBalatoSewRec.JUL := BuyWisOdrBookAllBookRec.JUL;
                        BuyerWiseOdrBookinBalatoSewRec.AUG := BuyWisOdrBookAllBookRec.AUG;
                        BuyerWiseOdrBookinBalatoSewRec.SEP := BuyWisOdrBookAllBookRec.SEP;
                        BuyerWiseOdrBookinBalatoSewRec.OCT := BuyWisOdrBookAllBookRec.OCT;
                        BuyerWiseOdrBookinBalatoSewRec.NOV := BuyWisOdrBookAllBookRec.NOV;
                        BuyerWiseOdrBookinBalatoSewRec.DEC := BuyWisOdrBookAllBookRec.DEC;
                        BuyerWiseOdrBookinBalatoSewRec."Created User" := UserId;
                        BuyerWiseOdrBookinBalatoSewRec."Created Date" := WorkDate();
                        BuyerWiseOdrBookinBalatoSewRec.Total := BuyWisOdrBookAllBookRec.Total;
                        BuyerWiseOdrBookinBalatoSewRec.Type := BuyWisOdrBookAllBookRec.Type;
                        BuyerWiseOdrBookinBalatoSewRec.Insert();
                    until BuyWisOdrBookAllBookRec.Next() = 0;
                end;


                for i := 1 to 12 do begin
                    StartDate := DMY2DATE(1, i, YearPara);

                    case i of
                        1:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        2:
                            begin
                                if YearPara mod 4 = 0 then
                                    FinishDate := DMY2DATE(29, i, YearPara)
                                else
                                    FinishDate := DMY2DATE(28, i, YearPara);
                            end;
                        3:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        4:
                            FinishDate := DMY2DATE(30, i, YearPara);
                        5:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        6:
                            FinishDate := DMY2DATE(30, i, YearPara);
                        7:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        8:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        9:
                            FinishDate := DMY2DATE(30, i, YearPara);
                        10:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        11:
                            FinishDate := DMY2DATE(30, i, YearPara);
                        12:
                            FinishDate := DMY2DATE(31, i, YearPara);
                    end;

                    //Get styles within the period
                    StyleMasterPORec.Reset();
                    StyleMasterPORec.SetCurrentKey("Style No.");
                    StyleMasterPORec.Ascending(true);
                    StyleMasterPORec.SetRange("Ship Date", StartDate, FinishDate);
                    if StyleMasterPORec.FindSet() then begin

                        repeat

                            //Get buyer Name/Code
                            StyleMasterRec.Reset();
                            StyleMasterRec.SetRange("No.", StyleMasterPORec."Style No.");
                            StyleMasterRec.SetFilter("Buyer Name", '<>%1', '');
                            StyleMasterRec.SetFilter(Status, '=%1', StyleMasterRec.Status::Confirmed);

                            if StyleMasterRec.FindSet() then begin

                                // //Get sewing out
                                // ProductionOutHeaderRec.Reset();
                                // ProductionOutHeaderRec.SetRange("Out Style No.", StyleMasterRec."No.");
                                // ProductionOutHeaderRec.SetRange("OUT PO No", StyleMasterPORec."PO No.");
                                // ProductionOutHeaderRec.SetFilter(Type, '=%1', ProductionOutHeaderRec.Type::Saw);

                                // if ProductionOutHeaderRec.FindSet() then begin
                                //     repeat

                                // if (StyleMasterRec."Buyer Name" = 'Inditex') and (StyleMasterRec."Brand Name" = 'STRAVARIUS') then
                                //     xxx := ProductionOutHeaderRec."No.";

                                //Check existance
                                BuyerWiseOdrBookinBalatoSewRec.Reset();
                                BuyerWiseOdrBookinBalatoSewRec.SetRange(Year, YearPara);
                                BuyerWiseOdrBookinBalatoSewRec.SetRange("Buyer Code", StyleMasterRec."Buyer No.");
                                BuyerWiseOdrBookinBalatoSewRec.SetRange("Brand No", StyleMasterRec."Brand No.");
                                if BuyerWiseOdrBookinBalatoSewRec.FindSet() then begin

                                    case i of
                                        1:
                                            begin
                                                BuyerWiseOdrBookinBalatoSewRec.JAN := BuyerWiseOdrBookinBalatoSewRec.JAN - StyleMasterPORec."Sawing Out Qty";
                                                if BuyerWiseOdrBookinBalatoSewRec.JAN < 0 then
                                                    BuyerWiseOdrBookinBalatoSewRec.JAN := 0;
                                            end;
                                        2:
                                            begin
                                                BuyerWiseOdrBookinBalatoSewRec.FEB := BuyerWiseOdrBookinBalatoSewRec.FEB - StyleMasterPORec."Sawing Out Qty";
                                                if BuyerWiseOdrBookinBalatoSewRec.FEB < 0 then
                                                    BuyerWiseOdrBookinBalatoSewRec.FEB := 0;
                                            end;
                                        3:
                                            begin
                                                BuyerWiseOdrBookinBalatoSewRec.MAR := BuyerWiseOdrBookinBalatoSewRec.MAR - StyleMasterPORec."Sawing Out Qty";
                                                if BuyerWiseOdrBookinBalatoSewRec.MAR < 0 then
                                                    BuyerWiseOdrBookinBalatoSewRec.MAR := 0;
                                            end;
                                        4:
                                            begin
                                                BuyerWiseOdrBookinBalatoSewRec.APR := BuyerWiseOdrBookinBalatoSewRec.APR - StyleMasterPORec."Sawing Out Qty";
                                                if BuyerWiseOdrBookinBalatoSewRec.APR < 0 then
                                                    BuyerWiseOdrBookinBalatoSewRec.APR := 0;
                                            end;
                                        5:
                                            begin
                                                BuyerWiseOdrBookinBalatoSewRec.MAY := BuyerWiseOdrBookinBalatoSewRec.MAY - StyleMasterPORec."Sawing Out Qty";
                                                if BuyerWiseOdrBookinBalatoSewRec.MAY < 0 then
                                                    BuyerWiseOdrBookinBalatoSewRec.MAY := 0;
                                            end;
                                        6:
                                            begin
                                                BuyerWiseOdrBookinBalatoSewRec.JUN := BuyerWiseOdrBookinBalatoSewRec.JUN - StyleMasterPORec."Sawing Out Qty";
                                                if BuyerWiseOdrBookinBalatoSewRec.JUN < 0 then
                                                    BuyerWiseOdrBookinBalatoSewRec.JUN := 0;
                                            end;
                                        7:
                                            begin
                                                BuyerWiseOdrBookinBalatoSewRec.JUL := BuyerWiseOdrBookinBalatoSewRec.JUL - StyleMasterPORec."Sawing Out Qty";
                                                if BuyerWiseOdrBookinBalatoSewRec.JUL < 0 then
                                                    BuyerWiseOdrBookinBalatoSewRec.JUL := 0;
                                            end;
                                        8:
                                            begin
                                                BuyerWiseOdrBookinBalatoSewRec.AUG := BuyerWiseOdrBookinBalatoSewRec.AUG - StyleMasterPORec."Sawing Out Qty";
                                                if BuyerWiseOdrBookinBalatoSewRec.AUG < 0 then
                                                    BuyerWiseOdrBookinBalatoSewRec.AUG := 0;
                                            end;
                                        9:
                                            begin
                                                BuyerWiseOdrBookinBalatoSewRec.SEP := BuyerWiseOdrBookinBalatoSewRec.SEP - StyleMasterPORec."Sawing Out Qty";
                                                if BuyerWiseOdrBookinBalatoSewRec.SEP < 0 then
                                                    BuyerWiseOdrBookinBalatoSewRec.SEP := 0;
                                            end;
                                        10:
                                            begin
                                                BuyerWiseOdrBookinBalatoSewRec.OCT := BuyerWiseOdrBookinBalatoSewRec.OCT - StyleMasterPORec."Sawing Out Qty";
                                                if BuyerWiseOdrBookinBalatoSewRec.OCT < 0 then
                                                    BuyerWiseOdrBookinBalatoSewRec.OCT := 0;
                                            end;
                                        11:
                                            begin
                                                BuyerWiseOdrBookinBalatoSewRec.NOV := BuyerWiseOdrBookinBalatoSewRec.NOV - StyleMasterPORec."Sawing Out Qty";
                                                if BuyerWiseOdrBookinBalatoSewRec.NOV < 0 then
                                                    BuyerWiseOdrBookinBalatoSewRec.NOV := 0;
                                            end;
                                        12:
                                            begin
                                                BuyerWiseOdrBookinBalatoSewRec.DEC := BuyerWiseOdrBookinBalatoSewRec.DEC - StyleMasterPORec."Sawing Out Qty";
                                                if BuyerWiseOdrBookinBalatoSewRec.DEC < 0 then
                                                    BuyerWiseOdrBookinBalatoSewRec.DEC := 0;
                                            end;
                                    end;

                                    BuyerWiseOdrBookinBalatoSewRec.Total := BuyerWiseOdrBookinBalatoSewRec.Total - StyleMasterPORec."Sawing Out Qty";
                                    if BuyerWiseOdrBookinBalatoSewRec.Total < 0 then
                                        BuyerWiseOdrBookinBalatoSewRec.Total := 0;

                                    BuyerWiseOdrBookinBalatoSewRec.Modify();

                                end
                                else
                                    Error('cannot find record');

                                //until ProductionOutHeaderRec.Next() = 0;
                                //end;


                                //  //if (StyleNo1 <> StyleMasterRec."No.") then begin

                                // //Get sewing out
                                // ProductionOutHeaderRec.Reset();
                                // ProductionOutHeaderRec.SetRange("Out Style No.", StyleMasterRec."No.");
                                // ProductionOutHeaderRec.SetRange("OUT PO No", StyleMasterPORec."PO No.");
                                // ProductionOutHeaderRec.SetFilter(Type, '=%1', ProductionOutHeaderRec.Type::Saw);

                                // if ProductionOutHeaderRec.FindSet() then begin
                                //     repeat

                                //         // if (StyleMasterRec."Buyer Name" = 'Inditex') and (StyleMasterRec."Brand Name" = 'STRAVARIUS') then
                                //         //     xxx := ProductionOutHeaderRec."No.";

                                //         //Check existance
                                //         BuyerWiseOdrBookinBalatoSewRec.Reset();
                                //         BuyerWiseOdrBookinBalatoSewRec.SetRange(Year,YearPara);
                                //         BuyerWiseOdrBookinBalatoSewRec.SetRange("Buyer Code", StyleMasterRec."Buyer No.");
                                //         BuyerWiseOdrBookinBalatoSewRec.SetRange("Brand No", StyleMasterRec."Brand No.");
                                //         if BuyerWiseOdrBookinBalatoSewRec.FindSet() then begin

                                //             case i of
                                //                 1:
                                //                     begin
                                //                         BuyerWiseOdrBookinBalatoSewRec.JAN := BuyerWiseOdrBookinBalatoSewRec.JAN - ProductionOutHeaderRec."Output Qty";
                                //                         if BuyerWiseOdrBookinBalatoSewRec.JAN < 0 then
                                //                             BuyerWiseOdrBookinBalatoSewRec.JAN := 0;
                                //                     end;
                                //                 2:
                                //                     begin
                                //                         BuyerWiseOdrBookinBalatoSewRec.FEB := BuyerWiseOdrBookinBalatoSewRec.FEB - ProductionOutHeaderRec."Output Qty";
                                //                         if BuyerWiseOdrBookinBalatoSewRec.FEB < 0 then
                                //                             BuyerWiseOdrBookinBalatoSewRec.FEB := 0;
                                //                     end;
                                //                 3:
                                //                     begin
                                //                         BuyerWiseOdrBookinBalatoSewRec.MAR := BuyerWiseOdrBookinBalatoSewRec.MAR - ProductionOutHeaderRec."Output Qty";
                                //                         if BuyerWiseOdrBookinBalatoSewRec.MAR < 0 then
                                //                             BuyerWiseOdrBookinBalatoSewRec.MAR := 0;
                                //                     end;
                                //                 4:
                                //                     begin
                                //                         BuyerWiseOdrBookinBalatoSewRec.APR := BuyerWiseOdrBookinBalatoSewRec.APR - ProductionOutHeaderRec."Output Qty";
                                //                         if BuyerWiseOdrBookinBalatoSewRec.APR < 0 then
                                //                             BuyerWiseOdrBookinBalatoSewRec.APR := 0;
                                //                     end;
                                //                 5:
                                //                     begin
                                //                         BuyerWiseOdrBookinBalatoSewRec.MAY := BuyerWiseOdrBookinBalatoSewRec.MAY - ProductionOutHeaderRec."Output Qty";
                                //                         if BuyerWiseOdrBookinBalatoSewRec.MAY < 0 then
                                //                             BuyerWiseOdrBookinBalatoSewRec.MAY := 0;
                                //                     end;
                                //                 6:
                                //                     begin
                                //                         BuyerWiseOdrBookinBalatoSewRec.JUN := BuyerWiseOdrBookinBalatoSewRec.JUN - ProductionOutHeaderRec."Output Qty";
                                //                         if BuyerWiseOdrBookinBalatoSewRec.JUN < 0 then
                                //                             BuyerWiseOdrBookinBalatoSewRec.JUN := 0;
                                //                     end;
                                //                 7:
                                //                     begin
                                //                         BuyerWiseOdrBookinBalatoSewRec.JUL := BuyerWiseOdrBookinBalatoSewRec.JUL - ProductionOutHeaderRec."Output Qty";
                                //                         if BuyerWiseOdrBookinBalatoSewRec.JUL < 0 then
                                //                             BuyerWiseOdrBookinBalatoSewRec.JUL := 0;
                                //                     end;
                                //                 8:
                                //                     begin
                                //                         BuyerWiseOdrBookinBalatoSewRec.AUG := BuyerWiseOdrBookinBalatoSewRec.AUG - ProductionOutHeaderRec."Output Qty";
                                //                         if BuyerWiseOdrBookinBalatoSewRec.AUG < 0 then
                                //                             BuyerWiseOdrBookinBalatoSewRec.AUG := 0;
                                //                     end;
                                //                 9:
                                //                     begin
                                //                         BuyerWiseOdrBookinBalatoSewRec.SEP := BuyerWiseOdrBookinBalatoSewRec.SEP - ProductionOutHeaderRec."Output Qty";
                                //                         if BuyerWiseOdrBookinBalatoSewRec.SEP < 0 then
                                //                             BuyerWiseOdrBookinBalatoSewRec.SEP := 0;
                                //                     end;
                                //                 10:
                                //                     begin
                                //                         BuyerWiseOdrBookinBalatoSewRec.OCT := BuyerWiseOdrBookinBalatoSewRec.OCT - ProductionOutHeaderRec."Output Qty";
                                //                         if BuyerWiseOdrBookinBalatoSewRec.OCT < 0 then
                                //                             BuyerWiseOdrBookinBalatoSewRec.OCT := 0;
                                //                     end;
                                //                 11:
                                //                     begin
                                //                         BuyerWiseOdrBookinBalatoSewRec.NOV := BuyerWiseOdrBookinBalatoSewRec.NOV - ProductionOutHeaderRec."Output Qty";
                                //                         if BuyerWiseOdrBookinBalatoSewRec.NOV < 0 then
                                //                             BuyerWiseOdrBookinBalatoSewRec.NOV := 0;
                                //                     end;
                                //                 12:
                                //                     begin
                                //                         BuyerWiseOdrBookinBalatoSewRec.DEC := BuyerWiseOdrBookinBalatoSewRec.DEC - ProductionOutHeaderRec."Output Qty";
                                //                         if BuyerWiseOdrBookinBalatoSewRec.DEC < 0 then
                                //                             BuyerWiseOdrBookinBalatoSewRec.DEC := 0;
                                //                     end;
                                //             end;

                                //             BuyerWiseOdrBookinBalatoSewRec.Total := BuyerWiseOdrBookinBalatoSewRec.Total - ProductionOutHeaderRec."Output Qty";
                                //             if BuyerWiseOdrBookinBalatoSewRec.Total < 0 then
                                //                 BuyerWiseOdrBookinBalatoSewRec.Total := 0;

                                //             BuyerWiseOdrBookinBalatoSewRec.Modify();

                                //         end
                                //         else
                                //             Error('cannot find record');
                                //     until ProductionOutHeaderRec.Next() = 0;
                                // end;
                                // //StyleNo1 := StyleMasterRec."No.";
                                // //end;


                            end;

                        until StyleMasterPORec.Next() = 0;
                    end;
                end;


                //Insert total record
                SeqNo += 1;
                BuyerWiseOdrBookinBalatoSewTotRec.Init();
                BuyerWiseOdrBookinBalatoSewTotRec."No." := SeqNo;
                BuyerWiseOdrBookinBalatoSewTotRec.Year := YearPara;
                BuyerWiseOdrBookinBalatoSewTotRec."Buyer Code" := ' ';
                BuyerWiseOdrBookinBalatoSewTotRec."Buyer Name" := 'Total';
                BuyerWiseOdrBookinBalatoSewTotRec.Type := 'T';
                BuyerWiseOdrBookinBalatoSewTotRec."Created User" := UserId;
                BuyerWiseOdrBookinBalatoSewTotRec."Created Date" := WorkDate();
                BuyerWiseOdrBookinBalatoSewTotRec.Insert();

                //Update Grand total
                BuyerWiseOdrBookinBalatoSewTotRec.Reset();
                BuyerWiseOdrBookinBalatoSewTotRec.SetRange(Year, YearPara);
                BuyerWiseOdrBookinBalatoSewTotRec.SetFilter(Type, '=%1', 'T');
                BuyerWiseOdrBookinBalatoSewTotRec.FindSet();

                BuyerWiseOdrBookinBalatoSewRec.Reset();
                BuyerWiseOdrBookinBalatoSewRec.SetRange(Year, YearPara);
                BuyerWiseOdrBookinBalatoSewRec.SetFilter(Type, '<>%1', 'T');
                if BuyerWiseOdrBookinBalatoSewRec.FindSet() then begin
                    repeat
                        BuyerWiseOdrBookinBalatoSewTotRec.JAN := BuyerWiseOdrBookinBalatoSewTotRec.JAN + BuyerWiseOdrBookinBalatoSewRec.JAN;
                        BuyerWiseOdrBookinBalatoSewTotRec.FEB := BuyerWiseOdrBookinBalatoSewTotRec.FEB + BuyerWiseOdrBookinBalatoSewRec.FEB;
                        BuyerWiseOdrBookinBalatoSewTotRec.MAR := BuyerWiseOdrBookinBalatoSewTotRec.MAR + BuyerWiseOdrBookinBalatoSewRec.MAR;
                        BuyerWiseOdrBookinBalatoSewTotRec.APR := BuyerWiseOdrBookinBalatoSewTotRec.APR + BuyerWiseOdrBookinBalatoSewRec.APR;
                        BuyerWiseOdrBookinBalatoSewTotRec.MAY := BuyerWiseOdrBookinBalatoSewTotRec.MAY + BuyerWiseOdrBookinBalatoSewRec.MAY;
                        BuyerWiseOdrBookinBalatoSewTotRec.JUN := BuyerWiseOdrBookinBalatoSewTotRec.JUN + BuyerWiseOdrBookinBalatoSewRec.JUN;
                        BuyerWiseOdrBookinBalatoSewTotRec.JUL := BuyerWiseOdrBookinBalatoSewTotRec.JUL + BuyerWiseOdrBookinBalatoSewRec.JUL;
                        BuyerWiseOdrBookinBalatoSewTotRec.AUG := BuyerWiseOdrBookinBalatoSewTotRec.AUG + BuyerWiseOdrBookinBalatoSewRec.AUG;
                        BuyerWiseOdrBookinBalatoSewTotRec.SEP := BuyerWiseOdrBookinBalatoSewTotRec.SEP + BuyerWiseOdrBookinBalatoSewRec.sep;
                        BuyerWiseOdrBookinBalatoSewTotRec.OCT := BuyerWiseOdrBookinBalatoSewTotRec.OCT + BuyerWiseOdrBookinBalatoSewRec.OCT;
                        BuyerWiseOdrBookinBalatoSewTotRec.NOV := BuyerWiseOdrBookinBalatoSewTotRec.NOV + BuyerWiseOdrBookinBalatoSewRec.NOV;
                        BuyerWiseOdrBookinBalatoSewTotRec.DEC := BuyerWiseOdrBookinBalatoSewTotRec.DEC + BuyerWiseOdrBookinBalatoSewRec.DEC;
                        BuyerWiseOdrBookinBalatoSewTotRec.Total := BuyerWiseOdrBookinBalatoSewTotRec.Total + BuyerWiseOdrBookinBalatoSewRec.Total;
                    until BuyerWiseOdrBookinBalatoSewRec.Next() = 0;
                end;

                BuyerWiseOdrBookinBalatoSewTotRec.Modify();
            End;


            if Count >= 3 then begin
                //////////////////////////////Balance to ship
                //Delete old data
                BuyerWiseOdrBookinBalatoShipRec.Reset();
                BuyerWiseOdrBookinBalatoShipRec.SetRange(Year, YearPara);
                if BuyerWiseOdrBookinBalatoShipRec.FindSet() then
                    BuyerWiseOdrBookinBalatoShipRec.DeleteAll();

                //Get max record  
                SeqNo := 0;
                BuyerWiseOdrBookinBalatoShipRec.Reset();
                if BuyerWiseOdrBookinBalatoShipRec.Findlast() then
                    SeqNo := BuyerWiseOdrBookinBalatoShipRec."No.";

                //Insert all bookings
                BuyWisOdrBookAllBookRec.Reset();
                BuyWisOdrBookAllBookRec.SetCurrentKey("No.", "Buyer Name");
                BuyWisOdrBookAllBookRec.Ascending(false);
                BuyWisOdrBookAllBookRec.SetRange(Year, YearPara);
                BuyWisOdrBookAllBookRec.SetFilter(Type, '<>%1', 'T');
                if BuyWisOdrBookAllBookRec.FindSet() then begin
                    repeat
                        //Insert new line
                        //Done By Sachith on 16/02/23 (insert Brand No and Name)
                        SeqNo += 1;
                        BuyerWiseOdrBookinBalatoShipRec.Init();
                        BuyerWiseOdrBookinBalatoShipRec."No." := SeqNo;
                        BuyerWiseOdrBookinBalatoShipRec.Year := BuyWisOdrBookAllBookRec.Year;
                        BuyerWiseOdrBookinBalatoShipRec."Buyer Code" := BuyWisOdrBookAllBookRec."Buyer Code";
                        BuyerWiseOdrBookinBalatoShipRec."Buyer Name" := BuyWisOdrBookAllBookRec."Buyer Name";
                        BuyerWiseOdrBookinBalatoShipRec."Brand No" := BuyWisOdrBookAllBookRec."Brand No";
                        BuyerWiseOdrBookinBalatoShipRec."Brand Name" := BuyWisOdrBookAllBookRec."Brand Name";
                        BuyerWiseOdrBookinBalatoShipRec.JAN := BuyWisOdrBookAllBookRec.JAN;
                        BuyerWiseOdrBookinBalatoShipRec.FEB := BuyWisOdrBookAllBookRec.FEB;
                        BuyerWiseOdrBookinBalatoShipRec.MAR := BuyWisOdrBookAllBookRec.MAR;
                        BuyerWiseOdrBookinBalatoShipRec.APR := BuyWisOdrBookAllBookRec.APR;
                        BuyerWiseOdrBookinBalatoShipRec.MAY := BuyWisOdrBookAllBookRec.MAY;
                        BuyerWiseOdrBookinBalatoShipRec.JUN := BuyWisOdrBookAllBookRec.JUN;
                        BuyerWiseOdrBookinBalatoShipRec.JUL := BuyWisOdrBookAllBookRec.JUL;
                        BuyerWiseOdrBookinBalatoShipRec.AUG := BuyWisOdrBookAllBookRec.AUG;
                        BuyerWiseOdrBookinBalatoShipRec.SEP := BuyWisOdrBookAllBookRec.SEP;
                        BuyerWiseOdrBookinBalatoShipRec.OCT := BuyWisOdrBookAllBookRec.OCT;
                        BuyerWiseOdrBookinBalatoShipRec.NOV := BuyWisOdrBookAllBookRec.NOV;
                        BuyerWiseOdrBookinBalatoShipRec.DEC := BuyWisOdrBookAllBookRec.DEC;
                        BuyerWiseOdrBookinBalatoShipRec."Created User" := UserId;
                        BuyerWiseOdrBookinBalatoShipRec."Created Date" := WorkDate();
                        BuyerWiseOdrBookinBalatoShipRec.Total := BuyWisOdrBookAllBookRec.Total;
                        BuyerWiseOdrBookinBalatoShipRec.Type := BuyWisOdrBookAllBookRec.Type;
                        BuyerWiseOdrBookinBalatoShipRec.Insert();
                    until BuyWisOdrBookAllBookRec.Next() = 0;
                end;

                for i := 1 to 12 do begin

                    StartDate := DMY2DATE(1, i, YearPara);

                    case i of
                        1:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        2:
                            begin
                                if YearPara mod 4 = 0 then
                                    FinishDate := DMY2DATE(29, i, YearPara)
                                else
                                    FinishDate := DMY2DATE(28, i, YearPara);
                            end;
                        3:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        4:
                            FinishDate := DMY2DATE(30, i, YearPara);
                        5:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        6:
                            FinishDate := DMY2DATE(30, i, YearPara);
                        7:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        8:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        9:
                            FinishDate := DMY2DATE(30, i, YearPara);
                        10:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        11:
                            FinishDate := DMY2DATE(30, i, YearPara);
                        12:
                            FinishDate := DMY2DATE(31, i, YearPara);
                    end;

                    //Get styles within the period
                    StyleMasterPORec.Reset();
                    StyleMasterPORec.SetCurrentKey("Style No.");
                    StyleMasterPORec.Ascending(true);
                    StyleMasterPORec.SetRange("Ship Date", StartDate, FinishDate);
                    if StyleMasterPORec.FindSet() then begin

                        repeat

                            Tot := 0;
                            //Get buyer Name/Code
                            StyleMasterRec.Reset();
                            StyleMasterRec.SetRange("No.", StyleMasterPORec."Style No.");
                            StyleMasterRec.SetFilter("Buyer Name", '<>%1', '');
                            StyleMasterRec.SetFilter(Status, '=%1', StyleMasterRec.Status::Confirmed);

                            if StyleMasterRec.FindSet() then begin

                                //Get postes salin invoices for the style / po
                                PostSalesInvHeaderRec.Reset();
                                PostSalesInvHeaderRec.SetRange("Style No", StyleMasterPORec."Style No.");
                                PostSalesInvHeaderRec.SetRange("po No", StyleMasterPORec."po No.");

                                //Get sales line for the sales invoice
                                if PostSalesInvHeaderRec.FindSet() then begin
                                    repeat
                                        PostSalesInvLineRec.Reset();
                                        PostSalesInvLineRec.SetFilter("Document No.", PostSalesInvHeaderRec."No.");

                                        if PostSalesInvLineRec.FindSet() then begin
                                            repeat
                                                Tot += PostSalesInvLineRec.Quantity;
                                            until PostSalesInvLineRec.Next() = 0;
                                        end

                                    until PostSalesInvHeaderRec.Next() = 0;
                                end;


                                //Check existance
                                BuyerWiseOdrBookinBalatoShipRec.Reset();
                                BuyerWiseOdrBookinBalatoShipRec.SetRange(Year, YearPara);
                                BuyerWiseOdrBookinBalatoShipRec.SetRange("Buyer Code", StyleMasterRec."Buyer No.");
                                BuyerWiseOdrBookinBalatoShipRec.SetRange("Brand No", StyleMasterRec."Brand No.");
                                if BuyerWiseOdrBookinBalatoShipRec.FindSet() then begin

                                    case i of
                                        1:
                                            begin
                                                BuyerWiseOdrBookinBalatoShipRec.JAN := BuyerWiseOdrBookinBalatoShipRec.JAN - Tot;
                                                if BuyerWiseOdrBookinBalatoShipRec.JAN < 0 then
                                                    BuyerWiseOdrBookinBalatoShipRec.JAN := 0;
                                            end;
                                        2:
                                            begin
                                                BuyerWiseOdrBookinBalatoShipRec.FEB := BuyerWiseOdrBookinBalatoShipRec.FEB - Tot;
                                                if BuyerWiseOdrBookinBalatoShipRec.FEB < 0 then
                                                    BuyerWiseOdrBookinBalatoShipRec.FEB := 0;
                                            end;
                                        3:
                                            begin
                                                BuyerWiseOdrBookinBalatoShipRec.MAR := BuyerWiseOdrBookinBalatoShipRec.MAR - Tot;
                                                if BuyerWiseOdrBookinBalatoShipRec.MAR < 0 then
                                                    BuyerWiseOdrBookinBalatoShipRec.MAR := 0;
                                            end;
                                        4:
                                            begin
                                                BuyerWiseOdrBookinBalatoShipRec.APR := BuyerWiseOdrBookinBalatoShipRec.APR - Tot;
                                                if BuyerWiseOdrBookinBalatoShipRec.APR < 0 then
                                                    BuyerWiseOdrBookinBalatoShipRec.APR := 0;
                                            end;
                                        5:
                                            begin
                                                BuyerWiseOdrBookinBalatoShipRec.MAY := BuyerWiseOdrBookinBalatoShipRec.MAY - Tot;
                                                if BuyerWiseOdrBookinBalatoShipRec.MAY < 0 then
                                                    BuyerWiseOdrBookinBalatoShipRec.MAY := 0;
                                            end;
                                        6:
                                            begin
                                                BuyerWiseOdrBookinBalatoShipRec.JUN := BuyerWiseOdrBookinBalatoShipRec.JUN - Tot;
                                                if BuyerWiseOdrBookinBalatoShipRec.JUN < 0 then
                                                    BuyerWiseOdrBookinBalatoShipRec.JUN := 0;
                                            end;
                                        7:
                                            begin
                                                BuyerWiseOdrBookinBalatoShipRec.JUL := BuyerWiseOdrBookinBalatoShipRec.JUL - Tot;
                                                if BuyerWiseOdrBookinBalatoShipRec.JUL < 0 then
                                                    BuyerWiseOdrBookinBalatoShipRec.JUL := 0;
                                            end;
                                        8:
                                            begin
                                                BuyerWiseOdrBookinBalatoShipRec.AUG := BuyerWiseOdrBookinBalatoShipRec.AUG - Tot;
                                                if BuyerWiseOdrBookinBalatoShipRec.AUG < 0 then
                                                    BuyerWiseOdrBookinBalatoShipRec.AUG := 0;
                                            end;
                                        9:
                                            begin
                                                BuyerWiseOdrBookinBalatoShipRec.SEP := BuyerWiseOdrBookinBalatoShipRec.SEP - Tot;
                                                if BuyerWiseOdrBookinBalatoShipRec.SEP < 0 then
                                                    BuyerWiseOdrBookinBalatoShipRec.SEP := 0;
                                            end;
                                        10:
                                            begin
                                                BuyerWiseOdrBookinBalatoShipRec.OCT := BuyerWiseOdrBookinBalatoShipRec.OCT - Tot;
                                                if BuyerWiseOdrBookinBalatoShipRec.OCT < 0 then
                                                    BuyerWiseOdrBookinBalatoShipRec.OCT := 0;
                                            end;
                                        11:
                                            begin
                                                BuyerWiseOdrBookinBalatoShipRec.NOV := BuyerWiseOdrBookinBalatoShipRec.NOV - Tot;
                                                if BuyerWiseOdrBookinBalatoShipRec.NOV < 0 then
                                                    BuyerWiseOdrBookinBalatoShipRec.NOV := 0;
                                            end;
                                        12:
                                            begin
                                                BuyerWiseOdrBookinBalatoShipRec.DEC := BuyerWiseOdrBookinBalatoShipRec.DEC - Tot;
                                                if BuyerWiseOdrBookinBalatoShipRec.DEC < 0 then
                                                    BuyerWiseOdrBookinBalatoShipRec.DEC := 0;
                                            end;
                                    end;

                                    BuyerWiseOdrBookinBalatoShipRec.Total := BuyerWiseOdrBookinBalatoShipRec.Total - Tot;
                                    if BuyerWiseOdrBookinBalatoShipRec.Total < 0 then
                                        BuyerWiseOdrBookinBalatoShipRec.Total := 0;

                                    BuyerWiseOdrBookinBalatoShipRec.Modify();

                                end
                                else
                                    Error('cannot find record');

                            end;

                        until StyleMasterPORec.Next() = 0;
                    end;

                end;

                //Insert total record
                SeqNo += 1;
                BuyerWiseOdrBookinBalatoShipRec.Init();
                BuyerWiseOdrBookinBalatoShipRec."No." := SeqNo;
                BuyerWiseOdrBookinBalatoShipRec.Year := YearPara;
                BuyerWiseOdrBookinBalatoShipRec."Buyer Code" := ' ';
                BuyerWiseOdrBookinBalatoShipRec."Buyer Name" := 'Total';
                BuyerWiseOdrBookinBalatoShipRec.Type := 'T';
                BuyerWiseOdrBookinBalatoShipRec."Created User" := UserId;
                BuyerWiseOdrBookinBalatoShipRec."Created Date" := WorkDate();
                BuyerWiseOdrBookinBalatoShipRec.Insert();

                //Update Grand total
                BuyerWiseOdrBookinBalatoShipRec.Reset();
                BuyerWiseOdrBookinBalatoShipRec.SetRange(Year, YearPara);
                BuyerWiseOdrBookinBalatoShipRec.SetFilter(Type, '=%1', 'T');
                BuyerWiseOdrBookinBalatoShipRec.FindSet();

                BuyerWiseOdrBookinBalatoShipTotRec.Reset();
                BuyerWiseOdrBookinBalatoShipTotRec.SetRange(Year, YearPara);
                BuyerWiseOdrBookinBalatoShipTotRec.SetFilter(Type, '<>%1', 'T');
                if BuyerWiseOdrBookinBalatoShipTotRec.FindSet() then begin
                    repeat
                        BuyerWiseOdrBookinBalatoShipRec.JAN := BuyerWiseOdrBookinBalatoShipRec.JAN + BuyerWiseOdrBookinBalatoShipTotRec.JAN;
                        BuyerWiseOdrBookinBalatoShipRec.FEB := BuyerWiseOdrBookinBalatoShipRec.FEB + BuyerWiseOdrBookinBalatoShipTotRec.FEB;
                        BuyerWiseOdrBookinBalatoShipRec.MAR := BuyerWiseOdrBookinBalatoShipRec.MAR + BuyerWiseOdrBookinBalatoShipTotRec.MAR;
                        BuyerWiseOdrBookinBalatoShipRec.APR := BuyerWiseOdrBookinBalatoShipRec.APR + BuyerWiseOdrBookinBalatoShipTotRec.APR;
                        BuyerWiseOdrBookinBalatoShipRec.MAY := BuyerWiseOdrBookinBalatoShipRec.MAY + BuyerWiseOdrBookinBalatoShipTotRec.MAY;
                        BuyerWiseOdrBookinBalatoShipRec.JUN := BuyerWiseOdrBookinBalatoShipRec.JUN + BuyerWiseOdrBookinBalatoShipTotRec.JUN;
                        BuyerWiseOdrBookinBalatoShipRec.JUL := BuyerWiseOdrBookinBalatoShipRec.JUL + BuyerWiseOdrBookinBalatoShipTotRec.JUL;
                        BuyerWiseOdrBookinBalatoShipRec.AUG := BuyerWiseOdrBookinBalatoShipRec.AUG + BuyerWiseOdrBookinBalatoShipTotRec.AUG;
                        BuyerWiseOdrBookinBalatoShipRec.SEP := BuyerWiseOdrBookinBalatoShipRec.SEP + BuyerWiseOdrBookinBalatoShipTotRec.sep;
                        BuyerWiseOdrBookinBalatoShipRec.OCT := BuyerWiseOdrBookinBalatoShipRec.OCT + BuyerWiseOdrBookinBalatoShipTotRec.OCT;
                        BuyerWiseOdrBookinBalatoShipRec.NOV := BuyerWiseOdrBookinBalatoShipRec.NOV + BuyerWiseOdrBookinBalatoShipTotRec.NOV;
                        BuyerWiseOdrBookinBalatoShipRec.DEC := BuyerWiseOdrBookinBalatoShipRec.DEC + BuyerWiseOdrBookinBalatoShipTotRec.DEC;
                        BuyerWiseOdrBookinBalatoShipRec.Total := BuyerWiseOdrBookinBalatoShipRec.Total + BuyerWiseOdrBookinBalatoShipTotRec.Total;
                    until BuyerWiseOdrBookinBalatoShipTotRec.Next() = 0;
                end;

                BuyerWiseOdrBookinBalatoShipRec.Modify();
            End;


            if Count = 4 then begin
                ///////////////////////////////Group wise booking
                //Delete old data
                BuyerWiseOdrBookinGRWiseBookRec.Reset();
                BuyerWiseOdrBookinGRWiseBookRec.SetRange(Year, YearPara);
                if BuyerWiseOdrBookinGRWiseBookRec.FindSet() then
                    BuyerWiseOdrBookinGRWiseBookRec.DeleteAll();

                //Get max record  
                SeqNo := 0;
                BuyerWiseOdrBookinGRWiseBookRec.Reset();
                if BuyerWiseOdrBookinGRWiseBookRec.Findlast() then
                    SeqNo := BuyerWiseOdrBookinGRWiseBookRec."No.";

                //Insert all group heads
                MerchanGroupTableRec.Reset();
                if MerchanGroupTableRec.FindSet() then begin
                    repeat

                        BuyerWiseOdrBookinGRWiseBookRec.Reset();
                        BuyerWiseOdrBookinGRWiseBookRec.SetRange(Year, YearPara);
                        BuyerWiseOdrBookinGRWiseBookRec.SetRange("Group Name", MerchanGroupTableRec."Group Name");
                        if not BuyerWiseOdrBookinGRWiseBookRec.findset() then begin

                            SeqNo += 1;
                            BuyerWiseOdrBookinGRWiseBookRec.Init();
                            BuyerWiseOdrBookinGRWiseBookRec."No." := SeqNo;
                            BuyerWiseOdrBookinGRWiseBookRec."Group Id" := MerchanGroupTableRec."Group Id";
                            BuyerWiseOdrBookinGRWiseBookRec."Group Head" := MerchanGroupTableRec."Group Head";
                            BuyerWiseOdrBookinGRWiseBookRec."Group Name" := MerchanGroupTableRec."Group Name";
                            BuyerWiseOdrBookinGRWiseBookRec.Year := YearPara;
                            BuyerWiseOdrBookinGRWiseBookRec."Created User" := UserId;
                            BuyerWiseOdrBookinGRWiseBookRec."Created Date" := WorkDate();
                            BuyerWiseOdrBookinGRWiseBookRec.Type := 'L';
                            BuyerWiseOdrBookinGRWiseBookRec.Insert();
                        end
                        else begin
                            BuyerWiseOdrBookinGRWiseBookRec.JAN := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.FEB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.MAR := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.APR := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.MAY := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.JUN := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.JUL := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.AUG := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.SEP := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.OCT := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.NOV := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.DEC := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.JAN_FOB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.FEB_FOB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.MAR_FOB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.APR_FOB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.MAY_FOB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.JUN_FOB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.JUL_FOB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.AUG_FOB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.SEP_FOB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.OCT_FOB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.NOV_FOB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.DEC_FOB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.Total := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.Total_FOB := 0;
                            BuyerWiseOdrBookinGRWiseBookRec.Modify();
                        end;

                    until MerchanGroupTableRec.Next() = 0;
                end;

                //Insert Grand total line
                BuyerWiseOdrBookinGRWiseBookRec.Init();
                BuyerWiseOdrBookinGRWiseBookRec."No." := SeqNo;
                BuyerWiseOdrBookinGRWiseBookRec.Year := YearPara;
                BuyerWiseOdrBookinGRWiseBookRec."Group Id" := 'Total';
                BuyerWiseOdrBookinGRWiseBookRec."Group Head" := 'Total';
                BuyerWiseOdrBookinGRWiseBookRec."Group Name" := 'Total';
                BuyerWiseOdrBookinGRWiseBookRec.Type := 'T';
                BuyerWiseOdrBookinGRWiseBookRec."Created User" := UserId;
                BuyerWiseOdrBookinGRWiseBookRec."Created Date" := WorkDate();
                BuyerWiseOdrBookinGRWiseBookRec.Insert();

                for i := 1 to 12 do begin

                    StartDate := DMY2DATE(1, i, YearPara);

                    case i of
                        1:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        2:
                            begin
                                if YearPara mod 4 = 0 then
                                    FinishDate := DMY2DATE(29, i, YearPara)
                                else
                                    FinishDate := DMY2DATE(28, i, YearPara);
                            end;
                        3:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        4:
                            FinishDate := DMY2DATE(30, i, YearPara);
                        5:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        6:
                            FinishDate := DMY2DATE(30, i, YearPara);
                        7:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        8:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        9:
                            FinishDate := DMY2DATE(30, i, YearPara);
                        10:
                            FinishDate := DMY2DATE(31, i, YearPara);
                        11:
                            FinishDate := DMY2DATE(30, i, YearPara);
                        12:
                            FinishDate := DMY2DATE(31, i, YearPara);
                    end;

                    //Get style po details for the date range
                    StyleMasterPORec.Reset();
                    StyleMasterPORec.SetCurrentKey("Style No.");
                    StyleMasterPORec.Ascending(true);
                    StyleMasterPORec.SetRange("Ship Date", StartDate, FinishDate);
                    if StyleMasterPORec.FindSet() then begin
                        repeat

                            //Get buyer for the style
                            StyleMasterRec.Reset();
                            StyleMasterRec.SetRange("No.", StyleMasterPORec."Style No.");
                            StyleMasterRec.SetFilter("Buyer Name", '<>%1', '');
                            StyleMasterRec.SetFilter(Status, '=%1', StyleMasterRec.Status::Confirmed);
                            if StyleMasterRec.FindSet() then begin

                                //Get merchnadizer group for the buyer
                                CustomerRec.Reset();
                                CustomerRec.SetRange("No.", StyleMasterRec."Buyer No.");
                                if CustomerRec.FindSet() then begin

                                    //Check existance
                                    BuyerWiseOdrBookinGRWiseBookRec.Reset();
                                    BuyerWiseOdrBookinGRWiseBookRec.SetRange(Year, YearPara);
                                    BuyerWiseOdrBookinGRWiseBookRec.SetRange("Group Id", CustomerRec."Group Id");
                                    BuyerWiseOdrBookinGRWiseBookRec.SetFilter(Type, '<>%1', 'T');
                                    if BuyerWiseOdrBookinGRWiseBookRec.FindSet() then begin

                                        case i of
                                            1:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.JAN := BuyerWiseOdrBookinGRWiseBookRec.JAN + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.JAN_FOB := BuyerWiseOdrBookinGRWiseBookRec.JAN_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            2:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.FEB := BuyerWiseOdrBookinGRWiseBookRec.FEB + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.FEB_FOB := BuyerWiseOdrBookinGRWiseBookRec.FEB_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            3:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.MAR := BuyerWiseOdrBookinGRWiseBookRec.MAR + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.MAR_FOB := BuyerWiseOdrBookinGRWiseBookRec.MAR_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            4:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.APR := BuyerWiseOdrBookinGRWiseBookRec.APR + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.APR_FOB := BuyerWiseOdrBookinGRWiseBookRec.APR_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            5:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.MAY := BuyerWiseOdrBookinGRWiseBookRec.MAY + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.MAY_FOB := BuyerWiseOdrBookinGRWiseBookRec.MAY_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            6:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.JUN := BuyerWiseOdrBookinGRWiseBookRec.JUN + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.JUN_FOB := BuyerWiseOdrBookinGRWiseBookRec.JUN_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            7:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.JUL := BuyerWiseOdrBookinGRWiseBookRec.JUL + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.JUL_FOB := BuyerWiseOdrBookinGRWiseBookRec.JUL_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            8:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.AUG := BuyerWiseOdrBookinGRWiseBookRec.AUG + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.AUG_FOB := BuyerWiseOdrBookinGRWiseBookRec.AUG_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            9:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.SEP := BuyerWiseOdrBookinGRWiseBookRec.SEP + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.SEP_FOB := BuyerWiseOdrBookinGRWiseBookRec.SEP_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            10:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.OCT := BuyerWiseOdrBookinGRWiseBookRec.OCT + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.OCT_FOB := BuyerWiseOdrBookinGRWiseBookRec.OCT_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            11:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.NOV := BuyerWiseOdrBookinGRWiseBookRec.NOV + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.NOV_FOB := BuyerWiseOdrBookinGRWiseBookRec.NOV_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            12:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.DEC := BuyerWiseOdrBookinGRWiseBookRec.DEC + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.DEC_FOB := BuyerWiseOdrBookinGRWiseBookRec.DEC_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                        end;

                                        BuyerWiseOdrBookinGRWiseBookRec.Total := BuyerWiseOdrBookinGRWiseBookRec.Total + StyleMasterPORec."Qty";
                                        BuyerWiseOdrBookinGRWiseBookRec.Total_FOB := BuyerWiseOdrBookinGRWiseBookRec.Total_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                        BuyerWiseOdrBookinGRWiseBookRec.Modify();

                                    end;

                                    //Update Grand total
                                    BuyerWiseOdrBookinGRWiseBookRec.Reset();
                                    BuyerWiseOdrBookinGRWiseBookRec.SetRange(Year, YearPara);
                                    BuyerWiseOdrBookinGRWiseBookRec.SetFilter(Type, '=%1', 'T');
                                    if BuyerWiseOdrBookinGRWiseBookRec.FindSet() then begin
                                        case i of
                                            1:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.JAN := BuyerWiseOdrBookinGRWiseBookRec.JAN + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.JAN_FOB := BuyerWiseOdrBookinGRWiseBookRec.JAN_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            2:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.FEB := BuyerWiseOdrBookinGRWiseBookRec.FEB + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.FEB_FOB := BuyerWiseOdrBookinGRWiseBookRec.FEB_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            3:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.MAR := BuyerWiseOdrBookinGRWiseBookRec.MAR + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.MAR_FOB := BuyerWiseOdrBookinGRWiseBookRec.MAR_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            4:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.APR := BuyerWiseOdrBookinGRWiseBookRec.APR + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.APR_FOB := BuyerWiseOdrBookinGRWiseBookRec.APR_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            5:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.MAY := BuyerWiseOdrBookinGRWiseBookRec.MAY + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.MAY_FOB := BuyerWiseOdrBookinGRWiseBookRec.MAY_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            6:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.JUN := BuyerWiseOdrBookinGRWiseBookRec.JUN + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.JUN_FOB := BuyerWiseOdrBookinGRWiseBookRec.JUN_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            7:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.JUL := BuyerWiseOdrBookinGRWiseBookRec.JUL + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.JUL_FOB := BuyerWiseOdrBookinGRWiseBookRec.JUL_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            8:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.AUG := BuyerWiseOdrBookinGRWiseBookRec.AUG + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.AUG_FOB := BuyerWiseOdrBookinGRWiseBookRec.AUG_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            9:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.SEP := BuyerWiseOdrBookinGRWiseBookRec.SEP + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.SEP_FOB := BuyerWiseOdrBookinGRWiseBookRec.SEP_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            10:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.OCT := BuyerWiseOdrBookinGRWiseBookRec.OCT + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.OCT_FOB := BuyerWiseOdrBookinGRWiseBookRec.OCT_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            11:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.NOV := BuyerWiseOdrBookinGRWiseBookRec.NOV + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.NOV_FOB := BuyerWiseOdrBookinGRWiseBookRec.NOV_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                            12:
                                                begin
                                                    BuyerWiseOdrBookinGRWiseBookRec.DEC := BuyerWiseOdrBookinGRWiseBookRec.DEC + StyleMasterPORec."Qty";
                                                    BuyerWiseOdrBookinGRWiseBookRec.DEC_FOB := BuyerWiseOdrBookinGRWiseBookRec.DEC_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                end;
                                        end;

                                        BuyerWiseOdrBookinGRWiseBookRec.Total := BuyerWiseOdrBookinGRWiseBookRec.Total + StyleMasterPORec."Qty";
                                        BuyerWiseOdrBookinGRWiseBookRec.Total_FOB := BuyerWiseOdrBookinGRWiseBookRec.Total_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                        BuyerWiseOdrBookinGRWiseBookRec.Modify();
                                    end;

                                end;

                            end;

                        until StyleMasterPORec.Next() = 0;
                    end;

                end;

            End;

            Commit();
        end
        else
            Error('Year is blank.');
    end;

}
