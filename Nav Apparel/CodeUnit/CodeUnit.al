codeunit 71012752 NavAppCodeUnit
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
        if (OpList."Record Type" = 'H') or (OpList."Record Type" = 'H1') then
            exit('strongaccent')
        else
            if OpList."Record Type" = 'R' then
                exit('Favorable');


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

    procedure Update_PI_PO_Items(PINo: Code[20])
    var
        PIPoItemDetailsRec: Record "PI Po Item Details";
        PIPoDetailsRec: Record "PI Po Details";
        PurchaseLineRec: Record "Purchase Line";
    begin

        //Delete old records
        PIPoItemDetailsRec.Reset();
        PIPoItemDetailsRec.SetRange("PI No.", PINo);
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
                        PIPoItemDetailsRec.Init();
                        PIPoItemDetailsRec."PI No." := PINo;
                        PIPoItemDetailsRec."PO No." := PIPoDetailsRec."PO No.";
                        PIPoItemDetailsRec."Item No." := PurchaseLineRec."No.";
                        PIPoItemDetailsRec."Item Name" := PurchaseLineRec.Description;
                        PIPoItemDetailsRec."UOM Code" := PurchaseLineRec."Unit of Measure";
                        PIPoItemDetailsRec."UOM" := PurchaseLineRec."Unit of Measure Code";
                        PIPoItemDetailsRec.Qty := PurchaseLineRec.Quantity;
                        PIPoItemDetailsRec."Unit Price" := PurchaseLineRec."Direct Unit Cost";
                        PIPoItemDetailsRec.Value := PurchaseLineRec.Amount;
                        PIPoItemDetailsRec.Insert();

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
                        SewJobCreatLine2Rec."Total Qty" := AllocatedQty + (AllocatedQty * Waistage) / 100;
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
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePurchInvLineInsert', '', true, true)]
    local procedure UpdatPurchInvoiceLine(VAR PurchInvLine: Record "Purch. Inv. Line"; VAR PurchInvHeader: Record "Purch. Inv. Header"; VAR PurchaseLine: Record "Purchase Line"; CommitIsSupressed: Boolean)

    begin
        PurchInvLine.StyleNo := PurchaseLine.StyleNo;
        PurchInvLine.StyleName := PurchaseLine.StyleName;
        PurchInvLine.PONo := PurchaseLine.PONo;
        PurchInvLine.Lot := PurchaseLine.Lot;
        PurchInvLine.EntryType := PurchaseLine.EntryType;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptHeaderInsert', '', true, true)]
    local procedure UpdatSalesShipmentHeader(VAR SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)

    begin
        SalesShptHeader."Style No" := SalesHeader."Style No";
        SalesShptHeader."Style Name" := SalesHeader."Style Name";
        SalesShptHeader.EntryType := SalesHeader.EntryType;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvHeaderInsert', '', true, true)]
    local procedure UpdatSalesInvoiceHeader(VAR SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)

    begin
        SalesInvHeader."Style No" := SalesHeader."Style No";
        SalesInvHeader."Style Name" := SalesHeader."Style Name";
        SalesInvHeader.EntryType := SalesHeader.EntryType;
    end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::LogInManagement, 'OnAfterLogInStart', '', true, true)]
    // local procedure LogIn()
    // var
    //     LoginRec: Page "Login Card";
    // begin

    //     Clear(LoginRec);
    //     LoginRec.LookupMode(true);
    //     // MyTaskRevise.PassParameters("Style No.", "Line No.", "Buyer No.");
    //     LoginRec.RunModal();

    // end;





}
