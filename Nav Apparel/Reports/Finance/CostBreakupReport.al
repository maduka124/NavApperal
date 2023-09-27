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
            column(Total; Total)
            { }
            column(DayTGT; DayTGT)
            { }
            column(Fabric; Fabric)
            { }
            column(Access; Access)
            { }
            column(Wash; Wash)
            { }
            column(CommLC; CommLC)
            { }
            column(Sourcing; Sourcing)
            { }
            column(CommExpr; CommExpr)
            { }
            column(RiskFactor; RiskFactor)
            { }
            column(PrdExp; PrdExp)
            { }
            column(PrdExpPcs; PrdExpPcs)
            { }
            column(TotalCost; TotalCost)
            { }
            column(Balance; Balance)
            { }
            column(Created_User; "Created User")
            { }
            column(MFGCostPcs; MFGCostPcs)
            { }
            column(Avgarchive; Avgarchive)
            { }

            trigger OnAfterGetRecord()
            var
                BOMPOSelectionRec: Record BOMPOSelection;
                StyleMasPORec: Record "Style Master PO";
                BOMRec: Record BOM;
                EstCostingRec: Record "BOM Estimate Cost";
                BOMAutoGenLineRec: Record "BOM Line AutoGen";
                NavAppProdDetailRec: Record "NavApp Prod Plans Details";
            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                Avgarchive := 0;


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

                EstCostingRec.Reset();
                EstCostingRec.SetRange("Style No.", "No.");
                if EstCostingRec.FindSet() then
                    MFGCostPcs := EstCostingRec."MFG Cost Pcs";


                // AVG Day Pcs
                NoOfDates := 0;
                NavAppProdDetailRec.Reset();
                NavAppProdDetailRec.SetRange("Style No.", "No.");
                NavAppProdDetailRec.SetRange(PlanDate, stDate, endDate);
                // NavAppProdDetailRec.SetFilter(ProdUpd, '=%1', 0);
                NavAppProdDetailRec.SetCurrentKey(PlanDate);
                NavAppProdDetailRec.Ascending(true);

                if NavAppProdDetailRec.FindFirst() then
                    repeat

                        if TempDate2 <> NavAppProdDetailRec.PlanDate then begin
                            TempDate2 := NavAppProdDetailRec.PlanDate;
                            NoOfDates += 1;
                        end;

                    until NavAppProdDetailRec.Next() = 0;

                SewTotQty := 0;
                productioOutRec.Reset();
                productioOutRec.SetRange("Out Style No.", "No.");
                productioOutRec.SetRange(Type, productioOutRec.Type::Saw);

                if productioOutRec.FindSet() then begin
                    repeat
                        SewTotQty += productioOutRec."Output Qty";
                    until productioOutRec.Next() = 0;
                end;

                if NoOfDates <> 0 then
                    Avgarchive := SewTotQty / NoOfDates;

                //Get Rate  
                Rate := 0;
                EstCostingRec.Reset();
                EstCostingRec.SetRange("Style No.", "No.");
                if EstCostingRec.FindSet() then
                    Rate := EstCostingRec."FOB Pcs";

                //Calculate Total
                Total := CostBrQty * Rate;


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
                    BOMAutoGenLineRec.SetFilter("Main Category Name", '=%1', 'FABRIC');
                    if BOMAutoGenLineRec.FindSet() then
                        repeat
                            Fabric += BOMAutoGenLineRec.Value;
                        until BOMAutoGenLineRec.Next() = 0;
                end;


                //Access
                Access := 0;
                BOMRec.Reset();
                BOMRec.SetRange("Style No.", "No.");
                if BOMRec.FindFirst() then begin
                    BOMAutoGenLineRec.Reset();
                    BOMAutoGenLineRec.SetRange("No.", BOMRec."No");
                    BOMAutoGenLineRec.SetFilter("Main Category Name", '<>%1&<>%2', 'FABRIC', 'WASHING');
                    if BOMAutoGenLineRec.FindSet() then
                        repeat
                            Access += BOMAutoGenLineRec.Value;
                        until BOMAutoGenLineRec.Next() = 0;
                end;


                //WASH
                Wash := 0;
                // BOMRec.Reset();
                // BOMRec.SetRange("Style No.", "No.");
                // if BOMRec.FindFirst() then begin
                //     BOMAutoGenLineRec.Reset();
                //     BOMAutoGenLineRec.SetRange("No.", BOMRec."No");
                //     BOMAutoGenLineRec.SetFilter("Main Category Name", '=%1', 'WASHING');
                //     if BOMAutoGenLineRec.FindSet() then begin
                //         repeat
                //             Wash += BOMAutoGenLineRec.Value;
                //         until BOMAutoGenLineRec.Next() = 0;
                //     end
                //     else begin
                //         EstCostingRec.Reset();
                //         EstCostingRec.SetRange("Style No.", "No.");

                //         if EstimateCostingRec.FindSet() then
                //             Wash := (EstimateCostingRec."Washing (Dz.)" / 12) * EstimateCostingRec.Quantity;
                //     end;

                // end;

                EstCostingRec.Reset();
                EstCostingRec.SetRange("Style No.", "No.");

                if EstCostingRec.FindSet() then
                    Wash := (EstCostingRec."Washing (Dz.)" / 12) * EstCostingRec.Quantity;


                //Get CommLC  
                CommLC := 0;
                Sourcing := 0;
                CommExpr := 0;
                RiskFactor := 0;
                PrdExp := 0;
                EstCostingRec.Reset();
                EstCostingRec.SetRange("Style No.", "No.");
                if EstCostingRec.FindSet() then begin
                    CommLC := (Total * EstCostingRec."Commission %") / 100;
                    Sourcing := (Total * EstCostingRec."ABA Sourcing %") / 100;
                    CommExpr := (Total * EstCostingRec."Commercial %") / 100;
                    RiskFactor := (Total * EstCostingRec."Risk factor %") / 100;
                    PrdExp := (Total * EstCostingRec."MFG Cost %") / 100;
                end;


                //Get Unique Plandates count for the style                
                TempDate := 0D;
                DateCount := 0;
                NavAppProdDetailRec.Reset();
                NavAppProdDetailRec.SetRange("Style No.", "No.");
                NavAppProdDetailRec.SetFilter(ProdUpd, '=%1', 0);
                NavAppProdDetailRec.SetCurrentKey(PlanDate);
                NavAppProdDetailRec.Ascending(true);
                if NavAppProdDetailRec.Findset() then begin
                    repeat
                        if TempDate <> NavAppProdDetailRec.PlanDate then begin
                            TempDate := NavAppProdDetailRec.PlanDate;
                            DateCount += 1;
                        end;
                    until NavAppProdDetailRec.Next() = 0;
                end;


                //Get total actual output
                TotalOutput := 0;
                StyleMasPORec.Reset();
                StyleMasPORec.SetRange("Style No.", "No.");
                if StyleMasPORec.Findset() then
                    repeat
                        TotalOutput += StyleMasPORec."Sawing Out Qty";
                    until StyleMasPORec.Next() = 0;


                //calculate PrdExpPcs
                PrdExpPcs := 0;
                if DateCount > 0 then
                    PrdExpPcs := TotalOutput / DateCount;


                //Calculate TotalCost
                TotalCost := 0;
                TotalCost := Fabric + Access + Wash + CommLC + Sourcing + CommExpr + RiskFactor + PrdExp;

                //Calculate Balance
                Balance := 0;
                Balance := Total - TotalCost;

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
    end;


    var
        comRec: Record "Company Information";
        productioOutRec: Record ProductionOutHeader;
        SewTotQty: Integer;
        Avgarchive: Decimal;
        stDate: Date;
        endDate: Date;
        Buyer: Code[20];
        "All buyers": Boolean;
        BuyerEditable: Boolean;
        CostBrQty: Decimal;
        Rate: Decimal;
        DayTGT: Decimal;
        Fabric: Decimal;
        Access: Decimal;
        Wash: Decimal;
        CommLC: Decimal;
        Sourcing: Decimal;
        CommExpr: Decimal;
        RiskFactor: Decimal;
        PrdExp: Decimal;
        PrdExpPcs: Decimal;
        Total: Decimal;
        TempDate: Date;
        DateCount: Integer;
        TotalOutput: Decimal;
        TotalCost: Decimal;
        Balance: Decimal;
        EstimateCostingRec: Record "BOM Estimate Cost";
        MFGCostPcs: Decimal;
        PlstartDate: Date;
        TempDate2: Date;
        NoOfDates: Integer;
}