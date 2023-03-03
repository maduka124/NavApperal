report 51259 TrimInspectionReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Trim Inspection Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/TrimInspectionReport.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
        {
            column(CompLogo; comRec.Picture)
            { }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name")
            { }
            //  column()
            // { }
            //  column()
            // { }
            //  column()
            // { }
            //  column()
            // { }
            //  column()
            // { }
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
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
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
        comRec: Record "Company Information";
}