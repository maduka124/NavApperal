page 50700 "Washing Sample Request"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Washing Sample Header";
    CardPageId = "Washing Sample Request Card";
    Caption = 'Washing Requisition';
    SourceTableView = sorting("No.", LineNo) order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Request No';
                    //Visible = false;
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Garment Type Name"; "Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                }

                field("Wash Plant Name"; "Wash Plant Name")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Plant';
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        SampleWasLineRec: Record "Washing Sample Requsition Line";
        Inter1Rec: Record IntermediateTable;
    begin

        //Check whether request has been processed
        SampleWasLineRec.Reset();
        SampleWasLineRec.SetRange("No.", "No.");

        if SampleWasLineRec.FindSet() then begin
            if SampleWasLineRec."Return Qty (BW)" > 0 then
                Error('(BW) Returned quantity updated. Cannot delete the request.');

            if SampleWasLineRec."Req Qty BW QC Pass" > 0 then
                Error('BW quality check has been conpleted. Cannot delete the request.');

            if SampleWasLineRec."Req Qty BW QC Fail" > 0 then
                Error('BW quality check has been conpleted. Cannot delete the request.');

            if SampleWasLineRec."Split Status" = SampleWasLineRec."Split Status"::Yes then
                Error('Request has been split. Cannot delete.');
        end;


        //Check for split lines
        Inter1Rec.Reset();
        Inter1Rec.SetRange(No, "No.");
        if Inter1Rec.FindSet() then
            Error('Request has been split. Cannot delete.');


        //Delete lines
        SampleWasLineRec.Reset();
        SampleWasLineRec.SetRange("No.", "No.");
        if SampleWasLineRec.FindSet() then
            SampleWasLineRec.DeleteAll();
    end;
}