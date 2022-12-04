page 50819 "Split Sample Requests List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Washing Sample Requsition Line";
    SourceTableView = sorting("Split Status") order(ascending);
    CardPageId = "Job Creation Card";
    Caption = 'Split Sample Requests';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }

                field("Req Date"; rec."Req Date")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Wash Plant Name"; rec."Wash Plant Name")
                {
                    ApplicationArea = All;
                    Caption = 'Washing Plant';
                }

                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Fabric Description"; rec."Fabric Description")
                {
                    ApplicationArea = All;
                }

                field("Req Qty BW QC Pass"; rec."Req Qty BW QC Pass")
                {
                    ApplicationArea = All;
                    Caption = 'Qty';
                }

                field("BW QC Date"; rec."BW QC Date")
                {
                    ApplicationArea = All;
                    Caption = 'BW Quality Check Date';
                }

                field("Split Status"; rec."Split Status")
                {
                    ApplicationArea = All;
                }

                field("Washing Status"; rec."Washing Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        JobcreationRec: Record JobCreationLine;
        Inter1Rec: Record IntermediateTable;
    begin
        if rec."Split Status" = rec."Split Status"::Yes then
            Error('This job creation already posted. Cannot delete.');

        JobcreationRec.Reset();
        JobcreationRec.SetRange(No, rec."No.");
        JobcreationRec.SetRange("Line No", rec."Line no.");

        if JobcreationRec.FindSet() then
            JobcreationRec.DeleteAll();

        Inter1Rec.Reset();
        Inter1Rec.SetRange(No, rec."No.");
        Inter1Rec.SetRange("Line No", rec."Line no.");

        if Inter1Rec.FindSet() then
            Inter1Rec.DeleteAll();
    end;
}