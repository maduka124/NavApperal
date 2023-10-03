report 51258 FabricInspectionReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Fabric Inspection Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/Fabric Inspection Report.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem(FabricInspection; FabricInspection)
        {
            column(CompLogo; comRec.Picture)
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Style_Name; "Style Name")
            { }
            column(Item_Name; "Item Name")
            { }
            column(Created_Date; "Created Date")
            { }
            column("Point1__Up_to_3_inches_"; "1 Point (Up to 3 inches)")
            { }
            column("Point2__Up_to_3_6_inches_"; "2 Point (Up to 3-6 inches)")
            { }
            column("Point3__Up_to_6_9_inches_"; "3 Point (Up to 6-9 inches)")
            { }
            column("Point4__Above_9_inches__"; "4 Point (Above 9 inches)")
            { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
            // { }
            // column()
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