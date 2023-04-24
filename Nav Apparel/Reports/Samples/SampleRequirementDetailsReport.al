report 51285 SampleRequirementDetails
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Sample Requirement Details Report';
    RDLCLayout = 'Report_Layouts/Samples/SampleRequirementDetails.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Sample Requsition Line"; "Sample Requsition Line")
        {
            DataItemTableView = sorting("No.", "Line No.");
            column(Group_Head; "Group Head")
            { }
            column(Style_Name; "Style Name")
            { }
            column(Sample_Name; "Sample Name")
            { }
            column(Brand_Name; "Brand Name")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Reject_Qty; "Reject Qty")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }
            column(Qty; Qty)
            { }


            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            begin
                SetRange("QC/Finishing Date", stDate, endDate)
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