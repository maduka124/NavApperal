report 51288 SampleFinishingReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sample Finishing Report';
    RDLCLayout = 'Report_Layouts/Samples/FinishingReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sample Requsition Line"; "Sample Requsition Line")
        {
            DataItemTableView = sorting("No.", "Line No.");
            column(CompLogo; comRec.Picture)
            { }
            column(Qty; Qty)
            { }
            column(Brand_Name; "Brand Name")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Garment_Type; "Sample Name")
            { }
            column(Finishing_Operator; "Finishing Operator")
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }
            column(ReqNo; "No.")
            { }
            column(Group_Head; "Group Head")
            { }
            column(Style_Name; "Style Name")
            { }

            trigger OnPreDataItem()
            begin
                if (stDate <> 0D) and (endDate <> 0D) then begin
                    if (stDate > endDate) then
                        Error('Invalid date period.');

                    SetRange("Finishing Date", stDate, endDate);
                end;

                SetFilter(Qty, '>%1', 0);
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
                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }

                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }
    }


    var
        comRec: Record "Company Information";
        stDate: Date;
        endDate: Date;
}