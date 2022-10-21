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


    

}
