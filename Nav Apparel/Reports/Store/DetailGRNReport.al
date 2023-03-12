report 51148 DetailGRNReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Detail GRN Report';
    RDLCLayout = 'Report_Layouts/Store/DetailGRNReport.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
        {
            RequestFilterFields = "Document No.", "No.", "Location Code";
            column(Document_No_; "Document No.")
            { }
            column(No_; "No.")
            { }
            column(Description; Description)
            { }
            column(Location_Code; "Location Code")
            { }
            column(Quantity; Quantity)
            { }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            { }
            column(CompLogo; comRec.Picture)
            { }

            //      column()
            //     {}
            //      column()
            //     {}
            //      column()
            //     {}
            //      column()
            //     {}
            // }
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
                // group(GroupName)
                // {
                //     // field(Name; SourceExpression)
                //     // {
                //     //     ApplicationArea = All;

                //     // }
                // }
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
        myInt: Integer;
        comRec: Record "Company Information";
}