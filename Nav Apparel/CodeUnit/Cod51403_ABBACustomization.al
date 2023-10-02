codeunit 51403 "ABBA Customization"
{
    [EventSubscriber(ObjectType::Table, 5222, 'OnAfterCopyEmployeeLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure UpdateEmpLed(var EmployeeLedgerEntry: Record "Employee Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        EmployeeLedgerEntry."Payment Method Code" := GenJournalLine."Payment Method Code";
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforePostGenJnlLine', '', false, false)]
    local procedure PaymethodValidation(VAR GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    begin
        if GenJournalLine."Journal Template Name" = 'PAYMENTS' then
            GenJournalLine.TestField("Payment Method Code");
    end;

    [EventSubscriber(ObjectType::Table, 25, 'OnAfterCopyVendLedgerEntryFromGenJnlLine', '', false, false)]
    local procedure ChequPrinted(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry."Cheque Printed" := GenJournalLine."Cheque printed";
    end;
}
