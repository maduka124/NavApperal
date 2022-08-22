codeunit 50735 ExcelUplaod
{
    trigger OnRun()
    begin
        ImportJobJournalExcel();
    end;

    procedure ImportJobJournalExcel()
    begin

        Rec_ExcelBuffer.DeleteAll();
        Rows := 0;
        DialogCaption := 'Select an excel file to upload';
        UploadResult := UploadIntoStream(DialogCaption, '', '', Name, NVInStream);

        If Name <> '' then
            Sheetname := Rec_ExcelBuffer.SelectSheetsNameStream(NVInStream)
        else
            exit;

        Rec_ExcelBuffer.Reset();
        Rec_ExcelBuffer.OpenBookStream(NVInStream, Sheetname);
        Rec_ExcelBuffer.ReadSheet();
        Commit();

        //finding total number of Rows to Import
        Rec_ExcelBuffer.Reset();
        Rec_ExcelBuffer.SetRange("Column No.", 1);

        If Rec_ExcelBuffer.FindFirst() then
            repeat
                Rows := Rows + 1;
            until Rec_ExcelBuffer.Next() = 0;

        NextNo := 1;

        //Update Header No field
        WorkSheetHeadRec.Reset();
        if WorkSheetHeadRec.Findset() then begin
            WorkSheetHeadRec."No." := NextNo;
            WorkSheetHeadRec.Modify()
        end;

        //Delete old records
        SrWrkSheetRec.Reset();
        SrWrkSheetRec.FindSet();
        SrWrkSheetRec.DeleteAll();

        for RowNo := 2 to Rows do begin

            ServiceItem.Reset();
            ServiceItem.SetRange("No.", GetValueAtIndex(RowNo, 1));
            if ServiceItem.FindSet() then
                ServiceItemDesc := ServiceItem.Description
            else
                ServiceItemDesc := '';

            WorkCenterRec.Reset();
            WorkCenterRec.SetRange("No.", GetValueAtIndex(RowNo, 2));
            if WorkCenterRec.FindSet() then
                WorkCenterName := WorkCenterRec.Name
            else
                WorkCenterName := '';

            StServiceCodeRec.Reset();
            StServiceCodeRec.SetRange(code, GetValueAtIndex(RowNo, 4));
            if StServiceCodeRec.FindSet() then
                StServiceCodeDesc := StServiceCodeRec.Description
            else
                StServiceCodeDesc := '';

            //Insert record
            SrWrkSheetRec.Init();
            SrWrkSheetRec."No." := NextNo;
            SrWrkSheetRec."Service Item No" := GetValueAtIndex(RowNo, 1);
            SrWrkSheetRec."Service Item Name" := ServiceItemDesc;
            SrWrkSheetRec."Work Center No" := GetValueAtIndex(RowNo, 2);
            SrWrkSheetRec."Work Center Name" := WorkCenterName;
            SrWrkSheetRec."Standard Service Code" := GetValueAtIndex(RowNo, 4);
            SrWrkSheetRec."Standard Service Desc" := StServiceCodeDesc;
            SrWrkSheetRec."Doc No" := GetValueAtIndex(RowNo, 5);
            SrWrkSheetRec.Remarks := GetValueAtIndex(RowNo, 6);

            Evaluate(Approval, GetValueAtIndex(RowNo, 7));
            SrWrkSheetRec.Approval := Approval;

            Evaluate(TxtDate, GetValueAtIndex(RowNo, 3));
            Evaluate(ServiceDate, CopyStr(TxtDate, 1, 2) + CopyStr(TxtDate, 4, 2) + CopyStr(TxtDate, 7, 4));
            SrWrkSheetRec."Service Date" := ServiceDate;

            SrWrkSheetRec."Created User" := UserId;
            SrWrkSheetRec."Created Date" := WorkDate();
            SrWrkSheetRec.Insert();

        end;

        Message('Import Completed');

    end;

    local procedure GetValueAtIndex(RowNo: Integer; ColNo: Integer): Text
    var
        Rec_ExcelBuffer: Record "Excel Buffer";
    begin
        Rec_ExcelBuffer.Reset();

        If Rec_ExcelBuffer.Get(RowNo, ColNo) then
            exit(Rec_ExcelBuffer."Cell Value as Text");
    end;

    var
        Rec_ExcelBuffer: Record "Excel Buffer";
        ServiceItem: Record "Service Item";
        WorkCenterRec: Record "Work Center";
        StServiceCodeRec: Record "Standard Service Code";
        WorkSheetHeadRec: Record ServiceWorksheetHeader;
        ServiceItemDesc: Text[100];
        WorkCenterName: Text[100];
        StServiceCodeDesc: Text[100];
        Approval: Boolean;
        Rows: Integer;
        UploadIntoStream: InStream;
        Sheetname: Text;
        UploadResult: Boolean;
        DialogCaption: Text;
        Name: Text;
        NVInStream: InStream;
        SrWrkSheetRec: Record ServiceWorksheet;
        RowNo: Integer;
        NextNo: Integer;
        ServiceDate: date;
        TxtDate: text[20];
}
