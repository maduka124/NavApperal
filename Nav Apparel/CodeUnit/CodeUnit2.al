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
        GenJournalRec: Record "Gen. Journal Line";
        NavAppSetupRec: Record "NavApp Setup";
        AcceptHeaderRec: Record AcceptanceHeader;
        LoginSessionsRec: Record LoginSessions;
        TempValue1: Decimal;
        TempValue2: Decimal;
    begin
        //Get Worksheet line no
        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        GenJournalRec.Reset();
        GenJournalRec.SetRange("Journal Template Name", NavAppSetupRec."Pay. Gen. Jrn. Template Name");
        GenJournalRec.SetRange("Journal Batch Name", NavAppSetupRec."Pay. Gen. Jrn. Batch Name");

        if GenJournalRec.Findfirst() then begin
            repeat

                //Update status 
                AcceptHeaderRec.Reset();
                AcceptHeaderRec.SetRange("AccNo.", GenJournalRec."Document No.");
                if AcceptHeaderRec.FindSet() then begin
                    AcceptHeaderRec.Paid := true;
                    AcceptHeaderRec.PaidDate := WorkDate();
                    AcceptHeaderRec.Modify();

                    evaluate(Y, copystr(Format(WorkDate), 1, 2));
                    Y := Y + 2000;
                    evaluate(M, copystr(Format(WorkDate), 4, 2));

                    SuppPayRec.Reset();
                    SuppPayRec.SetRange("Suppler No.", GenJournalRec.SupplierNo);
                    SuppPayRec.SetRange(Year, Y);

                    if SuppPayRec.FindSet() then begin

                        case M of
                            1:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.January);
                                    TempValue2 := TempValue1 + GenJournalRec."Amount";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            2:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.February);
                                    TempValue2 := TempValue1 + GenJournalRec."Amount";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            3:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.March);
                                    TempValue2 := TempValue1 + GenJournalRec."Amount";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            4:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.April);
                                    TempValue2 := TempValue1 + GenJournalRec."Amount";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            5:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.May);
                                    TempValue2 := TempValue1 + GenJournalRec."Amount";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            6:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.June);
                                    TempValue2 := TempValue1 + GenJournalRec."Amount";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            7:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.July);
                                    TempValue2 := TempValue1 + GenJournalRec."Amount";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            8:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.August);
                                    TempValue2 := TempValue1 + GenJournalRec."Amount";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            9:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.September);
                                    TempValue2 := TempValue1 + GenJournalRec."Amount";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            10:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.October);
                                    TempValue2 := TempValue1 + GenJournalRec."Amount";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            11:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.November);
                                    TempValue2 := TempValue1 + GenJournalRec."Amount";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            12:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.December);
                                    TempValue2 := TempValue1 + GenJournalRec."Amount";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                        end;

                        SuppPayRec.Modify();

                    end
                    else begin
                        SuppPayRec.Init();
                        SuppPayRec."Suppler No." := GenJournalRec.SupplierNo;
                        SuppPayRec."Suppler Name" := GenJournalRec.SupplierName;
                        SuppPayRec.Year := Y;

                        case M of
                            1:
                                begin
                                    SuppPayRec.January := format(GenJournalRec."Amount");
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
                                    SuppPayRec.February := format(GenJournalRec."Amount");
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
                                    SuppPayRec.March := format(GenJournalRec."Amount");
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
                                    SuppPayRec.April := format(GenJournalRec."Amount");
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
                                    SuppPayRec.May := format(GenJournalRec."Amount");
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
                                    SuppPayRec.June := format(GenJournalRec."Amount");
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
                                    SuppPayRec.July := format(GenJournalRec."Amount");
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
                                    SuppPayRec.August := format(GenJournalRec."Amount");
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
                                    SuppPayRec.September := format(GenJournalRec."Amount");
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
                                    SuppPayRec.October := format(GenJournalRec."Amount");
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
                                    SuppPayRec.November := format(GenJournalRec."Amount");
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
                                    SuppPayRec.December := format(GenJournalRec."Amount");
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

            until GenJournalRec.Next() = 0;
        end;

    end;

}
