report 50900 BWQCReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'BW QC Report';
    RDLCLayout = 'Report_Layouts/Washing/BWQCReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(BWQualityCheckHeader; BWQualityCheckHeader)
        {
            DataItemTableView = sorting("No.");
            column(No_; "No.")
            { }
            column(BW_QC_Date; "BW QC Date")
            { }
            column(Status; Status)
            { }
            column(Sample_Req_No; "Sample Req No")
            { }
            column(Pass_Qty; "Pass Qty")
            { }
            column(Fail_Qty; "Fail Qty")
            { }
            column(Remarks; Remarks)
            { }
            column(CompLogo; comRec.Picture)
            { }
            dataitem("Washing Sample Requsition Line"; "Washing Sample Requsition Line")
            {
                DataItemLinkReference = BWQualityCheckHeader;
                DataItemLink = "No." = field("Sample Req No");
                DataItemTableView = sorting("No.");
                column(Line_no_; "Line no.")
                { }
                column(Fabric_Description; "Fabric Description")
                { }
                column(Req_Qty; "Req Qty")
                { }
            }

            dataitem(BWQualityLine2; BWQualityLine2)
            {
                DataItemLinkReference = BWQualityCheckHeader;
                DataItemLink = No = field("No.");
                DataItemTableView = sorting(No);
                column(Defect; Defect)
                { }

                column(Qty; Qty)
                { }

                column(Comment; Comment)
                { }
            }

            trigger OnPreDataItem()
            begin
                SetRange("No.", "BW QC No");
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
                    Caption = 'Filter By';
                    field("BW QC No"; "BW QC No")
                    {
                        ApplicationArea = All;
                        Caption = 'Before Wash QC No';
                        TableRelation = BWQualityCheckHeader."No.";

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    var
        "BW QC No": Code[50];
        comRec: Record "Company Information";
}