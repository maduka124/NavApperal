report 51308 FabricInspectionReportQuality
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Fabric Inspection Report';
    RDLCLayout = 'Report_Layouts/Quality/FabricInspectionReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(FabricInspection; FabricInspection)
        {
            column(InsNo_; "InsNo.")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Style_Name; "Style Name")
            { }
            column(GRN; GRN)
            { }
            column(Item_Name; "Item Name")
            { }
            column(Roll_No; "Roll No")
            { }
            column(Batch_No; "Batch No")
            { }
            column(Inspection_Stage; "Inspection Stage")
            { }
            column(TKT_Length; "TKT Length")
            { }
            column(TKT_Width; "TKT Width")
            { }
            column(Actual_Length; "Actual Length")
            { }
            column(Actual_Width; "Actual Width")
            { }
            column("one1_Point"; "1 Point")
            { }
            column("Two2_Point"; "2 Point")
            { }
            column("Three3_Point_"; "3 Point ")
            { }
            column("Four4_Point"; "4 Point")
            { }
            column("One1_Point__Up_to_3_inches_"; "1 Point (Up to 3 inches)")
            { }
            column("Two2_Point__Up_to_3_6_inches_"; "2 Point (Up to 3-6 inches)")
            { }
            column("Three3_Point__Up_to_6_9_inches_"; "3 Point (Up to 6-9 inches)")
            { }
            column("Four4_Point__Above_9_inches__"; "4 Point (Above 9 inches) ")
            { }
            column(Status; Status)
            { }
            column(Remarks; Remarks)
            { }
            column(Color; Color)
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem(FabricInspectionLine1; FabricInspectionLine1)
            {
                DataItemLinkReference = FabricInspection;
                DataItemLink = "InsNo." = field("InsNo.");

                column(Defects; Defects)
                { }
                column(Point_1; "Point 1")
                { }
                column(Point_2; "Point 2")
                { }
                column(Point_3; "Point 3")
                { }
                column(Point_4; "Point 4")
                { }
                column(Point_Total; "Point Total")
                { }
            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetRange("InsNo.", INsFilter);
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
                    field(INsFilter; INsFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Inspection No';
                        TableRelation = FabricInspection."InsNo.";

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
        INsFilter: Code[20];
        myInt: Integer;
        comRec: Record "Company Information";
}