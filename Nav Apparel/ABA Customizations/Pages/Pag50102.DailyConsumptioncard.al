page 50102 "Daily Consumption Card"
{
    Caption = 'Raw Material Requisition Card';
    PageType = Card;
    SourceTable = "Daily Consumption Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Department Name"; rec."Department Name")
                {
                    ApplicationArea = All;
                }
                field("Buyer Code"; Rec."Buyer Code")
                {
                    ApplicationArea = All;
                }
                field(Buyer; Rec.Buyer)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Style No."; Rec."Style No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        rec."Style No." := rec."Style Name";
                    end;
                }
                field(PO; Rec.PO)
                {
                    ApplicationArea = All;
                }
                field("Main Category"; Rec."Main Category")
                {
                    ApplicationArea = All;
                }
                field("Main Category Name"; Rec."Main Category Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Colour No."; rec."Colour No.")
                {
                    ApplicationArea = All;
                }
                field("Colour Name"; rec."Colour Name")
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
                    Editable = false;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
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
            }
            part(Lines; "Daily Consumption Subform")
            {
                ApplicationArea = All;
                Enabled = rec."Prod. Order No." <> '';
                UpdatePropagation = Both;
                SubPageLink = "Document No." = field("No.");
            }
            part("Daily Requirement"; "Daily Requirement")
            {
                ApplicationArea = All;
                Visible = true;
                Enabled = true;
                //Enabled = rec."Journal Batch Name" <> '';
                UpdatePropagation = Both;
                SubPageLink = "Journal Template Name" = field("Journal Template Name"), "Journal Batch Name" = field("Journal Batch Name"), "Daily Consumption Doc. No." = field("No.");
            }
            part("Posted Daily Requirement"; "Posted Consumptions")
            {
                ApplicationArea = All;
                Visible = Vis2;
                //Enabled = rec."Journal Batch Name" <> '';
                UpdatePropagation = Both;
                SubPageLink = "Daily Consumption Doc. No." = field("No."), "Entry Type" = filter(Consumption);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(SendApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Image = SendApprovalRequest;
                Caption = 'Send Approval Request';
                Promoted = true;
                PromotedCategory = Process;
                Visible = not BooVis;
                trigger OnAction()
                var
                    ItemJnalLine: Record "Item Journal Line";
                    UserSetup: Record "User Setup";
                begin
                    Rec.TestField(Status, rec.Status::Open);
                    ItemJnalLine.Reset();
                    ItemJnalLine.SetRange("Journal Template Name", rec."Journal Template Name");
                    ItemJnalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnalLine.SetRange("Daily Consumption Doc. No.", Rec."No.");
                    if not ItemJnalLine.FindFirst() then
                        Error('There is nothing to send');

                    UserSetup.Get(UserId);

                    Sleep(500);
                    Rec.Status := Rec.Status::"Pending Approval";
                    if UserSetup."Daily Requirement Approver" = '' then
                        Error('Approval user not found');

                    Rec."Approver UserID" := UserSetup."Daily Requirement Approver";
                    Rec.Modify();
                end;
            }
            action(CancelApprovalRequest)
            {
                ApplicationArea = Basic, Suite;
                Image = CancelApprovalRequest;
                Caption = 'Cancel Approval Request';
                Promoted = true;
                PromotedCategory = Process;
                Visible = not BooVis;
                trigger OnAction()
                var
                    ItemJnalLine: Record "Item Journal Line";
                begin
                    Rec.TestField(Status, rec.Status::"Pending Approval");

                    Sleep(500);
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                end;
            }
            action(Approve)
            {
                Image = Approve;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Approve';
                Visible = BooVis;
                trigger OnAction()
                var
                    ItemJnalLine: Record "Item Journal Line";
                    UserSetup: Record "User Setup";
                    AppOK: Boolean;
                begin
                    AppOK := false;
                    UserSetup.Get(UserId);
                    if not UserSetup."Consumption Approve" then
                        Error('You do not have permission to perform this action');

                    Rec.TestField(Status, Rec.Status::"Pending Approval");
                    Sleep(500);

                    ItemJnalLine.Reset();
                    ItemJnalLine.SetRange("Journal Template Name", rec."Journal Template Name");
                    ItemJnalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJnalLine.SetRange("Daily Consumption Doc. No.", Rec."No.");
                    if ItemJnalLine.FindFirst() then
                        repeat
                            ItemJnalLine.validate("Line Approved", true);
                            ItemJnalLine.Modify();
                            AppOK := true;
                        until ItemJnalLine.Next() = 0;
                    Commit();
                    if AppOK then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec."Approved UserID" := UserId;
                        Rec."Approved Date/Time" := CurrentDateTime;
                        Rec.Modify();
                    end;
                end;
            }
            action(Reject)
            {
                Image = Reject;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Reject';
                Visible = BooVis;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);
                    if not UserSetup."Consumption Approve" then
                        Error('You do not have permission to perform this action');

                    Rec.TestField(Status, Rec.Status::"Pending Approval");
                    Sleep(500);
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify();
                end;
            }
            action("Calculate Consumption")
            {
                Image = CalculateConsumption;
                ApplicationArea = Basic, Suite;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Calculate Requirement';
                Visible = not BooVis;
                trigger OnAction()
                var
                    CalConsump: Report "Calc. Consumption";
                    ItemJnalRec: Record "Item Journal Line";
                    ProdOrdComp: Record "Prod. Order Component";
                    DailyConsumpLine: Record "Daily Consumption Line";
                    ProdOrderLine: Record "Prod. Order Line";
                    ProdOrderRec: Record "Production Order";
                    ItemLedEntry: Record "Item Ledger Entry";
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

                begin
                    Inx1 := 0;
                    PostNo := '';

                    Window.Open(Text000 +
                                    Text001 +
                                    Text002 +
                                    Text003);

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

                    Window.Update(1, rec."Prod. Order No.");
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
                                    LineCompleted := false;
                                    QtyToLot := 0;
                                    TotRecervQty := 0;
                                    if LastLNo <> 0 then
                                        Inx1 := LastLNo;

                                    ItemLedEntry.Reset();
                                    ItemLedEntry.SetCurrentKey("Location Code", "Item No.");
                                    ItemLedEntry.SetRange("Item No.", ProdOrdComp."Item No.");
                                    ItemLedEntry.SetRange("Location Code", ProdOrdComp."Location Code");
                                    ItemLedEntry.CalcSums(Quantity);

                                    Window.Update(2, ProdOrdComp."Item No.");
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
                                    if (ProdOrdComp."Quantity per" * DailyConsumpLine."Daily Consumption") > ProdOrdComp."Remaining Quantity" then
                                        ItemJnalRec.Validate(Quantity, ProdOrdComp."Remaining Quantity")
                                    else
                                        ItemJnalRec.Validate(Quantity, (ProdOrdComp."Quantity per" * DailyConsumpLine."Daily Consumption"));
                                    Window.Update(3, ItemJnalRec.Quantity);
                                    ItemJnalRec."Original Daily Requirement" := ItemJnalRec.Quantity;
                                    ItemJnalRec."Stock After Issue" := ItemLedEntry.Quantity - ItemJnalRec.Quantity;
                                    //Mihiranga 2022/01/16
                                    ItemJnalRec."Request Qty" := ItemJnalRec.Quantity;
                                    ItemJnalRec.Validate("Variant Code", ProdOrdComp."Variant Code");
                                    ItemJnalRec.Validate("Location Code", ProdOrdComp."Location Code");
                                    ItemJnalRec.Description := ProdOrdComp.Description;
                                    ItemJnalRec.Validate("Unit of Measure Code", ProdOrdComp."Unit of Measure Code");
                                    ItemJnalRec.Validate("Prod. Order Comp. Line No.", ProdOrdComp."Line No.");
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

                                until ProdOrdComp.Next() = 0;
                        until DailyConsumpLine.Next() = 0;
                    end
                    else
                        Message('There is nothing to process');

                    Window.Close();
                    //CurrPage.Close();
                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        ItemJnalRec: Record "Item Journal Line";
        ItemLedRec: Record "Item Ledger Entry";

    begin
        Vis1 := false;


        UserSetup.Get(UserId);
        if not UserSetup."Consumption Approve" then
            BooVis := false
        else
            BooVis := true;

        // ItemJnalRec.Reset();
        // ItemJnalRec.SetRange("Journal Template Name", rec."Journal Template Name");
        // ItemJnalRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        // ItemJnalRec.SetRange("Daily Consumption Doc. No.", Rec."No.");
        // if ItemJnalRec.FindFirst() then
        //     Vis1 := true;
    end;

    trigger OnAfterGetCurrRecord()
    var
        ItemLedRec: Record "Item Ledger Entry";
    begin
        Vis2 := false;
        ItemLedRec.Reset();
        ItemLedRec.SetRange("Entry Type", ItemLedRec."Entry Type"::Consumption);
        ItemLedRec.SetRange("Daily Consumption Doc. No.", rec."No.");
        if ItemLedRec.FindFirst() then
            Vis2 := true;
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

    var
        BooVis: Boolean;
        Vis1: Boolean;
        Vis2: Boolean;
}
