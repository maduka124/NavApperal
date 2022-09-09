report 50901 AWQCReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Report_Layouts/Washing/AWQCReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(AWQualityCheckHeader; AWQualityCheckHeader)
        {
            column(No_; "No.")
            { }
            column(QC_AW_Date; "QC AW Date")
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
                DataItemLinkReference = AWQualityCheckHeader;
                DataItemLink = "No." = field("Sample Req No");
                DataItemTableView = sorting("No.");

                column(Fabric_Description; "Fabric Description")
                { }
                column(Req_Qty; "Req Qty")
                { }
            }

            dataitem(AWQualityCheckLine; AWQualityCheckLine)
            {
                DataItemLinkReference = AWQualityCheckHeader;
                DataItemLink = No = field("No.");
                DataItemTableView = sorting(No);
                column(Defect; Defect)
                { }
                column(Qty; Qty)
                { }
                column(Comment; Comment)
                { }
            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            begin
                SetRange("No.", "AW QC No");
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
                    field("AW QC No"; "AW QC No")
                    {
                        ApplicationArea = All;
                        TableRelation = AWQualityCheckHeader."No.";
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
        "AW QC No": Code[50];
        comRec: Record "Company Information";
}