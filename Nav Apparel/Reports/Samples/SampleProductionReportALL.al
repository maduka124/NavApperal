report 51278 SampleProductionReportALL
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Pattern Report';
    RDLCLayout = 'Report_Layouts/Samples/SampleProductionReportALL.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Sample Requsition Line"; "Sample Requsition Line")
        {
            DataItemTableView = sorting("No.", "Line No.");
            column(CompLogo; comRec.Picture)
            { }
            column(Pattern_Maker; "Pattern Maker")
            { }
            column(Qty; Qty)
            { }
            column(Brand_Name; "Brand Name")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Garment_Type;"Sample Name")
            { }
            column(Pattern_Cutter; "Pattern Cutter")
            { }
            column(Cutter; Cutter)
            { }
            column(Sewing_Operator; "Sewing Operator")
            { }
            column(Quality_Checker; "Quality Checker")
            { }
            column(Wash_Sender; "Wash Sender")
            { }
            column(Wash_Receiver; "Wash Receiver")
            { }
            column(Finishing_Operator; "Finishing Operator")
            { }
            column(Quality_Finish_Checker; "Quality Finish Checker")
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }



            trigger OnPreDataItem()

            begin
                SetRange("Pattern Date", stDate, endDate)
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