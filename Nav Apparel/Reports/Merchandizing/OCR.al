report 50612 OCR
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Report_Layouts/Merchandizing/OCR.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");
            column(Season_Name; "Season Name")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Garment_Type_Name; "Garment Type Name")
            { }
            column(Style_No_; "Style No.")
            { }
            column(Order_Qty; "Order Qty")
            { }
            column(Garment_Type_No_; "Garment Type No.")
            { }
            column(No_; "No.")
            { }
            column(PO_Total; "PO Total")
            { }
            column(styleNO_p; styleNO_p)
            { }
            column(Department_Name_style; "Department Name")
            { }
            column(Ship_Date_Style; "Ship Date")
            { }
            column(Factory_Name; "Factory Name")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(ContractNo; ContractNo)
            { }
            column(FobPcs; FobPcs)
            { }
            column(TotFab; TotFab)
            { }
            column(TotEmb; TotEmb)
            { }
            column(TotTrims; TotTrims)
            { }
            column(Totwash; Totwash)
            { }
            column(CommerVal; CommerVal)
            { }
            column(CommiVal; CommiVal)
            { }
            column(MFGVal; MFGVal)
            { }
            column(OverHeadVal; OverHeadVal)
            { }
            column(DeffPayVal; DeffPayVal)
            { }
            column(RiskFacVal; RiskFacVal)
            { }
            column(TaxVal; TaxVal)
            { }
            column(SourcingVal; SourcingVal)
            { }
            column(CMDOZ; CMDOZ)
            { }
            column(SMV; SMV)
            { }
            column(CPM; CPM)
            { }
            column(salesInvoiceLineQuanty; salesInvoiceLineQuanty)
            { }
            column(salesInvoiceLineValue; salesInvoiceLineValue)
            { }
            column(ProfitMarginDOZ; ProfitMarginDOZ)
            { }

            dataitem(BOM; BOM)
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting(No);

                dataitem("BOM Line AutoGen"; "BOM Line AutoGen")
                {
                    DataItemLinkReference = BOM;
                    DataItemLink = "No." = field(No);
                    DataItemTableView = sorting("Item No.");

                    column(Placement_of_GMT; "Placement of GMT")
                    { }
                    column(GMT_Color_Name; "GMT Color Name")
                    { }
                    column(Article_Name_; "Article Name.")
                    { }
                    column(Item_No_; "Item No.")
                    { }
                    column(Item_Color_Name; "Item Color Name")
                    { }
                    column(Unit_N0_; "Unit N0.")
                    { }
                    column(Qty; Qty)
                    { }
                    column(WST; WST)
                    { }
                    column(Type; Type)
                    { }
                    column(Consumption; Consumption)
                    { }
                    column(RequirmentQTY; Requirment)
                    { }
                    column(AjstReq; AjstReq)
                    { }
                    column(Dimension_Name_; "Dimension Name.")
                    { }
                    column(Revishion; Revishion)
                    { }
                    column(Item_Name; "Item Name")
                    { }
                    column(UnitPrice; Rate)
                    { }
                    column(Main_Category_Name; "Main Category Name")
                    { }
                    column(Value; Value)
                    { }
                    column(GarmentConsumption; GarmentConsumption)
                    { }
                    column(GMT_Qty; "GMT Qty")
                    { }
                    column(Divi; Divi)
                    { }
                    column(Actual_Procured; ActualProc)
                    { }
                    column(ActualProcVal; ActualProcVal)
                    { }
                    column(TransferLineRecSReceived; TransferLineRecSReceived)
                    { }
                    column(NewItemNo; "New Item No.")
                    { }
                    column(Supplier_Name_; "Supplier Name.")
                    { }

                    trigger OnAfterGetRecord()
                    var
                    begin
                        ActualProc := 0;
                        purchRec.Reset();
                        purchRec.SetRange("No.", "BOM Line AutoGen"."New Item No.");
                        purchRec.SetRange(StyleName, "Style Master"."Style No.");
                        purchRec.SetRange(PONo, "BOM Line AutoGen"."PO");
                        purchRec.SetRange(Lot, "BOM Line AutoGen"."Lot No.");
                        purchRec.SetRange("Color Name", "BOM Line AutoGen"."Item Color Name");
                        if purchRec.Findset() then begin
                            repeat
                                ActualProc += purchRec.Quantity;
                            until purchRec.Next() = 0;
                        end;

                        // if "Item No." = 'ABA-ITEM-0407' then
                        //     "Item No." := "Item No.";

                        ActualProcVal := ActualProc * Rate;

                        TransferLineRecSReceived := 0;
                        ItemLeRec.Reset();
                        ItemLeRec.SetRange("Style No.", "Style Master"."No.");
                        ItemLeRec.SetRange(PO, "BOM Line AutoGen"."PO");
                        ItemLeRec.SetRange("Item No.", "BOM Line AutoGen"."New Item No.");
                        if ItemLeRec.FindSet() then begin
                            repeat
                                if ItemLeRec."Entry Type" = ItemLeRec."Entry Type"::Consumption then begin
                                    TransferLineRecSReceived += ItemLeRec.Quantity * -1;
                                end;
                            until ItemLeRec.Next() = 0;
                        end;

                        GarmentConsumption := Qty * Consumption;

                        // TransferLineRec.Reset();
                        // TransferLineRec.SetRange("Item No.", "BOM Line AutoGen"."Item No.");
                        // if TransferLineRec.FindSet() then begin
                        //     // TransferLineRecSReceived := TransferLineRec."Quantity Received"
                        // end;

                        BomRec.Reset();
                        BomRec.SetRange(No, "Style Master"."No.");
                        BomRec.SetRange("Style No.", "Style Master"."Style No.");
                        if BomRec.FindFirst() then begin
                            Revishion := BomRec.Revision;
                        end;

                        Divi := 0;
                        if Type = 0 then begin
                            Divi := 12;
                        end
                        else
                            Divi := 1;
                    end;
                }
            }

            dataitem("Style Master PO"; "Style Master PO")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Style No.") where("PO No." = filter(<> ''));

                column(PoNum; "PO No.")
                { }
                column(LOT; "Lot No.")
                { }
                column(shipDate; "Ship Date")
                { }
                column(QTY1; Qty)
                { }
                column(lineAmt; lineAmt)
                { }
                column(Unit_Price_PO; "Unit Price")
                { }
                column(Style_No_po; "Style No.")
                { }

                trigger OnAfterGetRecord()
                var
                // SalesInvHeaderRec: Record "Sales Invoice Header";
                // SalesInvLineRec: Record "Sales Invoice Line";
                begin
                    lineAmt := 0;
                    lineAmt := "Style Master PO".Qty * "Style Master PO"."Unit Price";
                    TotlineAmt += lineAmt;

                    // SalesInvHeaderRec.Reset();
                    // SalesInvHeaderRec.SetRange("Style No", "Style No.");
                    // SalesInvHeaderRec.SetRange("PO No", "po No.");
                    // if SalesInvHeaderRec.Findset() then begin
                    //     repeat
                    //         SalesInvLineRec.Reset();
                    //         SalesInvLineRec.SetRange("Document No.", SalesInvHeaderRec."No.");
                    //         SalesInvLineRec.SetRange(Type, SalesInvLineRec.Type::Item);
                    //         if SalesInvLineRec.Findset() then begin
                    //             repeat
                    //                 salesInvoiceLineQuanty += SalesInvLineRec.Quantity;
                    //                 salesInvoiceLineValue += SalesInvLineRec.Quantity * SalesInvLineRec."Unit Price";
                    //             until SalesInvLineRec.Next() = 0;
                    //         end;
                    //     until SalesInvHeaderRec.Next() = 0;
                    // end;
                end;
            }


            trigger OnAfterGetRecord()
            var
                StyleContractRec: Record "Contract/LCStyle";
                ContractMasterRec: Record "Contract/LCMaster";
                StyleMasPoRec: Record "Style Master PO";
                BOMAutoGenRec: Record "BOM Line AutoGen";
                BOMRec: Record "BOM";
                BOMEstCostRec: Record "BOM Estimate Cost";
                NavAppSetupRec: Record "NavApp Setup";
                Temp: Decimal;
                SalesInvHeaderRec: Record "Sales Invoice Header";
                SalesInvLineRec: Record "Sales Invoice Line";
            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                //get contract
                StyleContractRec.Reset();
                StyleContractRec.SetRange("Style No.", "No.");
                if StyleContractRec.Findset() then begin
                    ContractMasterRec.Reset();
                    ContractMasterRec.SetRange("No.", StyleContractRec."No.");
                    if ContractMasterRec.Findset() then
                        ContractNo := ContractMasterRec."Contract No";
                end;

                Fobpcs := 0;
                PoTOt := 0;
                salesInvoiceLineQuanty := 0;
                salesInvoiceLineValue := 0;
                CommerVal := 0;
                CommiVal := 0;
                MFGVal := 0;
                OverHeadVal := 0;
                DeffPayVal := 0;
                RiskFacVal := 0;
                TaxVal := 0;
                SourcingVal := 0;
                TotFab := 0;
                TotEmb := 0;
                TotTrims := 0;
                TotWash := 0;

                StyleMasPoRec.Reset();
                StyleMasPoRec.SetRange("Style No.", "No.");
                if StyleMasPoRec.Findset() then begin
                    repeat
                        PoTOt += StyleMasPoRec.Qty;
                        TotlineAmt += StyleMasPoRec.Qty * StyleMasPoRec."Unit Price";

                        SalesInvHeaderRec.Reset();
                        SalesInvHeaderRec.SetRange("Style No", "No.");
                        SalesInvHeaderRec.SetRange("PO No", StyleMasPoRec."po No.");
                        SalesInvHeaderRec.SetRange(Lot, StyleMasPoRec."Lot No.");
                        if SalesInvHeaderRec.Findset() then begin
                            repeat
                                SalesInvLineRec.Reset();
                                SalesInvLineRec.SetRange("Document No.", SalesInvHeaderRec."No.");
                                SalesInvLineRec.SetRange(Type, SalesInvLineRec.Type::Item);
                                if SalesInvLineRec.Findset() then begin
                                    repeat
                                        salesInvoiceLineQuanty += SalesInvLineRec.Quantity;
                                        salesInvoiceLineValue += SalesInvLineRec.Quantity * SalesInvLineRec."Unit Price";
                                    until SalesInvLineRec.Next() = 0;
                                end;
                            until SalesInvHeaderRec.Next() = 0;
                        end;

                    until StyleMasPoRec.Next() = 0;
                    if PoTOt > 0 then
                        Fobpcs := TotlineAmt / PoTOt;
                end;
                TotFOBVal := PoTOt * Fobpcs;


                BOMEstCostRec.Reset();
                BOMEstCostRec.SetRange("Style No.", "No.");
                if BOMEstCostRec.Findset() then begin
                    CommerVal := (TotFOBVal * BOMEstCostRec."Commercial %") / 100;
                    CommiVal := (TotFOBVal * BOMEstCostRec."Commission %") / 100;
                    MFGVal := (TotFOBVal * BOMEstCostRec."MFG Cost %") / 100;
                    OverHeadVal := (TotFOBVal * BOMEstCostRec."Overhead %") / 100;
                    DeffPayVal := (TotFOBVal * BOMEstCostRec."Deferred Payment %") / 100;
                    RiskFacVal := (TotFOBVal * BOMEstCostRec."Risk factor %") / 100;
                    TaxVal := (TotFOBVal * BOMEstCostRec."TAX %") / 100;
                    SourcingVal := (TotFOBVal * BOMEstCostRec."ABA Sourcing %") / 100;
                    SMV := BOMEstCostRec.SMV;
                    CMDOZ := BOMEstCostRec."CM Doz";
                    ProfitMarginDOZ := BOMEstCostRec."Profit Margin Dz.";

                    //Calculate NewCPM
                    NavAppSetupRec.Reset();
                    NavAppSetupRec.FindSet();
                    Temp := NavAppSetupRec."Base Efficiency" - BOMEstCostRec."Project Efficiency.";
                    CPM := BOMEstCostRec.CPM + (BOMEstCostRec.CPM * Temp) / 100;
                end;


                BOMRec.Reset();
                BOMRec.SetRange("Style No.", "No.");
                if BOMRec.Findset() then begin
                    BOMAutoGenRec.Reset();
                    BOMAutoGenRec.SetRange("No.", BOMRec."No");
                    if BOMAutoGenRec.Findset() then
                        repeat
                            if BOMAutoGenRec."Main Category Name" = 'FABRIC' then begin
                                TotFab += BOMAutoGenRec.Value;
                            end;

                            if (BOMAutoGenRec."Main Category Name" = 'EMBROIDERY') or (BOMAutoGenRec."Main Category Name" = 'PRINT') then begin
                                TotEmb += BOMAutoGenRec.Value;
                            end;

                            if (BOMAutoGenRec."Main Category Name" <> 'WASHING') and (BOMAutoGenRec."Main Category Name" <> 'FABRIC') and (BOMAutoGenRec."Main Category Name" <> 'EMBROIDERY') and (BOMAutoGenRec."Main Category Name" <> 'PRINT') then begin
                                TotTrims += BOMAutoGenRec.Value;
                            end;

                            if BOMAutoGenRec."Main Category Name" = 'WASHING' then begin
                                TotWash += BOMAutoGenRec.Value;
                            end;
                        until BOMAutoGenRec.Next() = 0;
                end;

            end;

            trigger OnPreDataItem()
            begin
                SetRange("No.", FilterNo);
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
                    field(FilterNo; FilterNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Style';
                        TableRelation = "Style Master"."No.";
                    }
                }
            }
        }
    }

    var
        NoFilter: Code[20];
        StyleMasterPoRec: Record "Style Master PO";
        BomRec: Record BOM;
        styleNO_p: Code[20];
        Revishion: Integer;
        postedPurchLineRec: Record "Purch. Rcpt. Line";
        QuantityPurch: Decimal;
        TotFab: Decimal;
        TotEmb: Decimal;
        TotWash: Decimal;
        TotTrims: Decimal;
        lineAmt: Decimal;
        TotlineAmt: Decimal;
        TransferLineRecSReceived: Decimal;
        styleNOFil: Text[50];
        salesInvoiceLineRec: Record "Sales Invoice Line";
        salesInvoiceLineQuanty: Decimal;
        salesInvoiceLineValue: Decimal;
        GarmentConsumption: Decimal;
        ItemLeRec: Record "Item Ledger Entry";
        ReqQty: Decimal;
        PoTOt: BigInteger;
        Divi: Integer;
        vbalance: Decimal;
        BomEstiRec: Record "BOM Estimate Cost";
        FobPcs: Decimal;
        comRec: Record "Company Information";
        FilterNo: Code[30];
        ItemLedgerRec: Record "Item Ledger Entry";
        IssueQty: Decimal;
        purchRec: Record "Purch. Rcpt. Line";
        ActualProc: Decimal;
        ActualProcVal: Decimal;
        ContractNo: Text[50];
        CommerVal: Decimal;
        CommiVal: Decimal;
        MFGVal: Decimal;
        OverHeadVal: Decimal;
        DeffPayVal: Decimal;
        RiskFacVal: Decimal;
        TaxVal: Decimal;
        SourcingVal: Decimal;
        TotFOBVal: Decimal;
        CPM: Decimal;
        SMV: Decimal;
        CMDOZ: Decimal;
        ProfitMarginDOZ: Decimal;

}


