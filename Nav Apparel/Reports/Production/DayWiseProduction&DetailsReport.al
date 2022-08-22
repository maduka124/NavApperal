report 50622 DayWiseProductionReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Day Wise Production & Details Report';
    RDLCLayout = 'Report_Layouts/Production/DayWiseProductionReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = sorting("No.");
            column(Created_Date; "Created Date")
            { }
            column(Style_Name; "Style No.")
            { }
            column(BuyerName; "Buyer Name")
            { }
            column(SMV; SMV)
            { }
            column(CompLogo; comRec.Picture)
            { }
            dataitem("Style Master PO"; "Style Master PO")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("Style No.");
                column(cutting; "Cut Out Qty")
                { }
                column(Sewing; "Sawing Out Qty")
                { }
                column(Finishing; "Finish Qty")
                { }
                column(PO_No_; "PO No.")
                { }
                column(stDate; stDate)
                { }
                column(endDate; endDate)
                { }


            }
            trigger OnPreDataItem()
            begin
                SetRange("Created Date", stDate, endDate);
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

        stDate: Date;
        endDate: Date;
        comRec: Record "Company Information";


}