page 50120 "Approved Daily Consump. List"
{
    ApplicationArea = All;
    Caption = 'Approved Raw Material Requisition List';
    PageType = List;
    SourceTable = "Daily Consumption Header";
    UsageCategory = Lists;
    SourceTableView = where(Status = filter(Approved));
    //CardPageId = 50102;
    Editable = false;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Buyer; Rec.Buyer)
                {
                    ApplicationArea = All;
                }
                field("Style No."; Rec."Style No.")
                {
                    ApplicationArea = All;
                }
                field(PO; rec.PO)
                {
                    ApplicationArea = All;
                }
                field("Colour Name"; rec."Colour Name")
                {
                    ApplicationArea = All;
                }
                field("Created UserID"; rec."Created UserID")
                {
                    Caption = 'User';
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Approved Date/Time"; rec."Approved Date/Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issued UserID"; rec."Issued UserID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Issued Date/Time"; rec."Issued Date/Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Material Request")
            {
                Caption = 'Material Issue';
                ApplicationArea = All;
                Image = ConsumptionJournal;
                Promoted = true;
                PromotedCategory = Process;

                // RunObject = page "Consumption Journal";
                // RunPageLink = "Daily Consumption Doc. No." = field("No.");
                trigger OnAction()
                var
                    ItemJnalRec: Record "Item Journal Line";
                    ItemJnlMgt: Codeunit ItemJnlManagement;

                    //Mihiranga 2023/02/01
                    CalConsump: Report "Calc. Consumption";
                    ProdOrdComp: Record "Prod. Order Component";
                    DailyConsumpLine: Record "Daily Consumption Line";
                    ProdOrderLine: Record "Prod. Order Line";
                    ProdOrderRec: Record "Production Order";
                    ItemLedEntry: Record "Item Ledger Entry";
                    ItemLedEntry2: Record "Item Ledger Entry";
                    ReserveEntryLast: Record "Reservation Entry";
                    ReserveEntry: Record "Reservation Entry";
                    ItemJnalBatch: Record "Item Journal Batch";
                    NoserMangemnt: Codeunit NoSeriesManagement;
                    ManufacSetup: Record "Manufacturing Setup";
                    PostNo: Code[20];
                    Window: Dialog;
                    Inx1: Integer;
                    LastLNo: Integer;
                    QtyToLot: Decimal;
                    TotRecervQty: Decimal;
                    LineCompleted: Boolean;
                    Text000: Label 'Calculating consumption...\\';
                    Text001: Label 'Prod. Order No.   #1##########\';
                    Text002: Label 'Item No.          #2##########\';
                    Text003: Label 'Quantity          #3##########';
                    ItemVer: Integer;
                    CalQty: Decimal;
                    User: Text[200];
                begin
                    // ItemJnalRec.Reset();
                    // ItemJnalRec.SetRange("Journal Template Name", rec."Journal Template Name");
                    // ItemJnlMgt.SetName(rec."Journal Batch Name", ItemJnalRec);
                    // ItemJnalRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    // ItemJnalRec.SetRange("Daily Consumption Doc. No.", rec."No.");

                    // Page.RunModal(99000846, ItemJnalRec);


                    Inx1 := 0;
                    PostNo := '';

                    //Window.Open(Text000 +
                    // Text001 +
                    // Text002 +
                    // Text003);

                    // CalConsump.RUNMODAL;
                    ManufacSetup.Get();
                    ManufacSetup.TestField("Posted Daily Consumption Nos.");

                    PostNo := NoserMangemnt.GetNextNo(ManufacSetup."Posted Daily Consumption Nos.", Today, true);

                    ProdOrderRec.Get(ProdOrderRec.Status::Released, rec."Prod. Order No.");
                    ItemJnalBatch.Get(rec."Journal Template Name", rec."Journal Batch Name");

                    ItemJnalRec.Reset();
                    ItemJnalRec.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                    ItemJnalRec.SetRange("Journal Template Name", Rec."Journal Template Name");
                    ItemJnalRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    if ItemJnalRec.FindLast() then
                        LastLNo := ItemJnalRec."Line No.";



                    //Window.Update(1, rec."Prod. Order No.");
                    DailyConsumpLine.Reset();
                    DailyConsumpLine.SetRange("Document No.", rec."No.");
                    DailyConsumpLine.SetFilter("Daily Consumption", '>%1', 0);
                    if DailyConsumpLine.FindFirst() then begin
                        repeat
                            ProdOrderLine.Get(ProdOrderLine.Status::Released, DailyConsumpLine."Prod. Order No.", DailyConsumpLine."Prod. Order Line No.");
                            ProdOrdComp.Reset();
                            ProdOrdComp.SetRange("Prod. Order No.", Rec."Prod. Order No.");
                            ProdOrdComp.SetRange("Prod. Order Line No.", DailyConsumpLine."prod. Order Line No.");
                            ProdOrdComp.SetFilter("Remaining Quantity", '<>%1', 0);
                            ProdOrdComp.SETFILTER("Flushing Method", '<>%1&<>%2', "Flushing Method"::Backward, "Flushing Method"::"Pick + Backward");
                            ProdOrdComp.SetRange("Item Cat. Code", Rec."Main Category");
                            if ItemJnalBatch."Inventory Posting Group" <> '' then
                                ProdOrdComp.SetRange("Invent. Posting Group", ItemJnalBatch."Inventory Posting Group");

                            if ProdOrdComp.FindFirst() then
                                repeat

                                    CalQty := 0;
                                    ItemVer := ProdOrdComp."Line No.";

                                    LineCompleted := false;
                                    QtyToLot := 0;
                                    TotRecervQty := 0;
                                    if LastLNo <> 0 then
                                        Inx1 := LastLNo;

                                    ItemJnalRec.Reset();
                                    ItemJnalRec.SetRange("Prod. Order Comp. Line No.", ItemVer);
                                    ItemJnalRec.SetRange("Order No.", Rec."Prod. Order No.");
                                    ItemJnalRec.SetRange("Order Line No.", ProdOrdComp."Prod. Order Line No.");

                                    if not ItemJnalRec.FindSet() then begin

                                        ItemLedEntry.Reset();
                                        ItemLedEntry.SetCurrentKey("Location Code", "Item No.");
                                        ItemLedEntry.SetRange("Item No.", ProdOrdComp."Item No.");
                                        ItemLedEntry.SetRange("Location Code", ProdOrdComp."Location Code");
                                        ItemLedEntry.CalcSums(Quantity);

                                        // Window.Update(2, ProdOrdComp."Item No.");
                                        ItemJnalRec.Init();
                                        ItemJnalRec."Journal Template Name" := rec."Journal Template Name";
                                        ItemJnalRec."Journal Batch Name" := rec."Journal Batch Name";
                                        ItemJnalRec."Line No." := Inx1 + 10000;
                                        ItemJnalRec.Insert(true);


                                        Sleep(200);
                                        ItemJnalRec.Validate("Entry Type", ItemJnalRec."Entry Type"::Consumption);
                                        ItemJnalRec.Validate("Order Type", ItemJnalRec."Order Type"::Production);
                                        ItemJnalRec.Validate("Order No.", rec."Prod. Order No.");
                                        ItemJnalRec.Validate("Source No.", DailyConsumpLine."Item No.");
                                        ItemJnalRec.Validate("Posting Date", rec."Document Date");
                                        ItemJnalRec."Daily Consumption Doc. No." := DailyConsumpLine."Document No.";
                                        ItemJnalRec."Posted Daily Consump. Doc. No." := PostNo;
                                        ItemJnalRec."Posted Daily Output" := DailyConsumpLine."Daily Consumption";
                                        ItemJnalRec.Validate("Order Line No.", DailyConsumpLine."prod. Order Line No.");
                                        ItemJnalRec.PO := ProdOrderRec.PO;
                                        ItemJnalRec."Style No." := ProdOrderRec."Style No.";
                                        ItemJnalRec."Style Name" := ProdOrderRec."Style Name";

                                        //ProdOrdComp.Get(ProdOrdComp.Status::Released, rec."Transaction Doc. No.", rec."Transaction Line No.", BarcodeLine."Componant Line No.");
                                        ItemJnalRec.Validate("Item No.", ProdOrdComp."Item No.");

                                        ItemLedEntry2.Reset();
                                        ItemLedEntry2.SetCurrentKey("Entry No.");
                                        ItemLedEntry2.SetRange("Item No.", ProdOrdComp."Item No.");
                                        ItemLedEntry2.SetRange("Entry Type", ItemLedEntry2."Entry Type"::Consumption);
                                        ItemLedEntry2.SetRange("Order No.", ProdOrdComp."Prod. Order No.");
                                        ItemLedEntry2.SetRange("Order Line No.", ProdOrdComp."Prod. Order Line No.");
                                        ItemLedEntry2.SetRange("Prod. Order Comp. Line No.", ProdOrdComp."Line No.");
                                        ItemLedEntry2.CalcSums(Quantity);
                                        // Message('comp %1 / Ord Lin %2 / Qty %3', ProdOrdComp."Line No.", ProdOrdComp."Prod. Order Line No.", Abs(ItemLedEntry2.Quantity));
                                        CalQty := ProdOrdComp."Quantity per" * DailyConsumpLine."Daily Consumption";

                                        // if ItemLedEntry2.Quantity > CalQty then
                                        //     Message('This issuing cannot be post')
                                        //     else
                                        //     calQty := CalQty - abs(ItemLedEntry2.Quantity);
                                        // end;

                                        calQty := CalQty - abs(ItemLedEntry2.Quantity);
                                        ItemJnalRec.Validate(Quantity, calQty);
                                        // if (ProdOrdComp."Quantity per" * (DailyConsumpLine."Daily Consumption" - abs(ItemLedEntry2.Quantity))) > ProdOrdComp."Remaining Quantity" then
                                        //     ItemJnalRec.Validate(Quantity, ProdOrdComp."Remaining Quantity")
                                        // else
                                        //     ItemJnalRec.Validate(Quantity, (ProdOrdComp."Quantity per" * (DailyConsumpLine."Daily Consumption" - abs(ItemLedEntry2.Quantity))));
                                        // Window.Update(3, ItemJnalRec.Quantity);
                                        ItemJnalRec."Original Daily Requirement" := ItemJnalRec.Quantity;
                                        ItemJnalRec."Stock After Issue" := ItemLedEntry.Quantity - ItemJnalRec.Quantity;
                                        //Mihiranga 2022/01/16
                                        ItemJnalRec."Request Qty" := ItemJnalRec.Quantity;
                                        ItemJnalRec.Validate("Variant Code", ProdOrdComp."Variant Code");
                                        ItemJnalRec.Validate("Location Code", ProdOrdComp."Location Code");
                                        ItemJnalRec.Description := ProdOrdComp.Description;
                                        ItemJnalRec.Validate("Unit of Measure Code", ProdOrdComp."Unit of Measure Code");
                                        ItemJnalRec.Validate("Prod. Order Comp. Line No.", ProdOrdComp."Line No.");

                                        ItemJnalRec."Line Approved" := true;

                                        if ItemLedEntry2.FindSet() then begin
                                            ItemJnalRec.SystemCreatedAt := ItemLedEntry2.SystemCreatedAt;
                                            ItemJnalRec."Posting Date" := ItemLedEntry2."Posting Date";
                                            ItemJnalRec.SystemCreatedBy := ItemLedEntry2.SystemCreatedBy;
                                        end;

                                        ItemJnalRec.Modify();
                                        Inx1 := ItemJnalRec."Line No.";
                                        LastLNo := 0;

                                        ItemLedEntry.Reset();
                                        ItemLedEntry.SetCurrentKey("Item No.", Open, "Variant Code", "Location Code", "Item Tracking",
                                                        "Lot No.", "Serial No.");
                                        ItemLedEntry.SetRange("Item No.", ProdOrdComp."Item No.");
                                        ItemLedEntry.SetRange("Variant Code", ProdOrdComp."Variant Code");
                                        ItemLedEntry.SetRange(Open, true);
                                        ItemLedEntry.SetRange("Location Code", ProdOrdComp."Location Code");
                                        ItemLedEntry.SetFilter("Lot No.", '<>%1', '');
                                        if ItemLedEntry.FindFirst() then begin
                                            REPEAT
                                                if not LineCompleted then begin
                                                    //Check Same lot availability
                                                    ReserveEntry.RESET;
                                                    ReserveEntry.SETCURRENTKEY("Entry No.");
                                                    ReserveEntry.SetRange("Item No.", ProdOrdComp."Item No.");
                                                    ReserveEntry.SetRange("Lot No.", ItemLedEntry."Lot No.");
                                                    // ReserveEntry.SetRange("Source ID", rec."Journal Template Name");
                                                    // ReserveEntry.SetRange("Source Batch Name", Rec."Journal Batch Name");
                                                    // ReserveEntry.SetRange("Source Ref. No.", ItemJnalRec."Line No.");
                                                    ReserveEntry.CalcSums(Quantity);

                                                    ReserveEntryLast.RESET;
                                                    ReserveEntryLast.SETCURRENTKEY("Entry No.");
                                                    ReserveEntryLast.SetRange("Item No.", ProdOrdComp."Item No.");
                                                    ReserveEntryLast.SetRange("Source ID", rec."Journal Template Name");
                                                    ReserveEntryLast.SetRange("Source Batch Name", Rec."Journal Batch Name");
                                                    ReserveEntryLast.SetRange("Source Ref. No.", ItemJnalRec."Line No.");
                                                    ReserveEntryLast.CalcSums(Quantity);
                                                    TotRecervQty := ABS(ReserveEntryLast.Quantity);

                                                    IF (ItemJnalRec.Quantity > TotRecervQty) and (ItemLedEntry."Remaining Quantity" - Abs(ReserveEntry.Quantity) > 0) then begin
                                                        if (ItemLedEntry."Remaining Quantity" - Abs(ReserveEntry.Quantity)) <= (ItemJnalRec.Quantity - TotRecervQty) then
                                                            QtyToLot := ItemLedEntry."Remaining Quantity" - Abs(ReserveEntry.Quantity)
                                                        else
                                                            QtyToLot := ItemJnalRec.Quantity - TotRecervQty;

                                                        InsertResvEntry(ItemJnalRec."Item No.", ItemJnalRec."Location Code", 83, 5, -QtyToLot, ItemLedEntry."Lot No.",
                                                                false, ItemJnalRec."Posting Date", rec."Journal Template Name", Rec."Journal Batch Name", ItemJnalRec."Line No.", 'C', LineCompleted);
                                                    end;
                                                end;
                                            until ItemLedEntry.Next() = 0;
                                        end;

                                    end;
                                until ProdOrdComp.Next() = 0;
                        until DailyConsumpLine.Next() = 0;
                    end;
                    //else
                    //Message('There is nothing to process');
                    //Window.Close();
                    Commit();
                    ItemJnalRec.Reset();
                    ItemJnalRec.SetRange("Journal Template Name", rec."Journal Template Name");
                    ItemJnlMgt.SetName(rec."Journal Batch Name", ItemJnalRec);
                    ItemJnalRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnalRec.SetRange("Daily Consumption Doc. No.", rec."No.");

                    Page.RunModal(99000846, ItemJnalRec);

                    //CurrPage.Close();
                end;
            }

        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Created UserID", UserId);
    end;

    local procedure InsertResvEntry(PassItemNo: Code[20]; PassLocation: Code[20]; PassSourceType: Integer; PassSubType: Integer; PassQty: Decimal; PassLotNo: Code[50];
              PassPos: Boolean; PassDate: Date; PassSourceID: Text[20]; PassBatch: Text[20]; PassRefNo: Integer; DocT: Code[1]; var Completed: Boolean)
    var
        ResvEntry: Record "Reservation Entry";
        ItemJnal: Record "Item Journal Line";
        ReserveEntry: Record "Reservation Entry";
        ItemRec: Record Item;
        LastEntryNo: Integer;
    begin
        Completed := false;

        ResvEntry.SetCurrentKey("Entry No.");
        if ResvEntry.FindLast() then
            LastEntryNo := ResvEntry."Entry No." + 1
        else
            LastEntryNo := 1;

        ResvEntry.LockTable();

        Clear(ResvEntry);
        ResvEntry.Init();
        ResvEntry."Entry No." := LastEntryNo;
        ResvEntry."Item No." := PassItemNo;
        ItemRec.Get(PassItemNo);
        ResvEntry.Description := ItemRec.Description;
        ResvEntry."Location Code" := PassLocation;
        ResvEntry."Source Type" := PassSourceType;
        ResvEntry."Source Subtype" := PassSubType;
        ResvEntry.Validate("Quantity (Base)", PassQty);
        ResvEntry."Lot No." := PassLotNo;
        ResvEntry.Positive := PassPos;
        if DocT = 'O' then
            ResvEntry."Expected Receipt Date" := PassDate;
        if DocT = 'C' then
            ResvEntry."Shipment Date" := PassDate;
        ResvEntry."Source ID" := PassSourceID;
        ResvEntry."Source Batch Name" := PassBatch;
        ResvEntry."Source Ref. No." := PassRefNo;
        ResvEntry."Creation Date" := Today;
        ResvEntry."Created By" := UserId;
        ResvEntry."Item Tracking" := ResvEntry."Item Tracking"::"Lot No.";
        ResvEntry.validate("Qty. per Unit of Measure", 1);
        ResvEntry."Reservation Status" := ResvEntry."Reservation Status"::Prospect;
        ResvEntry.Insert(true);

        ReserveEntry.RESET;
        ReserveEntry.SETCURRENTKEY("Entry No.");
        ReserveEntry.SetRange("Item No.", ResvEntry."Item No.");
        ReserveEntry.SetRange("Source ID", ResvEntry."Source ID");
        ReserveEntry.SetRange("Source Batch Name", ResvEntry."Source Batch Name");
        ReserveEntry.SetRange("Source Ref. No.", ResvEntry."Source Ref. No.");
        ReserveEntry.CalcSums(Quantity);

        ItemJnal.Get(ResvEntry."Source ID", ResvEntry."Source Batch Name", ResvEntry."Source Ref. No.");
        if Abs(ReserveEntry.Quantity) = ItemJnal.Quantity then
            Completed := true;
    end;
}


