report 51295 SewingReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sewing Report';
    RDLCLayout = 'Report_Layouts/Samples/SewingReport.rdl';
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
            column(Sewing_Operator; "Sewing Operator")
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }



            trigger OnPreDataItem()

            begin
                SetRange("Sewing Date", stDate, endDate)
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