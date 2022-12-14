codeunit 71012765 ReservationEntryCodeUnit
{
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnAfterCreateReservEntry', '', false, false)]
    local procedure ItemTrackingLinesOnRegisterChangeOnAfterCreateReservEntry(var ReservEntry: Record "Reservation Entry"; OldTrackingSpecification: Record "Tracking Specification")
    begin
        ReservEntry."Supplier Batch No." := OldTrackingSpecification."Supplier Batch No.";
        ReservEntry."Shade No" := OldTrackingSpecification."Shade No";
        ReservEntry.Shade := OldTrackingSpecification.Shade;
        ReservEntry."Length Tag" := OldTrackingSpecification."Length Tag";
        ReservEntry."Length Act" := OldTrackingSpecification."Length Act";
        ReservEntry."Width Tag" := OldTrackingSpecification."Width Tag";
        ReservEntry."Width Act" := OldTrackingSpecification."Width Act";
        ReservEntry.InvoiceNo := OldTrackingSpecification.InvoiceNo;
        ReservEntry."Color No" := OldTrackingSpecification."Color No";
        ReservEntry.Color := OldTrackingSpecification.Color;
        ReservEntry.Modify();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCopyTrackingSpec', '', false, false)]
    local procedure ItemTrackingLinesOnAfterCopyTrackingSpec(var DestTrkgSpec: Record "Tracking Specification"; var SourceTrackingSpec: Record "Tracking Specification")
    begin
        DestTrkgSpec."Supplier Batch No." := SourceTrackingSpec."Supplier Batch No.";
        DestTrkgSpec."Shade No" := SourceTrackingSpec."Shade No";
        DestTrkgSpec."Shade" := SourceTrackingSpec."Shade";
        DestTrkgSpec."Length Tag" := SourceTrackingSpec."Length Tag";
        DestTrkgSpec."Length Act" := SourceTrackingSpec."Length Act";
        DestTrkgSpec."Width Tag" := SourceTrackingSpec."Width Tag";
        DestTrkgSpec."Width Act" := SourceTrackingSpec."Width Act";
        DestTrkgSpec.InvoiceNo := SourceTrackingSpec.InvoiceNo;
        DestTrkgSpec."Color No" := SourceTrackingSpec."Color No";
        DestTrkgSpec.Color := SourceTrackingSpec.Color;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterEntriesAreIdentical', '', false, false)]
    local procedure ItemTrackingLinesOnAfterEntriesAreIdentical(ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry"; var IdenticalArray: array[2] of Boolean)
    begin

        IdenticalArray[2] := IdenticalArray[2] and (ReservEntry1."Supplier Batch No." = ReservEntry2."Supplier Batch No.");
        IdenticalArray[2] := IdenticalArray[2] and (ReservEntry1."Shade No" = ReservEntry2."Shade No");
        IdenticalArray[2] := IdenticalArray[2] and (ReservEntry1."Shade" = ReservEntry2."Shade");
        IdenticalArray[2] := IdenticalArray[2] and (ReservEntry1."Length Tag" = ReservEntry2."Length Tag");
        IdenticalArray[2] := IdenticalArray[2] and (ReservEntry1."Length Act" = ReservEntry2."Length Act");
        IdenticalArray[2] := IdenticalArray[2] and (ReservEntry1."Width Tag" = ReservEntry2."Width Tag");
        IdenticalArray[2] := IdenticalArray[2] and (ReservEntry1."Width Act" = ReservEntry2."Width Act");
        IdenticalArray[2] := IdenticalArray[2] and (ReservEntry1.InvoiceNo = ReservEntry2.InvoiceNo);
        IdenticalArray[2] := IdenticalArray[2] and (ReservEntry1."Color No" = ReservEntry2."Color No");
        IdenticalArray[2] := IdenticalArray[2] and (ReservEntry1.Color = ReservEntry2.Color);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', false, false)]
    local procedure ItemTrackingLinesOnAfterMoveFields(var ReservEntry: Record "Reservation Entry"; var TrkgSpec: Record "Tracking Specification")
    begin
        ReservEntry."Supplier Batch No." := TrkgSpec."Supplier Batch No.";
        ReservEntry."Shade No" := TrkgSpec."Shade No";
        ReservEntry."Shade" := TrkgSpec."Shade";
        ReservEntry."Length Tag" := TrkgSpec."Length Tag";
        ReservEntry."Length Act" := TrkgSpec."Length Act";
        ReservEntry."Width Tag" := TrkgSpec."Width Tag";
        ReservEntry."Width Act" := TrkgSpec."Width Act";
        ReservEntry.InvoiceNo := TrkgSpec.InvoiceNo;
        ReservEntry."Color No" := TrkgSpec."Color No";
        ReservEntry.Color := TrkgSpec.Color;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertSetupTempSplitItemJnlLine', '', false, false)]
    local procedure ItemJnlPostLineOnBeforeInsertSetupTempSplitItemJnlLine(var TempTrackingSpecification: Record "Tracking Specification"; var TempItemJournalLine: Record "Item Journal Line")
    begin
        TempItemJournalLine."Supplier Batch No." := TempTrackingSpecification."Supplier Batch No.";
        TempItemJournalLine."Shade No" := TempTrackingSpecification."Shade No";
        TempItemJournalLine."Shade" := TempTrackingSpecification."Shade";
        TempItemJournalLine."Length Tag" := TempTrackingSpecification."Length Tag";
        TempItemJournalLine."Length Act" := TempTrackingSpecification."Length Act";
        TempItemJournalLine."Width Tag" := TempTrackingSpecification."Width Tag";
        TempItemJournalLine."Width Act" := TempTrackingSpecification."Width Act";
        TempItemJournalLine.InvoiceNo := TempTrackingSpecification.InvoiceNo;
        TempItemJournalLine."Color No" := TempTrackingSpecification."Color No";
        TempItemJournalLine.Color := TempTrackingSpecification.Color;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure ItemJnlPostLineOnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line")
    begin
        NewItemLedgEntry."Supplier Batch No." := ItemJournalLine."Supplier Batch No.";
        NewItemLedgEntry."Shade No" := ItemJournalLine."Shade No";
        NewItemLedgEntry."Shade" := ItemJournalLine."Shade";
        NewItemLedgEntry."Length Tag" := ItemJournalLine."Length Tag";
        NewItemLedgEntry."Length Act" := ItemJournalLine."Length Act";
        NewItemLedgEntry."Width Tag" := ItemJournalLine."Width Tag";
        NewItemLedgEntry."Width Act" := ItemJournalLine."Width Act";
        NewItemLedgEntry.InvoiceNo := ItemJournalLine.InvoiceNo;
        NewItemLedgEntry."Color No" := ItemJournalLine."Color No";
        NewItemLedgEntry.Color := ItemJournalLine.Color;
    end;


}
