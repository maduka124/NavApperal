page 50101 "Daily Consumption List "
{
    ApplicationArea = All;
    Caption = 'Raw Material Requisition List';
    PageType = List;
    SourceTable = "Daily Consumption Header";
    SourceTableView = sorting("No.") order(descending);
    UsageCategory = Lists;
    CardPageId = "Daily Consumption Card";
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


    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId);
        if UserSetup.UserRole <> 'STORE USER' then BEGIN
            if not UserSetup."Consumption Approve" then
                Rec.SetRange("Created UserID", UserId);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        DailyConsumptionLine: Record "Daily Consumption Line";
        ItemJournalLine: Record "Item Journal Line";
        ItemJrnlLineTempRec: Record ItemJournalLinetemp;
    begin
        if rec.Status = rec.Status::Approved then
            Error('Request already approved. Cannot delete.');

        if rec.Status = rec.Status::"Pending Approval" then
            Error('Request already sent for approval. Cannot delete.');

        if rec.Status = rec.Status::Open then begin
            DailyConsumptionLine.Reset();
            DailyConsumptionLine.SetRange("Document No.", rec."No.");
            if DailyConsumptionLine.FindSet() then
                DailyConsumptionLine.DeleteAll();

            ItemJournalLine.SetRange("Journal Template Name", Rec."Journal Template Name");
            ItemJournalLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
            ItemJournalLine.SetFilter("Entry Type", '=%1', ItemJournalLine."Entry Type"::Consumption);
            ItemJournalLine.SetRange("Daily Consumption Doc. No.", rec."No.");
            if ItemJournalLine.FindSet() then
                ItemJournalLine.DeleteAll();

            ItemJrnlLineTempRec.SetRange("Journal Template Name", Rec."Journal Template Name");
            ItemJrnlLineTempRec.SetRange("Journal Batch Name", Rec."Journal Batch Name");
            ItemJrnlLineTempRec.SetRange("Daily Consumption Doc. No.", rec."No.");
            if ItemJrnlLineTempRec.FindSet() then
                ItemJrnlLineTempRec.DeleteAll();
        end;

    end;


    local procedure InsertResvEntry(PassItemNo: Code[20]; PassLocation: Code[20]; PassSourceType: Integer; PassSubType: Integer; PassQty: Decimal; PassLotNo: Code[50];
             PassPos: Boolean; PassDate: Date; PassSourceID: Text[20]; PassBatch: Text[20]; PassRefNo: Integer; DocT: Code[1]; var Completed: Boolean;
             PassShade: text[20]; PassShadeNo: code[20]; PassWidthAct: Decimal; PassWidthTag: Decimal; PassLengthAct: Decimal; PassLengthTag: Decimal;
             PassSupplierBatchNo: code[50]; PassInvoiceNo: Code[20]; PassColor: code[20]; PassColorNo: code[20])
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
        ResvEntry.Shade := PassShade;
        ResvEntry."Shade No" := PassShadeNo;
        ResvEntry."Width Act" := PassWidthAct;
        ResvEntry."Width Tag" := PassWidthTag;
        ResvEntry."Length Act" := PassLengthAct;
        ResvEntry."Length Tag" := PassLengthTag;
        ResvEntry."Supplier Batch No." := PassSupplierBatchNo;
        ResvEntry.InvoiceNo := PassInvoiceNo;
        ResvEntry.Color := PassColor;
        ResvEntry."Color No" := PassColorNo;
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
