report 51287 PatternReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Pattern Report';
    RDLCLayout = 'Report_Layouts/Samples/PatternReport.rdl';
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