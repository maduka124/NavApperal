report 51200 LayingReport
{

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Laying and Fabric Usage Report';
    RDLCLayout = 'Report_Layouts/Cutting/LayingFabricReport.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem(LaySheetHeader; LaySheetHeader)
        {
            column(LaySheetNo_; "LaySheetNo.")
            { }

            column(Style_Name; "Style Name")
            { }

            column(CompLogo; comRec.Picture)
            { }

            trigger OnPreDataItem()

            begin
                SetRange("LaySheetNo.", LaySheetNo);
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
                group("Laying and Fabric Usage Report")
                {
                    Caption = 'Filter By';
                    field(LaySheetNo; LaySheetNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Lay Sheet Number';
                        TableRelation = LaySheetHeader."LaySheetNo.";
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
        LaySheetNo: Code[20];
        comRec: Record "Company Information";
}