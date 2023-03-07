report 51256 lineinoutReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Line In & Out Report';
    RDLCLayout = 'Report_Layouts/Planning/LineIn&OutReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(ProductionOutHeader; ProductionOutHeader)
        {
            DataItemTableView = where(Type = filter('Saw'));
            column(Resource_Name; "Resource Name")
            { }

            column(Buyer; Buyer)
            { }

            column(orderQty; orderQty)
            { }

            column(Style_Name; "Style Name")
            { }

            column(PO_No; "PO No")
            { }

            column(Input_Qty; "Input Qty")
            { }

            column(Output_Qty; "Output Qty")
            { }

            column(CompLogo; comRec.Picture)
            { }

            column(StDate; StDate)
            { }
            column(EndDate; EndDate)
            { }

            trigger OnAfterGetRecord()
            begin

                StyleRec.Reset();
                StyleRec.SetRange("No.", "Style No.");

                if StyleRec.FindSet() then begin
                    Buyer := StyleRec."Buyer Name";
                    orderQty := StyleRec."Order Qty";
                end;

                comRec.Get;
                comRec.CalcFields(Picture);

            end;

            trigger OnPreDataItem()
            begin
                SetRange("Prod Date", StDate, EndDate);
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
                    field(StDate; StDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }

                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }


    }

    var

        StyleRec: Record "Style Master";
        Buyer: Text[50];
        orderQty: BigInteger;
        StDate: Date;
        EndDate: Date;
        comRec: Record "Company Information";
}