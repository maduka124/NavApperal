report 50613 EstimateCostSheetReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Estimate Cost Sheet Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/EstimateCostSheetReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("BOM Estimate Cost"; "BOM Estimate Cost")
        {
            DataItemTableView = sorting("No.");
            column(Season_Name; "Season Name")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Garment_Type_Name; "Garment Type Name")
            { }
            column(Style_Name; "Style Name")
            { }
            column(Created_Date; "Created Date")
            { }
            column(Quantity; Quantity)
            { }
            // column(Raw_Material__Dz__; "Raw Material (Dz.)")
            // { }
            column(Embroidery__Dz__; "Embroidery (Dz.)")
            { }
            column(Printing__Dz__; "Printing (Dz.)")
            { }
            column(Washing__Dz__; "Washing (Dz.)")
            { }
            column(Others__Dz__; "Others (Dz.)")
            { }
            column(FOB__; "FOB %")
            { }
            column(FOB_Dz_; "FOB Dz.")
            { }
            column(FOB_Pcs; "FOB Pcs")
            { }
            column(FOB_Total; "FOB Total")
            { }
            // column(Gross_CM_With_Commission_Pcs; "Gross CM With Commission Pcs")
            // { }
            column(MFG_Cost_Dz_; "MFG Cost Dz.")
            { }
            column(MFG_Cost_Pcs; "MFG Cost Pcs")
            { }
            column(Overhead_Dz_; "Overhead Dz.")
            { }
            column(Overhead_Pcs; "Overhead Pcs")
            { }
            column(Commercial_Dz_; "Commercial Dz.")
            { }
            column(Commercial_Pcs; "Commercial Pcs")
            { }
            column(Deferred_Payment_Dz_; "Deferred Payment Dz.")
            { }
            column(Deferred_Payment_Pcs; "Deferred Payment Pcs")
            { }
            column(Total_Cost_Pcs; "Total Cost Pcs")
            { }
            column(Commission_Dz_; "Commission Dz.")
            { }
            column(Commission_Pcs; "Commission Pcs")
            { }
            column(Profit_Margin_Pcs; "Profit Margin Pcs")
            { }
            column(Overhead__; "Overhead %")
            { }
            column(MFG_Cost__; "MFG Cost %")
            { }
            column(Commission__; "Commission %")
            { }
            column(Commercial__; "Commercial %")
            { }
            column(Deferred_Payment__; "Deferred Payment %")
            { }
            column(Risk_factor__; "Risk factor %")
            { }
            column(Risk_factor__Pcs; "Risk factor Pcs")
            { }
            column(Risk_factor_Dz_; "Risk factor Dz.")
            { }
            column(TAX__; "TAX %")
            { }
            column(TAX__Pcs; "TAX Pcs")
            { }
            column(TAX_Dz_; "TAX Dz.")
            { }
            column(ABA_Sourcing__; "ABA Sourcing %")
            { }
            column(ABA_Sourcing__Pcs; "ABA Sourcing Pcs")
            { }
            column(ABA_Sourcing_Dz_; "ABA Sourcing Dz.")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Status; Status)
            { }
            column(Type; Type)
            { }

            dataitem("BOM Estimate Costing Line"; "BOM Estimate Costing Line")
            {
                DataItemLinkReference = "BOM Estimate Cost";
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.");
                column(TotFab; TotFab)
                { }
                column(NotFab; NotFab)
                { }
                column(Consumption; Consumption1)
                { }
                column(ConsumptionNot; ConsumptionNot)
                { }
                trigger OnAfterGetRecord()

                begin

                    TotFab := 0;
                    Consumption1 := 0;
                    NotFab := 0;
                    ConsumptionNot := 0;



                    if "Master Category Name" = 'FABRIC' then begin
                        TotFab := "Doz Cost";
                        Consumption1 := "Doz Cost" / 12;
                    end;

                    if "Master Category Name" <> 'FABRIC' then begin
                        NotFab := "Doz Cost";
                        ConsumptionNot := "Doz Cost" / 12;
                    end;
                end;




            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            var

            begin
                SetRange("No.", BomNo);
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
                    field(BomNo; BomNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Cost Sheet No';
                        TableRelation = "BOM Estimate Cost"."No.";


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
        myInt: Integer;
        // styleRec: Record "Style Master";
        BomAutoRec: Record "BOM Line AutoGen";
        TotFab: Decimal;
        NotFab: Decimal;
        Consumption1: Decimal;
        ConsumptionNot: Decimal;
        BomNo: Code[50];
        BomRec: Record BOM;
        comRec: Record "Company Information";

}