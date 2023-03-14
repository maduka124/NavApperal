codeunit 50100 "Customization Management"
{
    procedure MergePlanningLines(TempCode: Code[10]; BatchName: code[10])
    var
        OldReqLines: Record "Requisition Line";
        NewReqLines: Record "Requisition Line";
        OldLineCount: Integer;
        NewLineCount: Integer;
        NewQty: Decimal;
        Window: Dialog;
        ShowMsg: Boolean;
        Inx: Integer;
    begin
        Window.Open('Processing data... @1@@@@@@@@@@');
        OldLineCount := 0;
        NewLineCount := 0;

        NewReqLines.LockTable();
        OldReqLines.LockTable();

        NewReqLines.Reset();
        NewReqLines.SetRange("Worksheet Template Name", TempCode);
        NewReqLines.SetRange("Journal Batch Name", BatchName);
        if not NewReqLines.IsEmpty then
            Error('Process the previous merged lines first');

        OldReqLines.Reset();
        OldReqLines.SetRange("Worksheet Template Name", TempCode);
        OldReqLines.SetFilter("Journal Batch Name", '<>%1', BatchName);
        OldLineCount := OldReqLines.Count;
        if not OldReqLines.FindFirst() then
            Error('Nothing not process');

        repeat
            Sleep(500);
            NewLineCount := NewReqLines.Count;
            if OldLineCount < 100 then
                Window.UPDATE(1, (NewLineCount / OldLineCount * 10000) DIV 1)
            else
                if NewLineCount MOD (OldLineCount DIV 100) = 0 THEN
                    Window.UPDATE(1, (NewLineCount / OldLineCount * 10000) DIV 1);

            Inx += 10000;
            NewReqLines.Reset();
            NewReqLines.SetRange("Worksheet Template Name", TempCode);
            NewReqLines.SetRange("Journal Batch Name", BatchName);
            NewReqLines.SetRange("No.", OldReqLines."No.");
            if not NewReqLines.FindFirst() then begin
                NewReqLines.Init();
                NewReqLines."Worksheet Template Name" := TempCode;
                NewReqLines."Journal Batch Name" := BatchName;
                NewReqLines."Line No." := Inx;
                NewReqLines.TransferFields(OldReqLines, false);
                NewReqLines.Insert(true);
            end
            else begin
                NewReqLines.Validate(Quantity, (NewReqLines.Quantity + OldReqLines.Quantity));
                NewReqLines.Validate("Due Date", OldReqLines."Due Date");
                NewReqLines.Modify();
            end;
            ShowMsg := true;
        until OldReqLines.Next() = 0;
        Window.Close();
        if ShowMsg then
            Message('Lines merge completed');
    end;

    // procedure CreateProdOrder(PassSoNo: Code[20])
    // var
    //     ManufacSetup: Record "Manufacturing Setup";
    //     ProdOrder: Record "Production Order";
    //     ProdOrderCreate: Record "Production Order";
    //     SalesHedd: Record "Sales Header";
    //     NoserMangement: Codeunit NoSeriesManagement;
    //     Window: Dialog;
    //     TextCon1: TextConst ENU = 'Creating Production Order ####1';

    // begin
    //     Window.Open(TextCon1);
    //     ManufacSetup.Get();
    //     ManufacSetup.TestField("Firm Planned Order Nos.");
    //     SalesHedd.get(SalesHedd."Document Type"::Order, PassSoNo);
    //     ProdOrder.LockTable();

    //     ProdOrder.Init();
    //     ProdOrder.Status := ProdOrder.Status::"Firm Planned";
    //     ProdOrder."No." := NoserMangement.GetNextNo(ManufacSetup."Firm Planned Order Nos.", WorkDate(), true);
    //     ProdOrder.Insert(true);
    //     Window.Update(1, ProdOrder."No.");
    //     Sleep(100);
    //     ProdOrder.Validate("Source Type", ProdOrder."Source Type"::"Sales Header");
    //     ProdOrder.Validate("Source No.", SalesHedd."No.");
    //     ProdOrder.Modify();
    //     Commit();

    //     ProdOrderCreate.Reset();
    //     ProdOrderCreate.SetRange(Status, ProdOrder.Status);
    //     ProdOrderCreate.SetRange("No.", ProdOrder."No.");
    //     REPORT.RUNMODAL(REPORT::"Refresh Production Order", FALSE, FALSE, ProdOrderCreate);
    //     COMMIT;
    //     Window.Close();
    // end;

    procedure CheckQty(ItemJnalLine: Record "Item Journal Line")
    var
        ProdOrdCompRec: Record "Prod. Order Component";
        ItemJnalTemplates: Record "Item Journal Template";
        InventSetup: Record "Inventory Setup";
    begin
        if ItemJnalLine."Journal Template Name" <> '' then begin
            InventSetup.Get();
            ItemJnalTemplates.Get(ItemJnalLine."Journal Template Name");
            //CurrPage.SetSelectionFilter(ItemJnalLine);
            if ItemJnalTemplates.Type = ItemJnalTemplates.Type::Consumption then begin
                if not ItemJnalTemplates.Recurring then begin

                    //  repeat
                    if ProdOrdCompRec.Get(ProdOrdCompRec.Status::Released, ItemJnalLine."Order No.", ItemJnalLine."Order Line No.", ItemJnalLine."Prod. Order Comp. Line No.") then begin
                        if not ItemJnalLine."Quantity Approved" then begin
                            ProdOrdCompRec.CalcFields("Act. Consumption (Qty)");
                            if (ProdOrdCompRec."Act. Consumption (Qty)" + ItemJnalLine.Quantity) > ProdOrdCompRec."Expected Quantity" then
                                Error('You can not post more than %1 quantity in line no %2', ProdOrdCompRec."Expected Quantity", ItemJnalLine."Line No.");
                        end;
                    end
                    else begin
                        if not ItemJnalLine."Quantity Approved" then
                            Error('Line no %1 must be approved', ItemJnalLine."Line No.");
                    end;
                    if not ItemJnalLine."Line Approved" then
                        Error('Line no %1 must be approved', ItemJnalLine."Line No.");
                end;
            end;
            if InventSetup."Gen. Issue Template" = ItemJnalLine."Journal Template Name" then begin
                if not ItemJnalLine."Line Approved" then
                    Error('Line no %1 must be approved', ItemJnalLine."Line No.");
            end;
        end;
    end;

    procedure InsertTemp(BOMEstCost: Record "BOM Estimate Cost")
    var
        TempCurrAmt: Record "Temp. Budget Entry" temporary;
        GenLedSetup: Record "General Ledger Setup";
        Window: Dialog;
        TextCon: TextConst ENU = 'Checking entries####1';
        ShowMsg: Boolean;

    begin
        Window.Open(TextCon);

        TempCurrAmt.Reset();
        TempCurrAmt.DeleteAll();

        GenLedSetup.Get();
        GenLedSetup.TestField("G/L Budget Name");
        GenLedSetup.TestField("Manufacturing Cost G/L");
        GenLedSetup.TestField("Overhead Cost G/L");
        GenLedSetup.TestField("Commission Cost G/L");
        GenLedSetup.TestField("Commercial Cost G/L");
        GenLedSetup.TestField("Deferred Payment G/L");
        GenLedSetup.TestField("Tax G/L");
        GenLedSetup.TestField("Sourcing G/L");
        GenLedSetup.TestField("Risk factor G/L");
        GenLedSetup.TestField("Total Sales G/L");
        GenLedSetup.TestField("Material Cost G/L");

        Window.Update(1, BOMEstCost."No.");
        Sleep(500);
        TempCurrAmt.Init();
        TempCurrAmt."G/L Code" := GenLedSetup."Manufacturing Cost G/L";
        TempCurrAmt.Date := WorkDate();
        TempCurrAmt.Amount := BOMEstCost."MFG Cost Total";
        TempCurrAmt.Insert();

        TempCurrAmt.Init();
        TempCurrAmt."G/L Code" := GenLedSetup."Overhead Cost G/L";
        TempCurrAmt.Date := WorkDate();
        TempCurrAmt.Amount := BOMEstCost."Overhead Total";
        TempCurrAmt.Insert();

        TempCurrAmt.Init();
        TempCurrAmt."G/L Code" := GenLedSetup."Commission Cost G/L";
        TempCurrAmt.Date := WorkDate();
        TempCurrAmt.Amount := BOMEstCost."Commission Total";
        TempCurrAmt.Insert();

        TempCurrAmt.Init();
        TempCurrAmt."G/L Code" := GenLedSetup."Commercial Cost G/L";
        TempCurrAmt.Date := WorkDate();
        TempCurrAmt.Amount := BOMEstCost."Commercial Total";
        TempCurrAmt.Insert();

        TempCurrAmt.Init();
        TempCurrAmt."G/L Code" := GenLedSetup."Deferred Payment G/L";
        TempCurrAmt.Date := WorkDate();
        TempCurrAmt.Amount := BOMEstCost."Deferred Payment Total";
        TempCurrAmt.Insert();

        TempCurrAmt.Init();
        TempCurrAmt."G/L Code" := GenLedSetup."Tax G/L";
        TempCurrAmt.Date := WorkDate();
        TempCurrAmt.Amount := BOMEstCost."TAX Total";
        TempCurrAmt.Insert();

        TempCurrAmt.Init();
        TempCurrAmt."G/L Code" := GenLedSetup."Sourcing G/L";
        TempCurrAmt.Date := WorkDate();
        TempCurrAmt.Amount := BOMEstCost."ABA Sourcing Total";
        TempCurrAmt.Insert();

        TempCurrAmt.Init();
        TempCurrAmt."G/L Code" := GenLedSetup."Risk factor G/L";
        TempCurrAmt.Date := WorkDate();
        TempCurrAmt.Amount := BOMEstCost."Risk factor Total";
        TempCurrAmt.Insert();

        TempCurrAmt.Init();
        TempCurrAmt."G/L Code" := GenLedSetup."Total Sales G/L";
        TempCurrAmt.Date := WorkDate();
        TempCurrAmt.Amount := BOMEstCost."FOB Total";
        TempCurrAmt.Insert();

        TempCurrAmt.Init();
        TempCurrAmt."G/L Code" := GenLedSetup."Material Cost G/L";
        TempCurrAmt.Date := WorkDate();
        TempCurrAmt.Amount := BOMEstCost."Sub Total (Dz.) Total";
        TempCurrAmt.Insert();

        Window.Close();

        if TempCurrAmt.FindFirst() then
            repeat
                if TempCurrAmt.Amount > 0 then
                    InsertBudgetEntry(TempCurrAmt."G/L Code", TempCurrAmt.Amount, BOMEstCost."No.", ShowMsg);
            until TempCurrAmt.Next() = 0;

    end;

    local procedure InsertBudgetEntry(PassNo: Code[20]; PassAmt: Decimal; PassDocNo: Code[20]; var LinesPassed: Boolean)
    var

        GLBudgetEntry: Record "G/L Budget Entry";
        LastLNo: Integer;
        GenLedSetup: Record "General Ledger Setup";
        Window: Dialog;
        TextCon2: TextConst ENU = 'Account No.#1######';
    begin
        Window.Open(TextCon2);
        LinesPassed := false;

        GenLedSetup.Get();
        GLBudgetEntry.Reset();
        GLBudgetEntry.SetCurrentKey("Entry No.");
        if GLBudgetEntry.FindLast() then
            LastLNo := GLBudgetEntry."Entry No.";

        Window.Update(1, PassNo);
        Sleep(500);

        GLBudgetEntry.Init();
        GLBudgetEntry."Entry No." := LastLNo + 1;
        GLBudgetEntry."Budget Name" := GenLedSetup."G/L Budget Name";
        GLBudgetEntry.validate("G/L Account No.", PassNo);
        GLBudgetEntry.Validate(Date, WorkDate());
        GLBudgetEntry.Validate(Amount, PassAmt);
        GLBudgetEntry.Description := PassDocNo;
        GLBudgetEntry.Insert(true);
        LinesPassed := true;
        Window.Close();
    end;

    procedure CreateItemChargeEntry(B2BLCMaster: Record B2BLCMaster)
    var
        OtherChargesRec: Record "Other Charges";
        PurchHedd: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        GenJnalLine: Record "Gen. Journal Line";
        GenLedSetup: Record "General Ledger Setup";
        PurchPaySetup: Record "Purchases & Payables Setup";
        NosMangemnt: Codeunit NoSeriesManagement;
        Inx: Integer;
        Inx2: Integer;
        Window: Dialog;
        TextCon2: TextConst ENU = 'Creating#1######';
        MsgShow: Boolean;
    begin
        Inx := 0;
        MsgShow := false;

        Window.Open(TextCon2);

        PurchPaySetup.Get();
        PurchPaySetup.TestField("Invoice Nos.");
        GenLedSetup.get();
        GenLedSetup.TestField("Bank Charge Template");
        GenLedSetup.TestField("Bank Charge Batch");
        GenLedSetup.TestField("Bank Charge G/L");
        GenLedSetup.TestField("Bank Charge Bank Account");

        GenJnalLine.Reset();
        GenJnalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        GenJnalLine.SetRange("Journal Template Name", GenLedSetup."Bank Charge G/L");
        GenJnalLine.SetRange("Journal Batch Name", GenLedSetup."Bank Charge Batch");
        if GenJnalLine.FindLast() then
            Inx := GenJnalLine."Line No."
        else
            Inx := 10000;

        OtherChargesRec.Reset();
        OtherChargesRec.SetCurrentKey("Document No.", "Bank Charge");
        OtherChargesRec.SetRange("Document No.", B2BLCMaster."No.");
        OtherChargesRec.SetRange("Process Completed", false);
        if not OtherChargesRec.FindFirst() then
            Error('Data not found');

        repeat
            Window.Update(1, OtherChargesRec."Item Charge No.");
            Sleep(500);
            if OtherChargesRec."Bank Charge" then begin
                Inx2 := Inx + 10000;
                GenJnalLine.Init();
                GenJnalLine."Journal Template Name" := GenLedSetup."Bank Charge Template";
                GenJnalLine."Journal Batch Name" := GenLedSetup."Bank Charge Batch";
                GenJnalLine."Line No." := Inx2;
                GenJnalLine.Validate("Posting Date", WorkDate());
                GenJnalLine.validate("Document Type", GenJnalLine."Document Type"::" ");
                GenJnalLine.validate("Account Type", GenJnalLine."Account Type"::"G/L Account");
                GenJnalLine.validate("Account No.", GenLedSetup."Bank Charge G/L");
                GenJnalLine.validate(Amount, OtherChargesRec.Amount);
                GenJnalLine.validate("Bal. Account Type", GenJnalLine."Bal. Account Type"::"Bank Account");
                GenJnalLine.validate("Bal. Account No.", GenLedSetup."Bank Charge Bank Account");
                GenJnalLine.Insert(true);
                OtherChargesRec."Process Completed" := true;
                OtherChargesRec.Modify();
                Inx += 10000;
                MsgShow := true;
            end
            else begin
                OtherChargesRec.TestField("Vendor No.");
                PurchHedd.Init();
                PurchHedd."Document Type" := PurchHedd."Document Type"::Invoice;
                PurchHedd."No." := NosMangemnt.GetNextNo(PurchPaySetup."Invoice Nos.", WorkDate(), true);
                PurchHedd.Validate("Buy-from Vendor No.", OtherChargesRec."Vendor No.");
                PurchHedd.Insert(true);

                PurchLine.Init();
                PurchLine."Document Type" := PurchLine."Document Type"::Invoice;
                PurchLine."Document No." := PurchHedd."No.";
                PurchLine."Line No." := 10000;
                PurchLine.Validate(Type, PurchLine.Type::"Charge (Item)");
                PurchLine.Validate("No.", OtherChargesRec."Item Charge No.");
                PurchLine.Validate(Quantity, 1);
                PurchLine.Validate("Direct Unit Cost", OtherChargesRec.Amount);
                PurchLine.Insert(true);
                MsgShow := true;
                OtherChargesRec."Process Completed" := true;
                OtherChargesRec.Modify();
            end;
        until OtherChargesRec.Next() = 0;
        Window.Close();
        if MsgShow then
            Message('Process Completed');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Req. Wksh.-Make Order", 'OnBeforePurchOrderHeaderInsert', '', true, true)]
    local procedure UpdateBeforeInsertPO(var PurchaseHeader: Record "Purchase Header"; RequisitionLine: Record "Requisition Line")
    var
        NosMangement: Codeunit NoSeriesManagement;
    begin
        RequisitionLine.TestField("Purchase Order Nos.");
        PurchaseHeader."No. Series" := RequisitionLine."Purchase Order Nos.";
        PurchaseHeader."Receiving No. Series" := RequisitionLine."Receiving Nos.";
        PurchaseHeader."No." := NosMangement.GetNextNo(RequisitionLine."Purchase Order Nos.", Today, true);
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnBeforeRunWithCheck', '', true, true)]
    local procedure CheckBeforePost(var ItemJournalLine: Record "Item Journal Line"; CalledFromAdjustment: Boolean; CalledFromInvtPutawayPick: Boolean; CalledFromApplicationWorksheet: Boolean; PostponeReservationHandling: Boolean; var IsHandled: Boolean)
    var
        CustMangemnet: Codeunit "Customization Management";
    begin
        CustMangemnet.CheckQty(ItemJournalLine);
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnBeforePostSalesDoc', '', true, true)]
    local procedure BeforePostSales(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean)
    var
        GenLedSetup: Record "General Ledger Setup";
        DimValues: Record "Dimension Value";
        SalesRecSetup: Record "Sales & Receivables Setup";
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            if SalesHeader."Shortcut Dimension 1 Code" <> '' then begin
                GenLedSetup.Get();
                DimValues.Get(GenLedSetup."Shortcut Dimension 1 Code", SalesHeader."Shortcut Dimension 1 Code");
                DimValues.TestField("No. Series - Invoicing");
                DimValues.TestField("No. Series - Shipping");

                SalesHeader."Posting No. Series" := DimValues."No. Series - Invoicing";
                SalesHeader."Shipping No. Series" := DimValues."No. Series - Shipping";
                SalesHeader.TESTFIELD("Posting No.", '');
            end
            else begin
                SalesRecSetup.Get();
                SalesHeader.Validate("Posting No. Series", SalesRecSetup."Posted Invoice Nos.");
                SalesHeader.Validate("Shipping No. Series", SalesRecSetup."Posted Shipment Nos.");
            end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure UpdateItemLed(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin
        NewItemLedgEntry."Quantity Approved" := ItemJournalLine."Quantity Approved";
        NewItemLedgEntry."Qty. Approved Date/Time" := ItemJournalLine."Qty. Approved Date/Time";
        NewItemLedgEntry."Qty. Approved UserID" := ItemJournalLine."Qty. Approved UserID";
        NewItemLedgEntry."Transfer Order Created" := ItemJournalLine."Transfer Order Created";
        NewItemLedgEntry.PO := ItemJournalLine.PO;
        NewItemLedgEntry."Posted Daily Output" := ItemJournalLine."Posted Daily Output";
        NewItemLedgEntry."Daily Consumption Doc. No." := ItemJournalLine."Daily Consumption Doc. No.";
        NewItemLedgEntry."Invent. Posting Grp." := ItemJournalLine."Inventory Posting Group";
        NewItemLedgEntry."Style Transfer Doc. No." := ItemJournalLine."Style Transfer Doc. No.";
        NewItemLedgEntry."Line Approved" := ItemJournalLine."Line Approved";
        NewItemLedgEntry."Line Approved DateTime" := ItemJournalLine."Line Approved DateTime";
        NewItemLedgEntry."Line Approved UserID" := ItemJournalLine."Line Approved UserID";
        NewItemLedgEntry."Requsting Department Name" := ItemJournalLine."Requsting Department Name";
        NewItemLedgEntry."Main Category Name" := ItemJournalLine."Main Category Name";
        NewItemLedgEntry.MainCategory := ItemJournalLine.MainCategory;
        NewItemLedgEntry.MainCategoryName := ItemJournalLine.MainCategoryName;
        NewItemLedgEntry."Original Daily Requirement" := ItemJournalLine."Original Daily Requirement";
        NewItemLedgEntry."Gen. Issue Doc. No." := ItemJournalLine."Gen. Issue Doc. No.";
        NewItemLedgEntry."Posted Daily Consump. Doc. No." := ItemJournalLine."Posted Daily Consump. Doc. No.";
        NewItemLedgEntry."Posted Gen. Issue Doc. No." := ItemJournalLine."Posted Gen. Issue Doc. No.";
        //NewItemLedgEntry."Style No." := ItemJournalLine."Style No.";
        //NewItemLedgEntry."Style Name" := ItemJournalLine."Style Name";
    end;
    //Sent to maduka to update in his SourceCode 04/11/22
    // [EventSubscriber(ObjectType::Table, 5746, 'OnAfterCopyFromTransferHeader', '', true, true)]
    // local procedure UpdateTransRec(var TransferReceiptHeader: Record "Transfer Receipt Header"; TransferHeader: Record "Transfer Header")
    // begin
    //     TransferReceiptHeader."Style No." := TransferHeader."Style No.";
    //     TransferReceiptHeader."Style Name" := TransferHeader."Style Name";
    //     TransferReceiptHeader.PO := TransferHeader.PO;
    // end;

    // [EventSubscriber(ObjectType::Table, 5744, 'OnAfterCopyFromTransferHeader', '', true, true)]
    // local procedure UpdateShipRec(var TransferShipmentHeader: Record "Transfer Shipment Header"; TransferHeader: Record "Transfer Header")
    // begin
    //     TransferShipmentHeader."Style No." := TransferHeader."Style No.";
    //     TransferShipmentHeader."Style Name" := TransferHeader."Style Name";
    //     TransferShipmentHeader.PO := TransferHeader.PO;
    // end;

    [EventSubscriber(ObjectType::Report, 5405, 'OnBeforeInsertItemJnlLine', '', true, true)]
    local procedure UpdateConsmp(var ItemJournalLine: Record "Item Journal Line"; ProdOrderComponent: Record "Prod. Order Component")
    var
        ProdOrderRec: Record "Production Order";
    begin
        ProdOrderRec.Get(ProdOrderComponent.Status, ProdOrderComponent."Prod. Order No.");
        //ItemJournalLine."Style No." := ProdOrderRec."Style No.";
        //ItemJournalLine."Style Name" := ProdOrderRec."Style Name";
        ItemJournalLine.PO := ProdOrderRec.PO;
    end;

    [EventSubscriber(ObjectType::Table, 83, 'OnAfterSetupNewLine', '', true, true)]
    local procedure OnAfterNewline(var ItemJournalLine: Record "Item Journal Line"; var LastItemJournalLine: Record "Item Journal Line"; ItemJournalTemplate: Record "Item Journal Template")
    var
        InventSetup: Record "Inventory Setup";
        ItemJnalBatch: Record "Item Journal Batch";
        UserSetup: Record "User Setup";
    begin
        InventSetup.Get();
        if InventSetup."Gen. Issue Template" = ItemJournalTemplate.Name then begin
            ItemJnalBatch.Get(ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name");
            UserSetup.Get(UserId);
            if UserSetup."Global Dimension Code" <> ItemJnalBatch."Shortcut Dimension 1 Code" then
                Error('You do not have permission to use this batch');
            ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
        end;
    end;
    // [EventSubscriber(ObjectType::Codeunit, 21, 'OnAfterCheckItemJnlLine', '', true, true)]
    // local procedure CheckBeforePost(var ItemJnlLine: Record "Item Journal Line";CalledFromInvtPutawayPick: Boolean;: Boolean)
    // var
    //     InventSetup: Record "Inventory Setup";
    // begin
    //     InventSetup.Get();
    //     if InventSetup."Gen. Issue Template" = ItemJournalTemplate.Name then begin
    //         ItemJournalLine."Entry Type" := ItemJournalLine."Entry Type"::"Negative Adjmt.";
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterPostItem', '', true, true)]
    local procedure UpdatePostConsmp(var ItemJournalLine: Record "Item Journal Line")
    var
        DailyConsumRec: Record "Daily Consumption Header";
        GenIssueHeddRec: Record "General Issue Header";
    begin
        if ItemJournalLine."Daily Consumption Doc. No." <> '' then begin
            DailyConsumRec.Get(ItemJournalLine."Daily Consumption Doc. No.");
            DailyConsumRec."Issued UserID" := UserId;
            DailyConsumRec."Issued Date/Time" := CurrentDateTime;
            DailyConsumRec.Modify();
        end;
        if ItemJournalLine."Gen. Issue Doc. No." <> '' then begin
            GenIssueHeddRec.Get(ItemJournalLine."Gen. Issue Doc. No.");
            GenIssueHeddRec."Issued Date/Time" := CurrentDateTime;
            GenIssueHeddRec."Issued UserID" := UserId;
            GenIssueHeddRec."Posted Qty." += ItemJournalLine.Quantity;
            if GenIssueHeddRec."Posted Qty." >= GenIssueHeddRec."Line Total Qty." then
                GenIssueHeddRec."Fully Posted" := true;
            GenIssueHeddRec.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 99000773, 'OnAfterTransferBOMComponent', '', true, true)]
    local procedure UpdateBomLine(var ProdOrderLine: Record "Prod. Order Line"; var ProductionBOMLine: Record "Production BOM Line"; var ProdOrderComponent: Record "Prod. Order Component"; LineQtyPerUOM: Decimal; ItemQtyPerUOM: Decimal)
    var
        ItemRec: Record Item;
    begin
        if ProdOrderComponent."Item No." <> '' then
            ItemRec.Get(ProdOrderComponent."Item No.");
        ProdOrderComponent."Item Cat. Code" := ItemRec."Item Category Code";
        ProdOrderComponent."Invent. Posting Group" := ItemRec."Inventory Posting Group";
    end;

    procedure PassParameters(PurchaseNo: Code[20]);
    var
    begin
        PurchNo := PurchaseNo;
    end;



    procedure ImportPurchaseTrackingExcel(PurchHedd: Record "Purchase Header")
    var
        TrackingRec: Record "Tracking Specification";
        ReservEntry: Record "Reservation Entry";
        ReservEntryFilter: Record "Reservation Entry";
        ColourRec: Record Colour;
        ShadeRec: Record Shade;
        EntNo: Integer;
        Rec_ExcelBuffer: Record "Excel Buffer";
        Rows: Integer;
        Columns: Integer;
        Fileuploaded: Boolean;
        UploadIntoStream: InStream;
        Sheetname: Text;
        UploadResult: Boolean;
        DialogCaption: Text;
        Name: Text;
        NVInStream: InStream;
        RowNo: Integer;
    begin
        Rec_ExcelBuffer.DeleteAll();
        Rows := 0;
        Columns := 0;
        Name := '';
        Sheetname := '';

        DialogCaption := 'Select File to upload';
        UploadResult := UploadIntoStream(DialogCaption, '', '', Name, NVInStream);

        If Name <> '' then
            Sheetname := Rec_ExcelBuffer.SelectSheetsNameStream(NVInStream)
        else
            exit;

        Rec_ExcelBuffer.Reset();
        Rec_ExcelBuffer.OpenBookStream(NVInStream, Sheetname);
        Rec_ExcelBuffer.ReadSheet();
        Commit();

        Rec_ExcelBuffer.Reset();
        Rec_ExcelBuffer.SetRange("Column No.", 1);
        If Rec_ExcelBuffer.FindFirst() then
            repeat
                Rows := Rows + 1;
            until Rec_ExcelBuffer.Next() = 0;

        Rec_ExcelBuffer.Reset();
        Rec_ExcelBuffer.SetRange("Row No.", 1);
        if Rec_ExcelBuffer.FindFirst() then
            repeat
                Columns := Columns + 1;
            until Rec_ExcelBuffer.Next() = 0;
        //Function to Get the last line number in Job Journal

        //LineNo := FindLineNo();
        // ReservEntry.Reset();
        // ReservEntry.SetCurrentKey("Entry No.");
        // ReservEntry.SetRange("Source ID", PurchHedd."No.");
        // if ReservEntry.FindFirst() then
        //     Error('Reservation entry already exists');


        for RowNo := 2 to Rows do begin
            begin
                ReservEntry.Reset();
                ReservEntry.SetCurrentKey("Entry No.");
                // ReservEntry.SetRange("Entry No.", PurchHedd.);
                if ReservEntry.FindLast() then
                    EntNo := ReservEntry."Entry No." + 1
                else
                    EntNo := 1;


                Clear(ReservEntry);

                ReservEntry.INIT;
                ReservEntry."Entry No." := EntNo;

                //Mihiranga 2023/03/09
                if PurchHedd."No." <> GetValueAtCell(RowNo, 5) then
                    Error('PO No not matching');
                PurchaseLineRec.get(PurchaseLineRec."Document Type"::Order, PurchHedd."No.", GetValueAtCell(RowNo, 6));
                if PurchaseLineRec."No." <> GetValueAtCell(RowNo, 1) then
                    Error('Item number not matching');

   
                ReservEntryFilter.Reset();
                ReservEntryFilter.SetRange("Source ID", PurchHedd."No.");
                ReservEntryFilter.SetRange("Item No.", GetValueAtCell(RowNo, 1));
                ReservEntryFilter.SetFilter("Lot No.", GetValueAtCell(RowNo, 8));
                if ReservEntry.FindFirst() then
                    Error('Record Already Exist');

                EVALUATE(ReservEntry."Item No.", GetValueAtCell(RowNo, 1));
                EVALUATE(ReservEntry."Location Code", GetValueAtCell(RowNo, 2));
                EVALUATE(ReservEntry."Quantity (Base)", GetValueAtCell(RowNo, 3));
                ReservEntry.Validate("Quantity (Base)");
                ReservEntry."Reservation Status" := ReservEntry."Reservation Status"::Surplus;
                EVALUATE(ReservEntry."Creation Date", GetValueAtCell(RowNo, 4));
                ReservEntry."Source Type" := 39;
                ReservEntry."Source Subtype" := 1;
                EVALUATE(ReservEntry."Source ID", GetValueAtCell(RowNo, 5));
                EVALUATE(ReservEntry."Source Ref. No.", GetValueAtCell(RowNo, 6));
                EVALUATE(ReservEntry."Expected Receipt Date", GetValueAtCell(RowNo, 7));
                EVALUATE(ReservEntry."Lot No.", GetValueAtCell(RowNo, 8));


                EVALUATE(ReservEntry."Supplier Batch No.", GetValueAtCell(RowNo, 9));
                EVALUATE(ReservEntry."Shade No", GetValueAtCell(RowNo, 10));

                ShadeRec.Reset();
                ShadeRec.SetRange("No.", GetValueAtCell(RowNo, 10));
                if ShadeRec.FindSet() then
                    EVALUATE(ReservEntry."Shade", ShadeRec.Shade)
                else
                    Error('Invalid Shade');

                EVALUATE(ReservEntry."Length Tag", GetValueAtCell(RowNo, 11));
                EVALUATE(ReservEntry."Width Tag", GetValueAtCell(RowNo, 12));
                EVALUATE(ReservEntry.Color, GetValueAtCell(RowNo, 13));

                ColourRec.Reset();
                ColourRec.SetRange("Colour Name", GetValueAtCell(RowNo, 13));
                if ColourRec.FindSet() then
                    EVALUATE(ReservEntry."Color No", ColourRec."No.")
                else
                    Error('Invalid Color.');

                ReservEntry.Positive := true;
                ReservEntry.validate("Qty. per Unit of Measure", 1);
                ReservEntry."Created By" := UserId;
                ReservEntry."Item Tracking" := ReservEntry."Item Tracking"::"Lot No.";
                ReservEntry.INSERT(TRUE);
                //ReservEntry.Modify();
                Commit();
            end;
        end;

        Message('Import Completed');

    end;



    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    var
        Rec_ExcelBuffer: Record "Excel Buffer";
    begin
        Rec_ExcelBuffer.Reset();
        If Rec_ExcelBuffer.Get(RowNo, ColNo) then
            exit(Rec_ExcelBuffer."Cell Value as Text");
    end;

    var
        PurchaseLineRec: Record "Purchase Line";
        PurchNo: Code[20];

}
