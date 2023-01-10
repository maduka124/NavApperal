codeunit 50618 NavAppCodeUnit
{
    //Update Production in the Style Master table
    procedure Update_Sty_Master_PO(StyleNo: Code[20]; LotNo: Code[20]; Input: code[10]; Type: Text[10]; Type1: Option)
    var
        StyleMasterPORec: Record "Style Master PO";
        ProductionOutLine: Record ProductionOutLine;
        LineTotal: BigInteger;
    begin

        LineTotal := 0;

        if (StyleNo <> '') and (LotNo <> '') then begin

            //Get out Total
            ProductionOutLine.Reset();
            ProductionOutLine.SetRange("Style No.", StyleNo);
            ProductionOutLine.SetRange("Lot No.", LotNo);
            ProductionOutLine.SetRange(Type, Type1);
            ProductionOutLine.SetRange(In_Out, Input);

            if ProductionOutLine.FindSet() then begin
                repeat
                    if ProductionOutLine."Colour No" <> '*' then
                        LineTotal += ProductionOutLine.Total;
                until ProductionOutLine.Next() = 0;
            end;


            StyleMasterPORec.Reset();
            StyleMasterPORec.SetRange("Style No.", StyleNo);
            StyleMasterPORec.SetRange("Lot No.", LotNo);
            StyleMasterPORec.FindSet();

            CASE Type OF
                'Saw':
                    BEGIN
                        if Input = 'IN' then
                            StyleMasterPORec.ModifyAll("Sawing In Qty", LineTotal)
                        else
                            if Input = 'OUT' then
                                StyleMasterPORec.ModifyAll("Sawing Out Qty", LineTotal);
                    END;
                'Wash':
                    begin
                        if Input = 'IN' then
                            StyleMasterPORec.ModifyAll("Wash In Qty", LineTotal)
                        else
                            if Input = 'OUT' then
                                StyleMasterPORec.ModifyAll("Wash Out Qty", LineTotal);
                    end;
                'Cut':
                    begin
                        StyleMasterPORec.ModifyAll("Cut Out Qty", LineTotal);
                    end;
                'Emb':
                    begin
                        if Input = 'IN' then
                            StyleMasterPORec.ModifyAll("Emb In Qty", LineTotal)
                        else
                            if Input = 'OUT' then
                                StyleMasterPORec.ModifyAll("Emb Out Qty", LineTotal);
                    end;
                'Print':
                    begin
                        if Input = 'IN' then
                            StyleMasterPORec.ModifyAll("Print In Qty", LineTotal)
                        else
                            if Input = 'OUT' then
                                StyleMasterPORec.ModifyAll("print Out Qty", LineTotal);
                    end;
                'Fin':
                    begin
                        StyleMasterPORec.ModifyAll("Finish Qty", LineTotal);
                    end;
                'Ship':
                    begin
                        StyleMasterPORec.ModifyAll("Shipped Qty", LineTotal);
                    end;
            END;
        end;
    end;

    //Delete Master detail tables (Production)
    procedure Delete_Prod_Records(No: BigInteger; StyleNo: Code[20]; LotNo: Code[20]; Input: code[10]; Type: Text[10]; Type1: Option)
    var
        ProductionOutLineRec: Record ProductionOutLine;
        ProductionOutHeaderRec: Record ProductionOutHeader;
    begin

        ProductionOutLineRec.Reset();
        ProductionOutLineRec.SetRange("No.", No);
        ProductionOutLineRec.DeleteAll();

        ProductionOutHeaderRec.Reset();
        ProductionOutHeaderRec.SetRange("No.", No);
        ProductionOutHeaderRec.DeleteAll();

        Update_Sty_Master_PO(StyleNo, LotNo, Input, Type, Type1);

    end;

    procedure ChangeColor(OpList: Record "New Breakdown Op Line2"): Text[50]
    var
    begin
        if OpList.LineType = 'H' then
            exit('strongaccent');
    end;

    procedure ChangeColorAsso(OpList: Record "AssorColorSizeRatio"): Text[50]
    var
    begin
        if OpList."Colour Name" = '*' then
            exit('strongaccent');
    end;

    procedure ChangeColorSJC(OpList: Record SewingJobCreationLine3): Text[50]
    var
    begin
        if OpList."Colour Name" = '*' then
            exit('strongaccent')
        else
            if OpList."Record Type" = 'H1' then
                exit('Favorable');
    end;

    procedure ChangeColorSJC4(OpList: Record SewingJobCreationLine4): Text[50]
    var
    begin
        if OpList."Colour Name" = '*' then
            exit('strongaccent')
        else
            if OpList."Record Type" = 'H1' then
                exit('Favorable');
    end;

    procedure ChangeColorRatioCreation(OpList: Record RatioCreationLine): Text[50]
    var
    begin
        if (OpList."Record Type" = 'H') or (OpList."Record Type" = 'H1') then
            exit('strongaccent')
        else
            if OpList."Record Type" = 'B' then
                exit('Favorable');


    end;

    procedure ChangeColorCutCreation(OpList: Record CutCreationLine): Text[50]
    var
    begin
        // if (OpList."Record Type" = 'H') or (OpList."Record Type" = 'H1') then
        //     exit('strongaccent')
        // else
        //     if OpList."Record Type" = 'R' then
        //         exit('Ambiguous');

        if OpList."Cut No" = 0 then
            exit('strongaccent')
        else
            exit('Ambiguous');


    end;

    procedure ChangeColorManpoerBudget(OpList: Record FactoryManpowerBudgetLine): Text[50]
    var
    begin
        if (OpList."Type" = 1) or (OpList."Type" = 2) then
            exit('strongaccent')
    end;

    procedure ChangeColorAssoRatio(OpList: Record AssorColorSizeRatioView): Text[50]
    var
    begin
        if OpList."Colour Name" = '*' then
            exit('strongaccent');
    end;

    procedure ChangeColorAssoPrice(OpList: Record AssorColorSizeRatioPrice): Text[50]
    var
    begin
        if OpList."Colour Name" = '*' then
            exit('strongaccent');
    end;

    procedure ChangeColorAutoGen(OpList: Record "BOM Line AutoGen"): Text[50]
    var
    begin
        if OpList."Included in PO" = true then
            exit('StrongAccent');
    end;

    procedure ChangeHourlyProduction(OpList: Record "Hourly Production Lines"): Text[50]
    var
    begin
        if OpList."Factory No." = '' then
            exit('StrongAccent');
    end;

    procedure ChangeColorSewing(OpList: Record "ProductionOutLine"): Text[50]
    var
    begin
        if OpList."Colour Name" = '*' then
            exit('strongaccent');
    end;

    procedure ChangeColorBooking1(OpList: Record BuyerWiseOdrBookingAllBook): Text[50]
    var
    begin
        if OpList.Type = 'T' then
            exit('StrongAccent');
    end;

    procedure ChangeColorBooking3(OpList: Record BuyerWiseOrderBookinBalatoShip): Text[50]

    begin
        if OpList.Type = 'T' then
            exit('StrongAccent');
    end;

    procedure ChangeColorBooking2(OpList: Record BuyerWiseOrderBookinBalatoSew): Text[50]

    begin
        if OpList.Type = 'T' then
            exit('StrongAccent');
    end;


    procedure ChangeColorBooking4(OpList: Record BuyerWiseOrderBookinGRWiseBook): Text[50]

    begin
        if OpList.Type = 'T' then
            exit('StrongAccent');
    end;

    procedure Update_PI_PO_Items(PINo: Code[20])
    var
        PIPoItemDetailsRec: Record "PI Po Item Details";
        PIPoItemDetails1Rec: Record "PI Po Item Details";
        PIPoDetailsRec: Record "PI Po Details";
        PurchaseLineRec: Record "Purchase Line";
        ItemRec: Record Item;
    begin

        //Delete old records
        PIPoItemDetailsRec.Reset();
        PIPoItemDetailsRec.SetRange("PI No.", PINo);
        if PIPoItemDetailsRec.FindSet() then
            PIPoItemDetailsRec.DeleteAll();

        //Insert all items from PO
        PIPoDetailsRec.Reset();
        PIPoDetailsRec.SetRange("PI No.", PINo);

        if PIPoDetailsRec.FindSet() then begin

            repeat

                PurchaseLineRec.Reset();
                PurchaseLineRec.SetRange("Document No.", PIPoDetailsRec."PO No.");
                PurchaseLineRec.SetRange("Document Type", 1);

                if PurchaseLineRec.FindSet() then begin

                    repeat

                        PIPoItemDetails1Rec.Reset();
                        PIPoItemDetails1Rec.SetRange("PI No.", PINo);
                        PIPoItemDetails1Rec.SetRange("PO No.", PIPoDetailsRec."PO No.");
                        PIPoItemDetails1Rec.SetRange("Item No.", PurchaseLineRec."No.");

                        if PIPoItemDetails1Rec.FindSet() then begin
                            PIPoItemDetails1Rec.Qty := PIPoItemDetails1Rec.Qty + PurchaseLineRec.Quantity;
                            PIPoItemDetails1Rec.Value := PIPoItemDetails1Rec.Value + PurchaseLineRec.Amount;
                            PIPoItemDetails1Rec.Modify();
                        end
                        else begin
                            ItemRec.Reset();
                            ItemRec.SetRange("No.", PurchaseLineRec."No.");
                            ItemRec.FindSet();

                            PIPoItemDetailsRec.Init();
                            PIPoItemDetailsRec."PI No." := PINo;
                            PIPoItemDetailsRec."PO No." := PIPoDetailsRec."PO No.";
                            PIPoItemDetailsRec."Item No." := PurchaseLineRec."No.";
                            PIPoItemDetailsRec."Item Name" := PurchaseLineRec.Description;
                            PIPoItemDetailsRec."UOM Code" := PurchaseLineRec."Unit of Measure";
                            PIPoItemDetailsRec."UOM" := PurchaseLineRec."Unit of Measure Code";
                            PIPoItemDetailsRec."Main Category No." := ItemRec."Main Category No.";
                            PIPoItemDetailsRec."Main Category Name" := ItemRec."Main Category Name";
                            PIPoItemDetailsRec.Qty := PurchaseLineRec.Quantity;
                            PIPoItemDetailsRec."Unit Price" := PurchaseLineRec."Direct Unit Cost";
                            PIPoItemDetailsRec.Value := PurchaseLineRec.Amount;
                            PIPoItemDetailsRec.Insert();
                        end;

                    until PurchaseLineRec.Next() = 0;

                end;

            until PIPoDetailsRec.Next() = 0;

        end;

    end;

    procedure CalQty(ContractNoPara: Code[20])
    var
        "Contract/LCMasterRec": Record "Contract/LCMaster";
        "Contract/LCStyleRec": Record "Contract/LCStyle";
        StyleMasterPORFec: Record "Style Master PO";
        TotalQty: BigInteger;
        AutoValue: Decimal;
    begin

        //Get total order qty
        "Contract/LCStyleRec".Reset();
        "Contract/LCStyleRec".SetRange("No.", ContractNoPara);

        if "Contract/LCStyleRec".FindSet() then begin
            repeat
                TotalQty += "Contract/LCStyleRec".Qty;

                //Get Style PO Qty Value
                StyleMasterPORFec.Reset();
                StyleMasterPORFec.SetCurrentKey("Style No.");
                StyleMasterPORFec.SetRange("Style No.", "Contract/LCStyleRec"."Style No.");

                if StyleMasterPORFec.FindSet() then begin
                    repeat
                        AutoValue += StyleMasterPORFec.Qty * StyleMasterPORFec."Unit Price";
                    until StyleMasterPORFec.Next() = 0;
                end;
            until "Contract/LCStyleRec".Next() = 0;
        end;


        //Update Qty;
        "Contract/LCMasterRec".Reset();
        "Contract/LCMasterRec".SetRange("No.", ContractNoPara);
        "Contract/LCMasterRec".FindSet();
        "Contract/LCMasterRec"."Auto Calculate Value" := AutoValue;
        "Contract/LCMasterRec"."Contract Value" := AutoValue;
        "Contract/LCMasterRec"."Quantity (Pcs)" := TotalQty;
        "Contract/LCMasterRec".Modify();

    end;

    procedure CalQtyB2B(B2BNoPara: Code[20])
    var
        B2BLCMasterRec: Record B2BLCMaster;
        B2BLCPIRec: Record B2BLCPI;
        TotalValue: Decimal;
    begin

        //Get total order qty
        B2BLCPIRec.Reset();
        B2BLCPIRec.SetRange("B2BNo.", B2BNoPara);

        if B2BLCPIRec.FindSet() then begin
            repeat
                TotalValue += B2BLCPIRec."PI Value";
            until B2BLCPIRec.Next() = 0;
        end;


        //Update Qty;
        B2BLCMasterRec.Reset();
        B2BLCMasterRec.SetRange("No.", B2BNoPara);
        B2BLCMasterRec.FindSet();
        B2BLCMasterRec."B2B LC Value" := TotalValue;
        B2BLCMasterRec.Modify();

    end;


    procedure CalQtyBankRef(BankRefNoPara: Code[20])
    var
        BankRefHeaderRec: Record BankReferenceHeader;
        BankRefInvRec: Record BankReferenceInvoice;
        TotalQty: Decimal;
        AutoValue: Decimal;
    begin

        //Get total invoice value
        BankRefInvRec.Reset();
        BankRefInvRec.SetRange("No.", BankRefNoPara);

        if BankRefInvRec.FindSet() then begin
            repeat
                TotalQty += BankRefInvRec."Ship Value";
            until BankRefInvRec.Next() = 0;
        end;


        //Update Qty;
        BankRefHeaderRec.Reset();
        BankRefHeaderRec.SetRange("No.", BankRefNoPara);
        BankRefHeaderRec.FindSet();
        BankRefHeaderRec.Total := TotalQty;
        BankRefHeaderRec.Modify();

    end;


    procedure CalGRNBalance(GITNoPara: Code[20])
    var
        GITBaseonPIRec: Record GITBaseonPI;
        GITBaseonPILineRec: Record GITBaseonPILine;
        TotalGRNValue: Decimal;
        TotalReqValue: Decimal;
    begin

        //Get total order qty
        GITBaseonPILineRec.Reset();
        GITBaseonPILineRec.SetRange("GITPINo.", GITNoPara);

        if GITBaseonPILineRec.FindSet() then begin
            repeat
                TotalReqValue += GITBaseonPILineRec."Total Value";
                TotalGRNValue += GITBaseonPILineRec."Rec. Value";
            until GITBaseonPILineRec.Next() = 0;
        end;


        //Update Qty;
        GITBaseonPIRec.Reset();
        GITBaseonPIRec.SetRange("GITPINo.", GITNoPara);
        GITBaseonPIRec.FindSet();
        GITBaseonPIRec."GRN Balance" := TotalGRNValue - TotalReqValue;
        GITBaseonPIRec.Modify();

    end;

    procedure Add_GIT_PI_Items(GITPINo: Code[20])
    var
        PIPOItemsRec: Record "PI Po Item Details";
        GITPIPIRec: Record "GITPIPI";
        GITBaseonPILineRec: Record GITBaseonPILine;
        PurReceiptRec: Record "Purch. Rcpt. Line";
        PIHeaderRec: Record "PI Details Header";
        ItemRec: Record Item;
        LineNo: Integer;
        ReqTotal: Decimal;
        GRNTotal: Decimal;
    begin

        //Delete old records
        GITBaseonPILineRec.Reset();
        GITBaseonPILineRec.SetRange("GITPINo.", GITPINo);
        GITBaseonPILineRec.DeleteAll();


        //Get Max Lineno
        GITBaseonPILineRec.Reset();
        GITBaseonPILineRec.SetRange("GITPINo.", GITPINo);

        if GITBaseonPILineRec.FindLast() then
            LineNo := GITBaseonPILineRec."Line No";


        //get all PI Nos
        GITPIPIRec.Reset();
        GITPIPIRec.SetRange("GITPINo.", GITPINo);

        if GITPIPIRec.FindSet() then begin
            repeat

                PIPOItemsRec.Reset();
                PIPOItemsRec.SetRange("PI No.", GITPIPIRec."PI Sys No.");

                if PIPOItemsRec.FindSet() then begin
                    repeat

                        LineNo += 1;
                        //Insert to the GIT Items table
                        GITBaseonPILineRec.Init();
                        GITBaseonPILineRec."GITPINo." := GITPINo;
                        GITBaseonPILineRec."Line No" := LineNo;
                        GITBaseonPILineRec."Created Date" := Today;
                        GITBaseonPILineRec."Created User" := UserId;

                        PIHeaderRec.Reset();
                        PIHeaderRec.SetRange("PI No", GITPIPIRec."PI No.");

                        if PIHeaderRec.FindSet() then begin
                            GITBaseonPILineRec."Currency Name" := PIHeaderRec."Currency";
                            GITBaseonPILineRec."Currency No." := PIHeaderRec."Currency Code";
                        end;

                        GITBaseonPILineRec."Item No." := PIPOItemsRec."Item No.";
                        GITBaseonPILineRec."Item Name" := PIPOItemsRec."Item Name";
                        GITBaseonPILineRec.PINo := GITPIPIRec."PI No.";

                        //GetMain category
                        ItemRec.Reset();
                        ItemRec.SetRange("No.", PIPOItemsRec."Item No.");
                        ItemRec.FindSet();
                        GITBaseonPILineRec."Main Category No." := ItemRec."Main Category No.";
                        GITBaseonPILineRec."Main Category Name" := ItemRec."Main Category Name";

                        //Get GRn Quantity
                        PurReceiptRec.Reset();
                        PurReceiptRec.SetRange("Order No.", PIPOItemsRec."PO No.");
                        PurReceiptRec.SetRange("No.", PIPOItemsRec."Item No.");
                        if PurReceiptRec.FindSet() then
                            GITBaseonPILineRec."GRN Qty" := PurReceiptRec.Quantity;

                        GITBaseonPILineRec."Rec. Value" := GITBaseonPILineRec."GRN Qty" * PurReceiptRec."Unit Cost";
                        GRNTotal += GITBaseonPILineRec."Rec. Value";

                        GITBaseonPILineRec."Req Qty" := PIPOItemsRec.Qty;
                        GITBaseonPILineRec."Total Value" := PIPOItemsRec.Value;
                        ReqTotal += PIPOItemsRec.Value;
                        GITBaseonPILineRec."Unit No." := PIPOItemsRec."UOM Code";
                        GITBaseonPILineRec."Unit Name" := PIPOItemsRec.UOM;
                        GITBaseonPILineRec."Unit Price" := PIPOItemsRec."Unit Price";
                        GITBaseonPILineRec.Insert();

                    until PIPOItemsRec.Next() = 0;
                end;
            until GITPIPIRec.Next() = 0;
        end;
    end;

    procedure Add_ACC_INV_Items(Type: Code[20]; AccNo: Code[20])
    var
        GITBaseonPILineRec: Record GITBaseonPILine;
        GITBaseonPIRec: Record GITBaseonPI;
        GITBaseonLCLineRec: Record GITBaseonLCLine;
        GITBaseonLCRec: Record GITBaseonLC;
        AcceptanceLineRec: Record AcceptanceLine;
        AcceptanceInv2Rec: Record AcceptanceInv2;
        ItemRec: Record Item;
        SizeRec: Record SizeRange;
        ArtcleRec: Record Article;
        DimensionRec: Record DimensionWidth;
        LineNo: Integer;
        GITPINo: Code[20];
        GITLCNo: Code[20];
    begin

        //Delete old records
        AcceptanceLineRec.Reset();
        AcceptanceLineRec.SetRange("AccNo.", AccNo);
        AcceptanceLineRec.DeleteAll();

        LineNo := 0;

        if Type = 'TT OR CASH' then begin

            AcceptanceInv2Rec.Reset();
            AcceptanceInv2Rec.SetRange("AccNo.", AccNo);

            if AcceptanceInv2Rec.FindSet() then begin
                repeat

                    //get GITNO for the invoice no
                    GITBaseonPIRec.Reset();
                    GITBaseonPIRec.SetRange("Invoice No", AcceptanceInv2Rec."Inv No.");
                    GITBaseonPIRec.FindSet();
                    GITPINo := GITBaseonPIRec."GITPINo.";

                    GITBaseonPILineRec.Reset();
                    GITBaseonPILineRec.SetRange("GITPINo.", GITPINo);

                    if GITBaseonPILineRec.FindSet() then begin
                        repeat

                            LineNo += 1;
                            //Insert to the GIT Items table
                            AcceptanceLineRec.Init();
                            AcceptanceLineRec."AccNo." := AccNo;
                            AcceptanceLineRec."Line No" := LineNo;
                            AcceptanceLineRec."Inv No" := AcceptanceInv2Rec."Inv No.";
                            AcceptanceLineRec."PI No" := GITBaseonPILineRec.PINo;
                            AcceptanceLineRec."Item No." := GITBaseonPILineRec."Item No.";
                            AcceptanceLineRec."Item Name" := GITBaseonPILineRec."Item Name";
                            AcceptanceLineRec."Unit No." := GITBaseonPILineRec."Unit No.";
                            AcceptanceLineRec."Unit Name" := GITBaseonPILineRec."Unit Name";

                            //Get Item details
                            ItemRec.Reset();
                            ItemRec.SetRange("No.", GITBaseonPILineRec."Item No.");
                            if ItemRec.FindSet() then
                                AcceptanceLineRec.Color := ItemRec."Color Name";

                            ArtcleRec.Reset();
                            ArtcleRec.SetRange("No.", ItemRec."Article No.");
                            if ArtcleRec.FindSet() then
                                AcceptanceLineRec."Article " := ArtcleRec.Article;

                            SizeRec.Reset();
                            SizeRec.SetRange("No.", ItemRec."Size Range No.");
                            if SizeRec.FindSet() then
                                AcceptanceLineRec.Size := SizeRec."Size Range";

                            DimensionRec.Reset();
                            DimensionRec.SetRange("No.", ItemRec."Dimension Width No.");
                            if DimensionRec.FindSet() then
                                AcceptanceLineRec.Dimension := DimensionRec."Dimension Width";


                            AcceptanceLineRec."Qty" := GITBaseonPILineRec."Req Qty";
                            AcceptanceLineRec."Unit Price" := GITBaseonPILineRec."Unit Price";
                            AcceptanceLineRec."Total Value" := GITBaseonPILineRec."Total Value";
                            AcceptanceLineRec."GRN Qty" := GITBaseonPILineRec."GRN Qty";
                            AcceptanceLineRec."Rec. Value" := GITBaseonPILineRec."Rec. Value";
                            AcceptanceLineRec."Created Date" := Today;
                            AcceptanceLineRec."Created User" := UserId;
                            AcceptanceLineRec.Insert();

                        until GITBaseonPILineRec.Next() = 0;
                    end;
                until AcceptanceInv2Rec.Next() = 0;
            end;
        end
        else begin
            if Type = 'BASED ON B2B LC' then begin

                AcceptanceInv2Rec.Reset();
                AcceptanceInv2Rec.SetRange("AccNo.", AccNo);

                if AcceptanceInv2Rec.FindSet() then begin
                    repeat
                        //get GITNO for the invoice no
                        GITBaseonLCRec.Reset();
                        GITBaseonLCRec.SetRange("Invoice No", AcceptanceInv2Rec."Inv No.");
                        GITBaseonLCRec.FindSet();
                        GITLCNo := GITBaseonLCRec."GITLCNo.";

                        GITBaseonLCLineRec.Reset();
                        GITBaseonLCLineRec.SetRange("GITLCNo.", GITLCNo);

                        if GITBaseonLCLineRec.FindSet() then begin
                            repeat

                                LineNo += 1;
                                //Insert to the GIT Items table
                                AcceptanceLineRec.Init();
                                AcceptanceLineRec."AccNo." := AccNo;
                                AcceptanceLineRec."Line No" := LineNo;
                                AcceptanceLineRec."Inv No" := AcceptanceInv2Rec."Inv No.";
                                AcceptanceLineRec."PI No" := GITBaseonLCLineRec.PINo;
                                AcceptanceLineRec."Item No." := GITBaseonLCLineRec."Item No.";
                                AcceptanceLineRec."Item Name" := GITBaseonLCLineRec."Item Name";
                                AcceptanceLineRec."Unit No." := GITBaseonLCLineRec."Unit No.";
                                AcceptanceLineRec."Unit Name" := GITBaseonLCLineRec."Unit Name";

                                ItemRec.Reset();
                                ItemRec.SetRange("No.", GITBaseonPILineRec."Item No.");
                                if ItemRec.FindSet() then
                                    AcceptanceLineRec.Color := ItemRec."Color Name";

                                ArtcleRec.Reset();
                                ArtcleRec.SetRange("No.", ItemRec."Article No.");
                                if ArtcleRec.FindSet() then
                                    AcceptanceLineRec."Article " := ArtcleRec.Article;

                                SizeRec.Reset();
                                SizeRec.SetRange("No.", ItemRec."Size Range No.");
                                if SizeRec.FindSet() then
                                    AcceptanceLineRec.Size := SizeRec."Size Range";

                                DimensionRec.Reset();
                                DimensionRec.SetRange("No.", ItemRec."Dimension Width No.");
                                if DimensionRec.FindSet() then
                                    AcceptanceLineRec.Dimension := DimensionRec."Dimension Width";

                                AcceptanceLineRec."Qty" := GITBaseonLCLineRec."Req Qty";
                                AcceptanceLineRec."Unit Price" := GITBaseonLCLineRec."Unit Price";
                                AcceptanceLineRec."Total Value" := GITBaseonLCLineRec."Total Value";
                                AcceptanceLineRec."GRN Qty" := GITBaseonLCLineRec."GRN Qty";
                                AcceptanceLineRec."Rec. Value" := GITBaseonLCLineRec."Rec. Value";
                                AcceptanceLineRec."Created Date" := Today;
                                AcceptanceLineRec."Created User" := UserId;
                                AcceptanceLineRec.Insert();

                            until GITBaseonLCLineRec.Next() = 0;
                        end;
                    until AcceptanceInv2Rec.Next() = 0;
                end;
            end
        end;
    end;

    procedure Generate_Line1(SJCNo: code[20]; StyleNo: Code[20]; StyleName: text[50])
    var
        SewJobCreatLine2Rec: Record SewingJobCreationLine2;
        ProdPlanDetRec: Record "NavApp Prod Plans Details";
        StyleMasterPORec: Record "Style Master PO";
        WorkCenterRec: Record "Work Center";
        WastageRec: Record Wastage;
        po: Text[50];
        resoureceline: Code[20];
        EndDate: Date;
        AllocatedQty: BigInteger;
        Waistage: Decimal;
        MaxTarget: BigInteger;
        no: Integer;
    begin

        //Delete old records
        SewJobCreatLine2Rec.Reset();
        SewJobCreatLine2Rec.SetRange("SJCNo.", SJCNo);
        SewJobCreatLine2Rec.DeleteAll();

        ProdPlanDetRec.Reset();
        ProdPlanDetRec.SetCurrentKey("PO No.", "Resource No.");
        ProdPlanDetRec.SetRange("Style No.", StyleNo);
        ProdPlanDetRec.SetAscending("PO No.", true);

        if ProdPlanDetRec.FindSet() then begin
            repeat

                //  no := ProdPlanDetRec."No.";
                if (po <> ProdPlanDetRec."PO No.") or (resoureceline <> ProdPlanDetRec."Resource No.") then begin

                    //Insert
                    AllocatedQty := ProdPlanDetRec.Qty;
                    MaxTarget := ProdPlanDetRec.Target;

                    StyleMasterPORec.Reset();
                    StyleMasterPORec.SetRange("Style No.", StyleNo);
                    StyleMasterPORec.SetRange("Lot No.", ProdPlanDetRec."Lot No.");

                    if StyleMasterPORec.FindSet() then begin

                        //Get the wastage from wastage table
                        WastageRec.Reset();
                        WastageRec.SetFilter("Start Qty", '<=%1', StyleMasterPORec.Qty);
                        WastageRec.SetFilter("Finish Qty", '>=%1', StyleMasterPORec.Qty);

                        if WastageRec.FindSet() then
                            Waistage := WastageRec.Percentage;
                    end;

                    //Get Resource line name
                    WorkCenterRec.Reset();
                    WorkCenterRec.SetRange("No.", ProdPlanDetRec."Resource No.");

                    SewJobCreatLine2Rec.Init();
                    SewJobCreatLine2Rec."SJCNo." := SJCNo;
                    SewJobCreatLine2Rec."Style No." := StyleNo;
                    SewJobCreatLine2Rec."Style Name" := StyleName;
                    SewJobCreatLine2Rec."Lot No." := ProdPlanDetRec."Lot No.";
                    SewJobCreatLine2Rec."PO No." := ProdPlanDetRec."PO No.";
                    SewJobCreatLine2Rec."Line No." := ProdPlanDetRec."Resource No.";

                    if WorkCenterRec.FindSet() then
                        SewJobCreatLine2Rec."Line Name" := WorkCenterRec.Name;

                    SewJobCreatLine2Rec."Start Date" := ProdPlanDetRec.PlanDate;
                    SewJobCreatLine2Rec."Extra Cut %" := Waistage;
                    SewJobCreatLine2Rec.Insert();

                end
                else begin

                    AllocatedQty += ProdPlanDetRec.Qty;
                    if MaxTarget < ProdPlanDetRec.Target then
                        MaxTarget := ProdPlanDetRec.Target;

                    SewJobCreatLine2Rec.Reset();
                    SewJobCreatLine2Rec.SetRange("SJCNo.", SJCNo);
                    SewJobCreatLine2Rec.SetRange("Style No.", StyleNo);
                    SewJobCreatLine2Rec.SetRange("PO No.", ProdPlanDetRec."PO No.");
                    SewJobCreatLine2Rec.SetRange("Line No.", ProdPlanDetRec."Resource No.");

                    if SewJobCreatLine2Rec.FindSet() then begin
                        SewJobCreatLine2Rec."End Date" := ProdPlanDetRec.PlanDate;
                        SewJobCreatLine2Rec."Allocated Qty" := AllocatedQty;
                        SewJobCreatLine2Rec."Total Qty" := AllocatedQty; //+ (AllocatedQty * Waistage) / 100;
                        SewJobCreatLine2Rec."Day Max Target" := MaxTarget;
                        SewJobCreatLine2Rec.Modify();
                    end;

                end;

                po := ProdPlanDetRec."PO No.";
                resoureceline := ProdPlanDetRec."Resource No.";

            until ProdPlanDetRec.Next() = 0;
        end;

    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnBeforePurchOrderLineInsert', '', true, true)]
    local procedure UpdatePOLine(VAR PurchOrderHeader: Record "Purchase Header"; VAR PurchOrderLine: Record "Purchase Line"; VAR ReqLine: Record "Requisition Line"; CommitIsSuppressed: Boolean)

    begin
        PurchOrderLine.StyleNo := ReqLine.StyleNo;
        PurchOrderLine.StyleName := ReqLine.StyleName;
        PurchOrderLine.PONo := ReqLine.PONo;
        PurchOrderLine.Lot := ReqLine.Lot;
        PurchOrderLine.EntryType := ReqLine.EntryType;
        PurchOrderLine."Shortcut Dimension 1 Code" := ReqLine."Shortcut Dimension 1 Code";
        PurchOrderLine."CP Req No" := ReqLine."CP Req Code";
        PurchOrderLine."Buyer Name" := ReqLine."Buyer Name";
        PurchOrderLine."Buyer No." := ReqLine."Buyer No.";
        // PurchOrderLine."Secondary UserID" := ReqLine."Secondary UserID";

        PurchOrderHeader.EntryType := ReqLine.EntryType;

    end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnAfterInsertPurchOrderLine', '', true, true)]
    // local procedure InsertLOTNo(VAR PurchOrderLine: Record "Purchase Line"; VAR NextLineNo: Integer; VAR RequisitionLine: Record "Requisition Line")

    // begin

    //     Message(PurchOrderLine."No.");
    // end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchRcptLineInsert', '', true, true)]
    local procedure UpdateGRNLine(VAR PurchRcptLine: Record "Purch. Rcpt. Line"; VAR PurchRcptHeader: Record "Purch. Rcpt. Header"; VAR PurchLine: Record "Purchase Line"; CommitIsSupressed: Boolean)

    begin
        PurchRcptLine.StyleNo := PurchLine.StyleNo;
        PurchRcptLine.StyleName := PurchLine.StyleName;
        PurchRcptLine.PONo := PurchLine.PONo;
        PurchRcptLine.Lot := PurchLine.Lot;
        PurchRcptLine.EntryType := PurchLine.EntryType;
        PurchRcptLine."Shortcut Dimension 1 Code" := PurchLine."Shortcut Dimension 1 Code";
        PurchRcptLine."CP Req No" := PurchLine."CP Req No";
        PurchRcptLine."Buyer Name" := PurchLine."Buyer Name";
        PurchRcptLine."Buyer No." := PurchLine."Buyer No.";
        // PurchRcptLine."Secondary UserID" := PurchLine."Secondary UserID";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvLineInsert', '', true, true)]
    local procedure UpdatPurchInvoiceLine(VAR PurchInvLine: Record "Purch. Inv. Line"; VAR PurchInvHeader: Record "Purch. Inv. Header"; VAR PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean)

    begin
        PurchInvLine.StyleNo := PurchaseLine.StyleNo;
        PurchInvLine.StyleName := PurchaseLine.StyleName;
        PurchInvLine.PONo := PurchaseLine.PONo;
        PurchInvLine.Lot := PurchaseLine.Lot;
        PurchInvLine.EntryType := PurchaseLine.EntryType;
        // PurchInvLine."Secondary UserID" := PurchaseLine."Secondary UserID";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptHeaderInsert', '', true, true)]
    local procedure UpdatSalesShipmentHeader(VAR SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)

    begin
        SalesShptHeader."Style No" := SalesHeader."Style No";
        SalesShptHeader."Style Name" := SalesHeader."Style Name";
        SalesShptHeader."PO No" := SalesHeader."PO No";
        SalesShptHeader.Lot := SalesHeader.Lot;
        SalesShptHeader.EntryType := SalesHeader.EntryType;
        SalesShptHeader."Secondary UserID" := SalesHeader."Secondary UserID";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', true, true)]
    local procedure UpdatSalesInvoiceHeader(VAR SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)

    begin
        SalesInvHeader."Style No" := SalesHeader."Style No";
        SalesInvHeader."Style Name" := SalesHeader."Style Name";
        SalesInvHeader."PO No" := SalesHeader."PO No";
        SalesInvHeader.Lot := SalesHeader.Lot;
        SalesInvHeader.EntryType := SalesHeader.EntryType;
        SalesInvHeader."Secondary UserID" := SalesHeader."Secondary UserID";

    end;



    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")

    begin
        GenJournalLine."LC/Contract No." := Purchaseheader."LC/Contract No.";
    end;



    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GLEntry: Record "G/L Entry"; var GenJournalLine: Record "Gen. Journal Line")

    begin
        GLEntry."LC/Contract No." := GenJournalLine."LC/Contract No.";
    end;



    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"System Initialization", 'OnAfterLogin', '', true, true)]
    // local procedure LogIn()
    // var
    //     LoginRec: Page "Login Card";
    // begin
    //     Clear(LoginRec);
    //     LoginRec.LookupMode(true);
    //     LoginRec.Run();
    // end;


    procedure CreateProdOrder(PassSoNo: Code[20]; OrderType: Text[20]) ProOrderNo: Code[20]
    var
        ManufacSetup: Record "Manufacturing Setup";
        ProdOrder: Record "Production Order";
        ProdOrderCreate: Record "Production Order";
        SalesHedd: Record "Sales Header";
        NoserMangement: Codeunit NoSeriesManagement;
        StyleRec: Record "Style Master";
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
    //Window: Dialog;
    //TextCon1: TextConst ENU = 'Creating Production Order ####1';

    begin
        //Window.Open(TextCon1);

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            LoginSessionsRec.Reset();
            LoginSessionsRec.SetRange(SessionID, SessionId());
            LoginSessionsRec.FindSet();
        end;


        ManufacSetup.Get();
        ManufacSetup.TestField("Firm Planned Order Nos.");
        SalesHedd.get(SalesHedd."Document Type"::Order, PassSoNo);
        ProdOrder.LockTable();

        ProdOrder.Init();
        ProdOrder.Status := ProdOrder.Status::"Firm Planned";
        ProdOrder."No." := NoserMangement.GetNextNo(ManufacSetup."Firm Planned Order Nos.", WorkDate(), true);
        ProdOrder."Secondary UserID" := LoginSessionsRec."Secondary UserID";
        ProdOrder.Insert(true);

        // Window.Update(1, ProdOrder."No.");
        // Sleep(100);
        ProdOrder.Validate("Source Type", ProdOrder."Source Type"::"Sales Header");
        ProdOrder.Validate(BuyerCode, SalesHedd."Sell-to Customer No.");
        ProdOrder."Style Name" := SalesHedd."Style Name";
        ProdOrder."Style No." := SalesHedd."Style No";
        ProdOrder.PO := SalesHedd."PO No";
        //ProdOrder."Style Name" := SalesHedd."Style Name";

        StyleRec.Reset();
        StyleRec.SetRange("No.", SalesHedd."Style No");
        StyleRec.FindSet();
        ProdOrder."Gament Type" := StyleRec."Garment Type Name";
        ProdOrder."Gament Type Code" := StyleRec."Garment Type No.";

        case OrderType of
            'Bulk':
                ProdOrder."Prod Order Type" := ProdOrder."Prod Order Type"::Bulk;
            'Samples':
                ProdOrder."Prod Order Type" := ProdOrder."Prod Order Type"::Samples;
            'Washing':
                ProdOrder."Prod Order Type" := ProdOrder."Prod Order Type"::Washing;
        end;

        ProdOrder.Validate("Source No.", SalesHedd."No.");

        ProdOrder.Modify();
        Commit();

        ProdOrderCreate.Reset();
        ProdOrderCreate.SetRange(Status, ProdOrder.Status);
        ProdOrderCreate.SetRange("No.", ProdOrder."No.");
        REPORT.RUNMODAL(REPORT::"Refresh Production Order", FALSE, FALSE, ProdOrderCreate);
        COMMIT;

        exit(ProdOrder."No.");
        //Window.Close();
    end;


    procedure Update_Runtime(StyleName: Text[50]; StyleNo: Code[20]; Department: code[20])
    var
        ProdOutHeaderRec: Record ProductionOutHeader;
        NewBrDownHeaderRec: Record "New Breakdown";
        NewBrDownLineRec: Record "New Breakdown Op Line2";
        RouterRec: Record "Routing Header";
        RouterLineRec: Record "Routing Line";
        NewBrNo: Code[20];
        TotalSMV: Decimal;
        TotalRuntime: Decimal;
    begin

        //Get Bulk Router
        RouterRec.Reset();
        RouterRec.SetFilter("Bulk Router", '=%1', true);
        if not RouterRec.FindSet() then
            Error('cannot find a router for the Bulk Process.');


        //Get New Br no
        NewBrDownHeaderRec.Reset();
        NewBrDownHeaderRec.SetRange("Style No.", StyleNo);
        if NewBrDownHeaderRec.FindSet() then
            NewBrNo := NewBrDownHeaderRec."No."
        else
            Error('cannot find new breakdown details.');


        //Get total SMV for the department
        TotalSMV := 0;
        NewBrDownLineRec.Reset();
        NewBrDownLineRec.SetRange("No.", NewBrNo);
        NewBrDownLineRec.SetRange("Department Name", Department);
        if NewBrDownLineRec.FindSet() then
            repeat
                TotalSMV += NewBrDownLineRec.SMV;
            until NewBrDownLineRec.Next() = 0;


        //Get Total Runtime 
        TotalRuntime := 0;
        ProdOutHeaderRec.Reset();

        case Department of
            'CUTTING':
                begin
                    ProdOutHeaderRec.SetFilter(Type, '=%1', 0);
                    ProdOutHeaderRec.SetRange("Style No.", StyleNo);
                end;
            'SEWING':
                begin
                    ProdOutHeaderRec.SetFilter(Type, '=%1', 1);
                    ProdOutHeaderRec.SetRange("Out Style No.", StyleNo);
                end;
            'WASHING':
                begin
                    ProdOutHeaderRec.SetFilter(Type, '=%1', 2);
                    ProdOutHeaderRec.SetRange("Style No.", StyleNo);
                end;
            'FINISHING':
                begin
                    ProdOutHeaderRec.SetFilter(Type, '=%1', 6);
                    ProdOutHeaderRec.SetRange("Style No.", StyleNo);
                end;
        end;

        if ProdOutHeaderRec.FindSet() then begin
            repeat
                TotalRuntime += ProdOutHeaderRec."Output Qty" * TotalSMV;
            until ProdOutHeaderRec.Next() = 0;
        end
        else
            Error('Cannot find Output details for Style : %1', StyleName);

        if TotalRuntime = 0 then
            Error('Total runtime for this style is zero.');

        //Assign to the router line runtime for the dapertment
        RouterLineRec.Reset();
        RouterLineRec.SetRange("Routing No.", RouterRec."No.");
        RouterLineRec.SetRange(Description, Department);
        if RouterLineRec.FindSet() then begin
            RouterLineRec."Run Time" := TotalRuntime;
            RouterLineRec.Modify();
        end
        else
            Error('Cannot find router line for the department %1 :', Department);

    end;


    [EventSubscriber(ObjectType::Report, 5405, 'OnBeforeInsertItemJnlLine', '', true, true)]
    local procedure UpdateConsupjnal(var ItemJournalLine: Record "Item Journal Line"; ProdOrderComponent: Record "Prod. Order Component")
    var
        ProdOrdRec: Record "Production Order";
    begin
        ProdOrdRec.Get(ProdOrderComponent.Status, ProdOrderComponent."Prod. Order No.");
        ItemJournalLine."Style No." := ProdOrdRec."Style No.";
        ItemJournalLine."Style Name" := ProdOrdRec."Style Name";
    end;


    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure UpdateItemLedEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")

    begin
        NewItemLedgEntry."Style No." := ItemJournalLine."Style No.";
        NewItemLedgEntry."Style Name" := ItemJournalLine."Style Name";
        NewItemLedgEntry."CP Req No" := ItemJournalLine."CP Req No";
    end;


    [EventSubscriber(ObjectType::Table, 83, 'OnAfterCopyItemJnlLineFromPurchLine', '', true, true)]
    local procedure OnAfterCopyItemJnlLineFromPurchLine(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")

    begin
        ItemJnlLine."CP Req No" := PurchLine."CP Req No";
    end;


    [EventSubscriber(ObjectType::Table, 5746, 'OnAfterCopyFromTransferHeader', '', true, true)]
    local procedure UpdateTransRec(var TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferReceiptHeader."Style No." := TransferHeader."Style No.";
        TransferReceiptHeader."Style Name" := TransferHeader."Style Name";
        TransferReceiptHeader.PO := TransferHeader.PO;
        TransferReceiptHeader."Secondary UserID" := TransferHeader."Secondary UserID";
    end;


    [EventSubscriber(ObjectType::Table, 5744, 'OnAfterCopyFromTransferHeader', '', true, true)]
    local procedure UpdateShipRec(var TransferShipmentHeader: Record "Transfer Shipment Header"; TransferHeader: Record "Transfer Header")
    begin
        TransferShipmentHeader."Style No." := TransferHeader."Style No.";
        TransferShipmentHeader."Style Name" := TransferHeader."Style Name";
        TransferShipmentHeader.PO := TransferHeader.PO;
        TransferShipmentHeader."Secondary UserID" := TransferHeader."Secondary UserID";
    end;


}
