codeunit 50607 "Journal Approval"
{
    trigger OnRun()
    begin

    end;

    var
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendGeneralJournalBatchForApproval', '', false, false)]
    local procedure UpdateStatusJnlBatch(var GenJournalBatch: Record "Gen. Journal Batch")
    var
        GenJnlLine: Record "Gen. Journal Line";
        Balance: Decimal;
    begin
        GenJnlLine.Reset();
        GenJnlLine.SETRANGE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJnlLine.SETRANGE("Journal Batch Name", GenJournalBatch.Name);
        GenJnlLine.CALCSUMS("Balance (LCY)");
        Balance := GenJnlLine."Balance (LCY)";
        if Balance = 0 then begin
            GenJnlLine.Reset();
            GenJnlLine.SETRANGE("Journal Template Name", GenJournalBatch."Journal Template Name");
            GenJnlLine.SetRange("Journal Batch Name", GenJournalBatch.Name);
            if GenJnlLine.FindSet then
                repeat
                    if GenJnlLine.Status <> GenJnlLine.Status::Released then begin
                        GenJnlLine.Status := GenJnlLine.Status::"Pending Approval";
                        GenJnlLine.Modify;
                    end;
                until GenJnlLine.Next = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendGeneralJournalLineForApproval', '', false, false)]
    local procedure UpdateStatusJnlLine(var GenJournalLine: Record "Gen. Journal Line")
    var
        CopyGenJnl: Record "Gen. Journal Line";
    begin
        CopyGenJnl.Reset();
        CopyGenJnl.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        CopyGenJnl.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        CopyGenJnl.SetRange("Line No.", GenJournalLine."Line No.");
        if CopyGenJnl.FindFirst then begin
            if CopyGenJnl.Status <> CopyGenJnl.Status::Released then begin
                CopyGenJnl.Status := CopyGenJnl.Status::"Pending Approval";
                CopyGenJnl.Modify;
                // Message('Test');
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure UpdateRejectStatus(var ApprovalEntry: Record "Approval Entry")
    var
        RecRef: RecordRef;
        genjnl: Record "Gen. Journal Line";
    begin
        //with ApprovalEntry do begin
        if not RecRef.Get(ApprovalEntry."Record ID to Approve") then
            exit;
        RejectApproval(RecRef, ApprovalEntry."Table ID");
        //end;
    end;

    local procedure RejectApproval(RecRelatedVariant: Variant; TabId: Integer)
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        DataTypeManagement: Codeunit "Data Type Management";
        RecRef: RecordRef;
    begin
        if not GuiAllowed then
            exit;
        if not DataTypeManagement.GetRecordRef(RecRelatedVariant, RecRef) then
            exit;
        if TabId = 232 then begin
            RecRef.SetTable(GenJournalBatch);
            GenJournalLine.Reset();
            GenJournalLine.SetRange("Journal Template Name", GenJournalBatch."Journal Template Name");
            GenJournalLine.SetRange("Journal Batch Name", GenJournalBatch.Name);
            GenJournalLine.SetRange(Status, GenJournalLine.Status::"Pending Approval");
            if GenJournalLine.FindFirst then
                repeat
                    GenJournalLine.Status := GenJournalLine.Status::Open;
                    GenJournalLine.Modify;

                until GenJournalLine.Next = 0;
        end;
        if TabId = 81 then begin
            GenJournalLine.Reset();
            GenJournalLine.SetRange(Status, GenJournalLine.Status::"Pending Approval");
            RecRef.SetTable(GenJournalLine);
            GenJournalLine.Status := GenJournalLine.Status::Open;
            GenJournalLine.Modify;
            ;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure ReleaseDocument(RecRef: RecordRef; VAR Handled: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
        genjnl: Record "Gen. Journal Line";
        TargetRecRef: RecordRef;
    begin
        // Message('Test Before Triger');
        CASE RecRef.Number OF
            Database::"Gen. Journal Line":
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetFilter("Table ID", '%1', RecRef.Number);
                    ApprovalEntry.SetFilter("Record ID to Approve", '%1', RecRef.RecordId);
                    if ApprovalEntry.FindFirst() then begin
                        ApproveBatch(RecRef, ApprovalEntry."Table ID");
                        Handled := true;
                        // Message('ApproveBatch = Doc No = %1', ApprovalEntry."Document No.");
                    end;
                end;
            Database::"Gen. Journal Batch":
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetFilter("Table ID", '%1', RecRef.Number);
                    ApprovalEntry.SetFilter("Record ID to Approve", '%1', RecRef.RecordId);
                    if ApprovalEntry.FindFirst() then begin
                        ApproveBatch(RecRef, ApprovalEntry."Table ID");
                        Handled := true;
                    end;
                end;
        end;
    end;

    local procedure ApproveBatch(RecRelatedVariant: Variant; TabId: Integer)
    var
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        CopyGenJnlLine: Record "Gen. Journal Line";
        DataTypeManagement: Codeunit "Data Type Management";
        RecRef: RecordRef;
        RecID: RecordId;
    begin
        if not GuiAllowed then
            exit;
        if not DataTypeManagement.GetRecordRef(RecRelatedVariant, RecRef) then
            exit;

        if TabId = 232 then begin
            RecRef.SetTable(GenJournalBatch);
            GenJournalLine.Reset();
            GenJournalLine.SetRange("Journal Template Name", GenJournalBatch."Journal Template Name");
            GenJournalLine.SetRange("Journal Batch Name", GenJournalBatch.Name);
            GenJournalLine.SetRange(Status, GenJournalLine.Status::"Pending Approval");
            if GenJournalLine.FindFirst then
                repeat
                    GenJournalLine.Status := GenJournalLine.Status::Released;
                    GenJournalLine.Modify;
                // Message('ApproveBatch = Doc No = %1', GenJournalLine."Document No.");
                until GenJournalLine.Next = 0;
        end;
        if TabId = 81 then begin
            GenJournalLine.Reset();
            GenJournalLine.SetRange(Status, GenJournalLine.Status::"Pending Approval");
            RecRef.SetTable(GenJournalLine);
            CopyGenJnlLine.Reset();
            CopyGenJnlLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
            CopyGenJnlLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
            CopyGenJnlLine.SetRange("Line No.", GenJournalLine."Line No.");
            if CopyGenJnlLine.FindFirst then begin
                CopyGenJnlLine.Status := CopyGenJnlLine.Status::Released;
                CopyGenJnlLine.Modify;
                // Message('ApproveBatch = Doc No = %1', GenJournalLine."Document No.");

            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelGeneralJournalBatchApprovalRequest', '', false, false)]
    local procedure UpdateCancelStatusBatch(var GenJournalBatch: Record "Gen. Journal Batch")
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.Reset();
        GenJnlLine.SETRANGE("Journal Template Name", GenJournalBatch."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", GenJournalBatch.Name);
        if GenJnlLine.FindSet then
            repeat
                GenJnlLine.Status := GenJnlLine.Status::Open;
                GenJnlLine.Modify;
            until GenJnlLine.Next = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelGeneralJournalLineApprovalRequest', '', false, false)]
    local procedure UpdateCancelStatusLine(var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine.Status := GenJournalLine.Status::Open;
        GenJournalLine.Modify;
    end;

    procedure ManualReleaseBatch(var GenJournalLine: Record "Gen. Journal Line")
    var
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GetGeneralJournalBatch(GenJournalBatch, GenJournalLine);
        if not CheckGeneralJournalBatchApprovalsWorkflowEnabled(GenJournalBatch) then begin
            GenJnlLine.Reset();
            GenJnlLine.SetRange("Journal Template Name", GenJournalBatch."Journal Template Name");
            GenJnlLine.SetRange("Journal Batch Name", GenJournalBatch."Name");
            GenJnlLine.FindSet;
            repeat
                GenJnlLine.Status := GenJnlLine.Status::Released;
                GenJnlLine.Modify(true);
            // Message('ManualReleaseBatch = Doc No = %1', GenJournalLine."Document No.");

            until GenJnlLine.Next = 0;
        end
        else
            Error('Approval workflow for this record is enabled.');
    end;

    procedure GetGeneralJournalBatch(var GenJournalBatch: Record "Gen. Journal Batch"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        if not GenJournalBatch.Get(GenJournalLine."Journal Template Name", GenJournalLine."Journal Batch Name") then
            GenJournalBatch.Get(GenJournalLine.GetFilter("Journal Template Name"), GenJournalLine.GetFilter("Journal Batch Name"));
    end;

    procedure CheckGeneralJournalBatchApprovalsWorkflowEnabled(var GenJournalBatch: Record "Gen. Journal Batch"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        if not
            WorkflowManagement.CanExecuteWorkflow(GenJournalBatch,
                WorkflowEventHandling.RunWorkflowOnSendGeneralJournalBatchForApprovalCode)
        then
            exit(false);

        exit(true);
    end;

    procedure CheckPendingApprovalsForGenJnlBatch(JnlTemplateName: Code[10]; JnlBtchName: Code[10])
    var
        ApprovalEntry: Record "Approval Entry";
        GenJournalBatch: Record "Gen. Journal Batch";
        RecRef: RecordRef;
        ResultRecRef: RecordRef;
        RecRelatedVariant: Variant;
        DataTypeManagement: Codeunit "Data Type Management";
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Table ID", 232);
        if ApprovalEntry.FindSet then
            repeat
                GenJournalBatch.Reset();
                Clear(RecRelatedVariant);
                if RecRef.Get(ApprovalEntry."Record ID to Approve") then begin
                    RecRelatedVariant := RecRef;
                    if DataTypeManagement.GetRecordRef(RecRelatedVariant, ResultRecRef) then begin
                        ResultRecRef.SetTable(GenJournalBatch);
                        if (GenJournalBatch."Journal Template Name" = JnlTemplateName)
                                and (GenJournalBatch.Name = JnlBtchName) then
                            Error('Batch should be approved first');
                    end;
                end;
            until ApprovalEntry.Next = 0;
    end;

    procedure OpenRecord(RecRelatedVariant: Variant; TabId: Integer)
    var
        GenJournalLine: Record "Gen. Journal Line";
        CopyGenJournalLine: Record "Gen. Journal Line";
        PayJnlPage: Page "Payment Journal";
        DataTypeManagement: Codeunit "Data Type Management";
        PageMgt: Codeunit "Page Management";
        PageID: Integer;
        RecRef: RecordRef;
        PayJnl: Page "Payment Journal";
    begin
        PageID := 0;
        if not GuiAllowed then
            exit;
        if not DataTypeManagement.GetRecordRef(RecRelatedVariant, RecRef) then
            exit;
        PageID := PageMgt.GetPageID(RecRef);
        if TabId = 81 then begin
            RecRef.SetTable(GenJournalLine);
            CopyGenJournalLine.Reset();
            CopyGenJournalLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
            CopyGenJournalLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
            CopyGenJournalLine.SetRange("Document No.", GenJournalLine."Document No.");
            if CopyGenJournalLine.FindSet then
                Page.Run(PageID, CopyGenJournalLine);
        end;
    end;

    procedure CheckGeneralJournalLineApprovalWorkflowEnabled(var GenJournalLine: Record "Gen. Journal Line"): Boolean
    var
        WorkflowManagement: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
    begin
        if not
            WorkflowManagement.CanExecuteWorkflow(GenJournalLine,
                WorkflowEventHandling.RunWorkflowOnSendGeneralJournalLineForApprovalCode)
        then
            exit(false);

        exit(true);

    end;

    procedure ManualReleaseLines(var GenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        if not CheckGeneralJournalLineApprovalWorkflowEnabled(GenJournalLine) then begin
            GenJnlLine.Copy(GenJournalLine);
            GenJnlLine.FindSet;
            repeat
                GenJnlLine.Status := GenJnlLine.Status::Released;
                GenJnlLine.Modify(true);
            // Message('ManualReleaseBatch Procdr = Doc No = %1', GenJournalLine."Document No.");

            until GenJnlLine.Next = 0;
        end
        else
            Error('Approval workflow for this record is enabled.');
    end;

    procedure CheckGenJnlLine(var GenJnlLine: Record "Gen. Journal Line")
    var
    begin
        GenJnlLine.FindSet;
        repeat
            GenJnlLine.TestField(Status, GenJnlLine.Status::Released);
        until GenJnlLine.Next = 0;
    end;

    procedure ManualReOpenBatch(var GenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        GenJnlLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        GenJnlLine.FindSet;
        repeat
            if GenJnlLine.Status in [GenJnlLine.Status::Released] then begin

            end
            else
                Error('Status must be equal to "Released"');
        until GenJnlLine.Next = 0;
        GenJnlLine.FindFirst;
        repeat
            GenJnlLine.Status := GenJnlLine.Status::Open;
            GenJnlLine.Modify(true);
        until GenJnlLine.Next = 0;
    end;

    procedure ManualReOpenLines(var GenJournalLine: Record "Gen. Journal Line")
    var
        GenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine.Copy(GenJournalLine);
        GenJnlLine.FindSet;
        repeat
            if GenJnlLine.Status in [GenJnlLine.Status::Released] then begin

            end
            else
                Error('Status must be equal to "Released"');
        until GenJnlLine.Next = 0;
        GenJnlLine.FindFirst;
        repeat
            GenJnlLine.Status := GenJnlLine.Status::Open;
            GenJnlLine.Modify(true);
        until GenJnlLine.Next = 0;
    end;

    procedure CheckFilter(var GenJnlLineSlctn: Record "Gen. Journal Line"; var GenJnlLineRec: Record "Gen. Journal Line")
    var
        GenJnlLineSlctnCopy: Record "Gen. Journal Line";
        GenJnlLineRecCopy: Record "Gen. Journal Line";
    begin
        GenJnlLineSlctnCopy.COPY(GenJnlLineSlctn);
        GenJnlLineRecCopy.COPY(GenJnlLineRec);
        GenJnlLineSlctn.FindSet;
        REPEAT
            GenJnlLineSlctnCopy.SETRANGE("Document No.", GenJnlLineSlctn."Document No.");
            GenJnlLineRecCopy.SETRANGE("Document No.", GenJnlLineSlctn."Document No.");
            IF GenJnlLineSlctnCopy.COUNT <> GenJnlLineRecCopy.COUNT THEN
                ERROR('Unable to process.\Please select all lines of document no. %1', GenJnlLineSlctn."Document No.");
        UNTIL GenJnlLineSlctn.NEXT = 0;
    end;

    [EventSubscriber(ObjectType::Codeunit, 1535, 'OnApproveApprovalRequest', '', true, true)]
    local procedure test(var ApprovalEntry: Record "Approval Entry")
    var
        GenJournalLine: Record "Gen. Journal Line";
        RecRef: RecordRef;
        GenJournalBatch: Record "Gen. Journal Batch";
        CopyGenJnlLine: Record "Gen. Journal Line";
    begin
        // Message('Test Release');
        if ApprovalEntry.Status = ApprovalEntry.Status::Approved then begin
            if ApprovalEntry."Table ID" = 232 then begin
                //RecRef.SetTable(GenJournalBatch);
                GenJournalLine.Reset();
                GenJournalLine.SetRange("Journal Template Name", GenJournalBatch."Journal Template Name");
                GenJournalLine.SetRange("Journal Batch Name", GenJournalBatch.Name);
                GenJournalLine.SetRange(Status, GenJournalLine.Status::"Pending Approval");
                if GenJournalLine.FindFirst then
                    repeat
                        GenJournalLine.Status := GenJournalLine.Status::Released;
                        GenJournalLine.Modify;
                    // Message('ApproveBatch = Doc No = %1', GenJournalLine."Document No.");
                    until GenJournalLine.Next = 0;
            end;
            if ApprovalEntry."Table ID" = 81 then begin
                //GenJournalLine.SetFilter(GenJournalLine.RecordId,ApprovalEntry."Record ID to Approve");
                GenJournalLine.Reset();
                GenJournalLine.SetRange(Status, GenJournalLine.Status::"Pending Approval");
                if GenJournalLine.FindFirst() then begin
                    repeat
                        //RecRef.SetTable(GenJournalLine);
                        if GenJournalLine.RecordId = ApprovalEntry."Record ID to Approve" then begin
                            CopyGenJnlLine.Reset();
                            CopyGenJnlLine.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
                            CopyGenJnlLine.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
                            CopyGenJnlLine.SetRange("Line No.", GenJournalLine."Line No.");
                            if CopyGenJnlLine.FindFirst then begin
                                CopyGenJnlLine.Status := CopyGenJnlLine.Status::Released;
                                CopyGenJnlLine.Modify;
                                // Message('ApproveLine = Doc No = %1', GenJournalLine."Document No.");
                            end;
                        end;
                    until GenJournalLine.Next() = 0;
                end;
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, 22, 'OnAfterInitItemLedgEntry', '', true, true)]
    local procedure UpdateItemLedEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line")
    begin
        NewItemLedgEntry."Style No." := ItemJournalLine."Style No.";
        NewItemLedgEntry.PO := ItemJournalLine.PO;
        NewItemLedgEntry."Lot No." := ItemJournalLine."Lot No.";
        // NewItemLedgEntry."CP Req No" := ItemJournalLine."CP Req No";
    end;

}