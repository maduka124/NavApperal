report 51403 CostBreakupReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Cost Breakup Report';
    RDLCLayout = 'Report_Layouts/Finance/CostBreakupRepor.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            DataItemTableView = where(Status = filter('Confirmed'));

            column(Style_No_; "Style No.")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }
            column(Order_Qty; "Order Qty")
            { }
            column(CostBrQty; CostBrQty)
            { }
            column(Rate; Rate)
            { }
            column(DayTGT; DayTGT)
            { }
            column(Fabric; Fabric)
            { }
            column(Access; Access)
            { }
            column(Wash; Wash)
            { }
            column(CommCash; CommCash)
            { }
            column(CommLC; CommLC)
            { }


            trigger OnAfterGetRecord()
            var
                BOMPOSelectionRec: Record BOMPOSelection;
                StyleMasPORec: Record "Style Master PO";
                BOMRec: Record BOM;
                EstCostingRec: Record "BOM Estimate Cost";
                BOMAutoGenLineRec: Record "BOM Line AutoGen";
                // EstCostingLineRec: Record "BOM Estimate Costing Line";
                NavAppProdDetailRec: Record "NavApp Prod Plans Details";
            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                //Get CostBrQty
                CostBrQty := 0;
                BOMPOSelectionRec.Reset();
                BOMPOSelectionRec.SetRange("Style No.", "No.");
                BOMPOSelectionRec.SetFilter(Selection, '=%1', true);
                if BOMPOSelectionRec.FindSet() then
                    repeat
                        StyleMasPORec.Reset();
                        StyleMasPORec.SetRange("Style No.", "No.");
                        StyleMasPORec.SetRange("PO No.", BOMPOSelectionRec."PO No.");
                        if StyleMasPORec.Findset() then
                            CostBrQty += StyleMasPORec.Qty;
                    until BOMPOSelectionRec.Next() = 0;


                //Get Rate  
                Rate := 0;
                EstCostingRec.Reset();
                EstCostingRec.SetRange("Style No.", "No.");
                if EstCostingRec.FindSet() then
                    Rate := EstCostingRec."FOB Pcs";


                //DayTGT
                DayTGT := 0;
                NavAppProdDetailRec.Reset();
                NavAppProdDetailRec.SetRange("Style No.", "No.");
                NavAppProdDetailRec.SetCurrentKey(Qty);
                NavAppProdDetailRec.Ascending(false);
                if NavAppProdDetailRec.FindFirst() then
                    DayTGT := NavAppProdDetailRec.Qty;


                //Fabric
                Fabric := 0;
                BOMRec.Reset();
                BOMRec.SetRange("Style No.", "No.");
                if BOMRec.FindFirst() then begin
                    BOMAutoGenLineRec.Reset();
                    BOMAutoGenLineRec.SetRange("No.", BOMRec."No");
                    BOMAutoGenLineRec.SetFilter("Main Category Name", '=%1',);
                    if BOMAutoGenLineRec.FindSet() then
                        Fabric := BOMAutoGenLineRec.Qty;
                end;



            end;


            trigger OnPreDataItem()
            begin
                if "All buyers" = false then
                    SetRange("Buyer No.", Buyer);

                SetFilter("Buyer Name", '<>%1', '');

                if stDate = 0D then
                    Error('Invalid Start Date');

                if EndDate = 0D then
                    Error('Invalid End Date');

                if (stDate > endDate) then
                    Error('Invalid Date Period.');

                SetRange("Style Master"."Max Ship Date", stDate, endDate);
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

                    field("All buyers"; "All buyers")
                    {
                        ApplicationArea = All;

                        Caption = 'All Buyer';
                        trigger OnValidate()
                        begin
                            if "All buyers" = true then
                                BuyerEditable := false
                            else
                                BuyerEditable := true;
                        end;
                    }

                    field(Buyer; Buyer)
                    {
                        ApplicationArea = all;
                        Caption = 'Buyer';
                        Editable = BuyerEditable;
                        ShowMandatory = true;
                        TableRelation = Customer."No.";
                    }

                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                        ShowMandatory = true;
                    }

                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                        ShowMandatory = true;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            BuyerEditable := true;
        end;
    }


    trigger OnPreReport()
    var
        StyelMasRec: Record "Style Master";
        StyleMasPORec: Record "Style Master PO";
    begin
        StyelMasRec.Reset();
        StyelMasRec.SetFilter(Status, '=%1', StyelMasRec.Status::Confirmed);

        if "All buyers" = false then begin
            if Buyer = '' then
                Error('Buyer not selected');

            StyelMasRec.SetRange("Buyer No.", Buyer);
        end;

        if StyelMasRec.FindSet() then begin
            repeat
                StyleMasPORec.Reset();
                StyleMasPORec.SetRange("Style No.", StyelMasRec."No.");
                StyleMasPORec.SetCurrentKey("Ship Date");
                StyleMasPORec.Ascending(false);
                if StyleMasPORec.FindFirst() then begin
                    StyelMasRec."Max Ship Date" := StyleMasPORec."Ship Date";
                    StyelMasRec.Modify();
                end;
            until StyelMasRec.Next() = 0;
        end;
        Commit();

        Message('completed');
    end;


    var
        comRec: Record "Company Information";
        stDate: Date;
        endDate: Date;
        Buyer: Code[20];
        "All buyers": Boolean;
        BuyerEditable: Boolean;
        CostBrQty: BigInteger;
        Rate: Decimal;
        DayTGT: BigInteger;
        Fabric: Decimal;
        Access: Decimal;
        Wash: Decimal;
        CommCash: Decimal;
        CommLC: Decimal;
        Sourcing: Decimal;
}