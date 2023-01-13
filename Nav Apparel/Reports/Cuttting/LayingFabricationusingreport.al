report 51200 LayingReport
{

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    RDLCLayout = 'Report_Layouts/Cutting/LayingFabricReport.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            column(No_; "No.")
            { }
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

}