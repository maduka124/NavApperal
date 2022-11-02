report 50710 WashSampleReqReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Washing Requisition Report';
    RDLCLayout = 'Report_Layouts/Washing/WashingSampleReqReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Washing Sample Header"; "Washing Sample Header")
        {
            DataItemTableView = sorting("No.") order(descending);
            column(No_; "No.")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Sample_Bulk; "Sample/Bulk")
            { }
            column(Style_Name; "Style Name")
            { }
            column(Sample_Req__No; "Sample Req. No")
            { }
            column(Request_From; "Request From")
            { }
            column(Garment_Type_Name; "Garment Type Name")
            { }
            column(Wash_Plant_Name; "Wash Plant Name")
            { }
            column(PO_No; "PO No")
            { }
            column(Req_Date; "Req Date")
            { }
            column(Comment; Comment)
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem("Washing Sample Requsition Line"; "Washing Sample Requsition Line")
            {
                DataItemLinkReference = "Washing Sample Header";
                DataItemLink = "No." = field("No.");

                column(SampleType; SampleType)
                { }
                column(Wash_Type; "Wash Type")
                { }
                column(Fabric_Description; "Fabric Description")
                { }
                column(Color_Name; "Color Name")
                { }
                column(Size; Size)
                { }
                column(Req_Qty; "Req Qty")
                { }
                column(Unite_Price; "Unite Price")
                { }
                column(Value; Value)
                { }
                column(Req_Qty_BW_QC_Fail; "Req Qty BW QC Fail")
                { }
                column(Req_Qty_BW_QC_Pass; "Req Qty BW QC Pass")
                { }
                column(Return_Qty__BW_; "Return Qty (BW)")
                { }
                column(QC_Date__AW_; "QC Date (AW)")
                { }
                column(QC_Pass_Qty__AW_; "QC Pass Qty (AW)")
                { }
                column(QC_Fail_Qty__AW_; "QC Fail Qty (AW)")
                { }
                column(Return_Qty__AW_; "Return Qty (AW)")
                { }
                column(Dispatch_Qty; "Dispatch Qty")
                { }
                column(RemarkLine; RemarkLine)
                { }
                column(BW_QC_Date; "BW QC Date")
                { }

            }

            trigger OnPreDataItem()

            begin
                SetRange("No.", "Req No");
            end;

            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Filter by';

                    field("Req No"; "Req No")
                    {
                        ApplicationArea = All;
                        Caption = 'Requisition No';
                        TableRelation = "Washing Sample Header"."No.";
                    }
                }
            }
        }
    }

    var
        "Req No": Code[50];
        comRec: Record "Company Information";
}