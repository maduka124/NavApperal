report 50865 HourlyProductionReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Hourly Production Report';
    // RDLCLayout = 'Report_Layouts/Planning/HourlyProductionReport.rdl';
    RDLCLayout = 'Report_Layouts/Planning/HourlyProductionReport2.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
        {
            DataItemTableView = sorting("Resource No.", "Style No.");
            column(FactoryName; FactoryName)
            { }
            column(PlanDate; PlanDate)
            { }
            column(Qty; Qty)
            { }
            column(Style_Name; "Style Name")
            { }
            column(ResourceName; ResourceName)
            { }
            column("ResourceNo"; "Resource No.")
            { }
            column(EffProdPlan; Eff)
            { }
            column(BuyerName; BuyerName)
            { }
            column(Style; Style)
            { }
            column(Factory; Factory)
            { }
            column(GarmentType; GarmentType)
            { }
            column(SMV; SMV)
            { }
            column(PlanTarget; PlanTarget)
            { }
            column(TodayTarget; Target1)
            { }
            column(PlanQty; PlanQty)
            { }
            column(PlanDt; InputDate)
            { }
            column(ActualPlanDt; ActualPlanDT)
            { }
            column(MC; MC)
            { }
            column(OutPutStartDate; OutPutStartDate)
            { }
            column(MerchandizerName; MerchandizerName)
            { }
            column(OutputComDate; OutputComDate)
            { }
            column(InputQtyToday; InputQtyTodayTotal)
            { }
            column(OutputQty; OutputQty)
            { }
            column(Line_No_; "Line No.")
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(TodayOutput; TodayOutput)
            { }
            column(variance; variance)
            { }
            column(HoursPerDay; HoursPerDay)
            { }
            column(Start_Time; "Start Time")
            { }
            column(Finish_Time; "Finish Time")
            { }
            column(Factory_No_; "Factory No.")
            { }
            column(BrandName; BrandName)
            { }
            column(PlanInput; PlanInput)
            { }
            column(Planfinish; Planfinish)
            { }
            column(ActualInputDate; ActualInputDate)
            { }
            column(ActualFinishDate; ActualFinishDate)
            { }
            column(EffProdOut; Eff)
            { }
            column(CMPcs; CMPcs)
            { }
            column(SendWashQty; SendWashQty)
            { }
            column(ReceiveWashQty; ReceiveWashQty)
            { }
            column(PO_No_; PoNo)
            { }
            column(ShipDate; ShipDate)
            { }
            column(OrderQy; OrderQy)
            { }
            column(TargetProdPlan; TargetProdPlan)
            { }
            column(HourlyTarget; HourlyTarget)
            { }
            column(CutInputQtyTotal; CutOutputQtyTotal)
            { }
            column(CutOutputQtyTotal; CutOutputQtyTotal)
            { }
            column(EMBInputQtyTotal; EMBInputQtyTotal)
            { }
            column(EMBOutputQtyTotal; EMBOutputQtyTotal)
            { }
            column(InputWIP; InputWIP)
            { }
            column(InputQtyTodayTo; InputQtyTodayTo)
            { }
            column(CutInputToday; CutInputToday)
            { }
            column(Lot_No_; "Lot No.")
            { }
            column(CM; CM)
            { }
            column(TOtalTarget; TOtalTarget)
            { }
            column(VarienceNew; VarienceNew)
            { }
            column(HourlyTarger2; HourlyTarger2)
            { }
            column(TOt1Hour; TOt1Hour)
            { }
            column(TOt2Hour; TOt2Hour)
            { }
            column(TOt3Hour; TOt3Hour)
            { }
            column(TOt4Hour; TOt4Hour)
            { }
            column(TOt5Hour; TOt5Hour)
            { }
            column(TOt6Hour; TOt6Hour)
            { }
            column(TOt7Hour; TOt7Hour)
            { }
            column(TOt8Hour; TOt8Hour)
            { }
            column(TOt9Hour; TOt9Hour)
            { }
            column(TOt10Hour; TOt10Hour)
            { }
            column(LCurve_Hours_Per_Day; "LCurve Hours Per Day")
            { }
            column(LCurve_Start_Time; "LCurve Start Time")
            { }
            column(TimeVariable; TimeVariable)
            { }
            column(Hour_1F; Hour1F)
            { }
            column(Hour_2F; Hour2F)
            { }
            column(Hour_3F; Hour3F)
            { }
            column(Hour_4F; Hour4F)
            { }
            column(Hour_5F; Hour5F)
            { }
            column(Hour_6F; Hour6F)
            { }
            column(Hour_7F; Hour7F)
            { }
            column(Hour_8F; Hour8F)
            { }
            column(Hour_9F; Hour9F)
            { }
            column(Hour_10F; Hour10F)
            { }
            column(Line_No_1F; LineNOFIn)
            { }
            column(ItemF; ItemFin)
            { }
            column(Factory_No_1F; "Factory No.")
            { }
            column(StyleNameFinishing; StyleName)
            { }
            column(Hour1TotFin; Hour1TotFin)
            { }
            column(Hour2TotFin; Hour2TotFin)
            { }
            column(Hour3TotFin; Hour3TotFin)
            { }
            column(Hour4TotFin; Hour4TotFin)
            { }
            column(Hour5TotFin; Hour5TotFin)
            { }
            column(Hour6TotFin; Hour6TotFin)
            { }
            column(Hour7TotFin; Hour7TotFin)
            { }
            column(Hour8TotFin; Hour8TotFin)
            { }
            column(Hour9TotFin; Hour9TotFin)
            { }
            column(Hour10TotFin; Hour10TotFin)
            { }
            column(TotalAchiveHoursFin; TotalAchiveHoursFin)
            { }
            column(FactoryHour1TotFin; FactoryHour1TotFin)
            { }
            column(FactoryHour2TotFin; FactoryHour2TotFin)
            { }
            column(FactoryHour3TotFin; FactoryHour3TotFin)
            { }
            column(FactoryHour4TotFin; FactoryHour4TotFin)
            { }
            column(FactoryHour5TotFin; FactoryHour5TotFin)
            { }
            column(FactoryHour6TotFin; FactoryHour6TotFin)
            { }
            column(FactoryHour7TotFin; FactoryHour7TotFin)
            { }
            column(FactoryHour8TotFin; FactoryHour8TotFin)
            { }
            column(FactoryHour9TotFin; FactoryHour9TotFin)
            { }
            column(FactoryHour10TotFin; FactoryHour10TotFin)
            { }
            column(FactoryTotalAchiveHoursFin; FactoryTotalAchiveHoursFin)
            { }
            column(Learning_Curve_No_; "Learning Curve No.")
            { }
            column(FactoryH1; FactoryH1)
            { }
            column(FactoryH2; FactoryH2)
            { }
            column(FactoryH3; FactoryH3)
            { }
            column(FactoryH4; FactoryH4)
            { }
            column(FactoryH5; FactoryH5)
            { }
            column(FactoryH6; FactoryH6)
            { }
            column(FactoryH7; FactoryH7)
            { }
            column(FactoryH8; FactoryH8)
            { }
            column(FactoryH9; FactoryH9)
            { }
            column(FactoryH10; FactoryH10)
            { }
            column(WorkingHrs; WorkingHrs)
            { }
            column(WIPFin; WIPFin)
            { }
            column(WFHTot; WFHTot)
            { }
            dataitem("Hourly Production Lines"; "Hourly Production Lines")
            {
                DataItemLinkReference = "NavApp Prod Plans Details";
                DataItemLink = "Factory No." = field("Factory No."), "Work Center No." = field("Resource No."), "Prod Date" = field(PlanDate), "Style No." = field("Style No.");
                DataItemTableView = where(Type = filter('Sewing'), Item = filter('PASS PCS'));

                column(Hour_1; "Hour 01")
                { }
                column(Hour_2; "Hour 02")
                { }
                column(Hour_3; "Hour 03")
                { }
                column(Hour_4; "Hour 04")
                { }
                column(Hour_5; "Hour 05")
                { }
                column(Hour_6; "Hour 06")
                { }
                column(Hour_7; "Hour 07")
                { }
                column(Hour_8; "Hour 08")
                { }
                column(Hour_9; "Hour 09")
                { }
                column(Hour_10; "Hour 10")
                { }
                column(Line_No_1; "Work Center Name")
                { }
                column(Item; Item)
                { }
                column(Factory_No_1; "Factory No.")
                { }
                column(Hour1Tot; Hour1Tot)
                { }
                column(Hour2Tot; Hour2Tot)
                { }
                column(Hour3Tot; Hour3Tot)
                { }
                column(Hour4Tot; Hour4Tot)
                { }
                column(Hour5Tot; Hour5Tot)
                { }
                column(Hour6Tot; Hour6Tot)
                { }
                column(Hour7Tot; Hour7Tot)
                { }
                column(Hour8Tot; Hour8Tot)
                { }
                column(Hour9Tot; Hour9Tot)
                { }
                column(Hour10Tot; Hour10Tot)
                { }
                column(TotalAchiveHours; TotalAchiveHours)
                { }
                column(FactoryHour1Tot; FactoryHour1Tot)
                { }
                column(FactoryHour2Tot; FactoryHour2Tot)
                { }
                column(FactoryHour3Tot; FactoryHour3Tot)
                { }
                column(FactoryHour4Tot; FactoryHour4Tot)
                { }
                column(FactoryHour5Tot; FactoryHour5Tot)
                { }
                column(FactoryHour6Tot; FactoryHour6Tot)
                { }
                column(FactoryHour7Tot; FactoryHour7Tot)
                { }
                column(FactoryHour8Tot; FactoryHour8Tot)
                { }
                column(FactoryHour9Tot; FactoryHour9Tot)
                { }
                column(FactoryHour10Tot; FactoryHour10Tot)
                { }
                column(TotalFactoryAchiveHours; TotalFactoryAchiveHours)
                { }
                column(FactoryCodeTotal; FactoryCodeTotal)
                { }

            }

            trigger OnAfterGetRecord()
            var
                StylePoRec: Record "Style Master PO";
                HoProLineRec: Record "Hourly Production Lines";
                WFH1: Integer;
                WFH2: Integer;
                WFH3: Integer;
                WFH4: Integer;
                WFH5: Integer;
                WFH6: Integer;
                WFH7: Integer;
                WFH8: Integer;
                WFH9: Integer;
                WFH10: Integer;
                Yesterday: Date;
            begin
                Yesterday := Today - 1;

                StyleRec.Reset();
                StyleRec.SetRange("No.", "Style No.");
                if StyleRec.FindFirst() then begin
                    StyleName := StyleRec."Style No.";
                end;
                //Factory Achieve
                HoFinLineRec.Reset();
                HoFinLineRec.SetRange("Prod Date", PlanDate);
                HoFinLineRec.SetRange("Factory No.", "Factory No.");
                HoFinLineRec.SetRange("Work Center No.", "Resource No.");
                HoFinLineRec.SetRange("Style No.", "Style No.");
                HoFinLineRec.SetRange(Type, HoFinLineRec.Type::Finishing);
                HoFinLineRec.SetFilter(Item, '=%1', 'PASS PCS');
                if HoFinLineRec.FindSet() then begin

                    // if HoFinLineRec."Style No." = '02817' then begin
                    //     Message('test');
                    // end;
                    Hour1F := HoFinLineRec."Hour 01";
                    Hour2F := HoFinLineRec."Hour 02";
                    Hour3F := HoFinLineRec."Hour 03";
                    Hour4F := HoFinLineRec."Hour 04";
                    Hour5F := HoFinLineRec."Hour 05";
                    Hour6F := HoFinLineRec."Hour 06";
                    Hour7F := HoFinLineRec."Hour 07";
                    Hour8F := HoFinLineRec."Hour 08";
                    Hour9F := HoFinLineRec."Hour 09";
                    Hour10F := HoFinLineRec."Hour 10";
                    LineNOFIn := HoFinLineRec."Work Center Name";
                    ItemFin := HoFinLineRec.Item;
                    FactoryNoFin := HoFinLineRec."Factory No.";
                    StylenameFIn := HoFinLineRec."Style No.";

                    if (HoFinLineRec."Style No." = StyleLC6) and (HoFinLineRec."Work Center No." = LineLC6) then begin
                        Hour1F := 0;
                        Hour2F := 0;
                        Hour3F := 0;
                        Hour4F := 0;
                        Hour5F := 0;
                        Hour6F := 0;
                        Hour7F := 0;
                        Hour8F := 0;
                        Hour9F := 0;
                        Hour10F := 0;

                    end;
                    StyleLC6 := HoProLiRec."Style No.";
                    LineLC6 := HoProLiRec."Work Center No.";

                    HoProLiRec.Reset();
                    HoProLiRec.SetRange("Style No.", HoFinLineRec."Style No.");
                    HoProLiRec.SetRange(Type, HoProLiRec.Type::Finishing);
                    HoProLiRec.SetFilter(Item, '=%1', 'PASS PCS');
                    if HoProLiRec.FindSet() then begin
                        HoProLiRec.CalcSums("Hour 01");
                        WFH1 := HoProLiRec."Hour 01";

                        HoProLiRec.CalcSums("Hour 02");
                        WFH2 := HoProLiRec."Hour 02";

                        HoProLiRec.CalcSums("Hour 03");
                        WFH3 := HoProLiRec."Hour 03";

                        HoProLiRec.CalcSums("Hour 04");
                        WFH4 := HoProLiRec."Hour 04";

                        HoProLiRec.CalcSums("Hour 05");
                        WFH5 := HoProLiRec."Hour 05";

                        HoProLiRec.CalcSums("Hour 06");
                        WFH6 := HoProLiRec."Hour 06";

                        HoProLiRec.CalcSums("Hour 07");
                        WFH7 := HoProLiRec."Hour 07";

                        HoProLiRec.CalcSums("Hour 08");
                        WFH8 := HoProLiRec."Hour 08";

                        HoProLiRec.CalcSums("Hour 09");
                        WFH9 := HoProLiRec."Hour 09";

                        HoProLiRec.CalcSums("Hour 10");
                        WFH10 := HoProLiRec."Hour 10";

                        WFHTot := WFH1 + WFH2 + WFH3 + WFH4 + WFH5 + WFH6 + WFH7 + WFH8 + WFH9 + WFH10;
                    end;

                    StylePoRec.Reset();
                    StylePoRec.SetRange("Style No.", HoFinLineRec."Style No.");
                    if StylePoRec.FindSet() then begin
                        StylePoRec.CalcSums("Sawing Out Qty");
                        WIPFin := StylePoRec."Sawing Out Qty";
                    end;
                    // WIPFin := WSHTot - WFHTot;
                end;
                //Factory Target Saw
                HoProLiRec.Reset();
                HoProLiRec.SetRange("Prod Date", PlanDate);
                HoProLiRec.SetRange("Factory No.", "Factory No.");
                HoProLiRec.SetRange("Style No.", "Style No.");
                HoProLiRec.SetRange("Work Center No.", "Resource No.");
                HoProLiRec.SetRange(Type, HoProLiRec.Type::Sewing);
                HoProLiRec.SetFilter(Item, '=%1', 'PASS PCS');
                if HoProLiRec.FindSet() then begin
                    TOt1Hour := HoProLiRec."Target_Hour 01";
                    TOt2Hour := HoProLiRec."Target_Hour 02";
                    TOt3Hour := HoProLiRec."Target_Hour 03";
                    TOt4Hour := HoProLiRec."Target_Hour 04";
                    TOt5Hour := HoProLiRec."Target_Hour 05";
                    TOt6Hour := HoProLiRec."Target_Hour 06";
                    TOt7Hour := HoProLiRec."Target_Hour 07";
                    TOt8Hour := HoProLiRec."Target_Hour 08";
                    TOt9Hour := HoProLiRec."Target_Hour 09";
                    TOt10Hour := HoProLiRec."Target_Hour 10";

                    if (HoProLiRec."Style No." = StyleLC7) and (HoProLiRec."Work Center No." = LineLC7) then begin
                        TOt1Hour := 0;
                        TOt2Hour := 0;
                        TOt3Hour := 0;
                        TOt4Hour := 0;
                        TOt5Hour := 0;
                        TOt6Hour := 0;
                        TOt7Hour := 0;
                        TOt8Hour := 0;
                        TOt9Hour := 0;
                        TOt10Hour := 0;

                    end;
                    StyleLC7 := HoProLiRec."Style No.";
                    LineLC7 := HoProLiRec."Work Center No.";
                end;
                //Factory Achive Finishing
                HoProLiRec.Reset();
                HoProLiRec.SetRange("Prod Date", PlanDate);
                HoProLiRec.SetRange("Factory No.", "Factory No.");
                // HoProLiRec.SetRange("Style No.", "Style No.");
                // HoProLiRec.SetRange("Work Center No.", "Resource No.");
                HoProLiRec.SetRange(Type, HoProLiRec.Type::Finishing);
                HoProLiRec.SetFilter(Item, '=%1', 'PASS PCS');
                if HoProLiRec.FindSet() then begin

                    HoProLiRec.CalcSums("Hour 01");
                    Hour1TotFin := HoProLiRec."Hour 01";

                    HoProLiRec.CalcSums("Hour 02");
                    Hour2TotFin := HoProLiRec."Hour 02";

                    HoProLiRec.CalcSums("Hour 03");
                    Hour3TotFin := HoProLiRec."Hour 03";

                    HoProLiRec.CalcSums("Hour 04");
                    Hour4TotFin := HoProLiRec."Hour 04";

                    HoProLiRec.CalcSums("Hour 05");
                    Hour5TotFin := HoProLiRec."Hour 05";

                    HoProLiRec.CalcSums("Hour 06");
                    Hour6TotFin := HoProLiRec."Hour 06";

                    HoProLiRec.CalcSums("Hour 07");
                    Hour7TotFin := HoProLiRec."Hour 07";

                    HoProLiRec.CalcSums("Hour 08");
                    Hour8TotFin := HoProLiRec."Hour 08";

                    HoProLiRec.CalcSums("Hour 09");
                    Hour9TotFin := HoProLiRec."Hour 09";

                    HoProLiRec.CalcSums("Hour 10");
                    Hour10TotFin := HoProLiRec."Hour 10";

                    if (HoProLiRec."Style No." = StyleLC5) and (HoProLiRec."Work Center No." = LineLC5) then begin
                        Hour1TotFin := 0;
                        Hour2TotFin := 0;
                        Hour3TotFin := 0;
                        Hour4TotFin := 0;
                        Hour5TotFin := 0;
                        Hour6TotFin := 0;
                        Hour7TotFin := 0;
                        Hour8TotFin := 0;
                        Hour9TotFin := 0;
                        Hour10TotFin := 0;
                    end;
                    TotalAchiveHoursFin := Hour1TotFin + Hour2TotFin + Hour3TotFin + Hour4TotFin + Hour5TotFin + Hour6TotFin + Hour7TotFin + Hour8TotFin + Hour9TotFin + Hour10TotFin;
                    StyleLC5 := HoProLiRec."Style No.";
                    LineLC5 := HoProLiRec."Work Center No.";
                end;



                //Factory Achive Saw
                HoProLiRec.Reset();
                HoProLiRec.SetRange("Prod Date", PlanDate);
                HoProLiRec.SetRange("Factory No.", "Factory No.");
                HoProLiRec.SetRange("Style No.", "Style No.");
                HoProLiRec.SetRange("Work Center No.", "Resource No.");
                HoProLiRec.SetRange(Type, HoProLiRec.Type::Sewing);
                HoProLiRec.SetFilter(Item, '=%1', 'PASS PCS');
                if HoProLiRec.FindSet() then begin

                    HoProLiRec.CalcSums("Hour 01");
                    Hour1Tot := HoProLiRec."Hour 01";

                    HoProLiRec.CalcSums("Hour 02");
                    Hour2Tot := HoProLiRec."Hour 02";

                    HoProLiRec.CalcSums("Hour 03");
                    Hour3Tot := HoProLiRec."Hour 03";

                    HoProLiRec.CalcSums("Hour 04");
                    Hour4Tot := HoProLiRec."Hour 04";

                    HoProLiRec.CalcSums("Hour 05");
                    Hour5Tot := HoProLiRec."Hour 05";

                    HoProLiRec.CalcSums("Hour 06");
                    Hour6Tot := HoProLiRec."Hour 06";

                    HoProLiRec.CalcSums("Hour 07");
                    Hour7Tot := HoProLiRec."Hour 07";

                    HoProLiRec.CalcSums("Hour 08");
                    Hour8Tot := HoProLiRec."Hour 08";

                    HoProLiRec.CalcSums("Hour 09");
                    Hour9Tot := HoProLiRec."Hour 09";

                    HoProLiRec.CalcSums("Hour 10");
                    Hour10Tot := HoProLiRec."Hour 10";

                    // if HoProLiRec."Work Center No." = 'VDL-02' then begin
                    //     Message('VDL2');
                    // end;

                    if (HoProLiRec."Style No." = StyleLC2) and (HoProLiRec."Work Center No." = LineLC2) then begin
                        Hour1Tot := 0;
                        Hour2Tot := 0;
                        Hour3Tot := 0;
                        Hour4Tot := 0;
                        Hour5Tot := 0;
                        Hour6Tot := 0;
                        Hour7Tot := 0;
                        Hour8Tot := 0;
                        Hour9Tot := 0;
                        Hour10Tot := 0;

                    end;
                    TotalAchiveHours := Hour1Tot + Hour2Tot + Hour3Tot + Hour4Tot + Hour5Tot + Hour6Tot + Hour7Tot + Hour8Tot + Hour9Tot + Hour10Tot;
                    StyleLC2 := HoProLiRec."Style No.";
                    LineLC2 := HoProLiRec."Work Center No.";
                end;

                //Group Achieve Saw
                HoProLiRec.Reset();
                HoProLiRec.SetRange("Prod Date", PlanDate);
                HoProLiRec.SetRange(Type, HoProLiRec.Type::Sewing);
                HoProLiRec.SetFilter(Item, '=%1', 'PASS PCS');
                if HoProLiRec.FindSet() then begin

                    HoProLiRec.CalcSums("Hour 01");
                    FactoryHour1Tot := HoProLiRec."Hour 01";

                    HoProLiRec.CalcSums("Hour 02");
                    FactoryHour2Tot := HoProLiRec."Hour 02";

                    HoProLiRec.CalcSums("Hour 03");
                    FactoryHour3Tot := HoProLiRec."Hour 03";

                    HoProLiRec.CalcSums("Hour 04");
                    FactoryHour4Tot := HoProLiRec."Hour 04";

                    HoProLiRec.CalcSums("Hour 05");
                    FactoryHour5Tot := HoProLiRec."Hour 05";

                    HoProLiRec.CalcSums("Hour 06");
                    FactoryHour6Tot := HoProLiRec."Hour 06";

                    HoProLiRec.CalcSums("Hour 07");
                    FactoryHour7Tot := HoProLiRec."Hour 07";

                    HoProLiRec.CalcSums("Hour 08");
                    FactoryHour8Tot := HoProLiRec."Hour 08";

                    HoProLiRec.CalcSums("Hour 09");
                    FactoryHour9Tot := HoProLiRec."Hour 09";

                    HoProLiRec.CalcSums("Hour 10");
                    FactoryHour10Tot := HoProLiRec."Hour 10";

                    if (HoProLiRec."Style No." = StyleLC3) and (HoProLiRec."Work Center No." = LineLC3) then begin
                        FactoryHour1Tot := 0;
                        FactoryHour2Tot := 0;
                        FactoryHour3Tot := 0;
                        FactoryHour4Tot := 0;
                        FactoryHour5Tot := 0;
                        FactoryHour6Tot := 0;
                        FactoryHour7Tot := 0;
                        FactoryHour8Tot := 0;
                        FactoryHour9Tot := 0;
                        FactoryHour10Tot := 0;
                    end;

                    TotalFactoryAchiveHours := FactoryHour1Tot + FactoryHour2Tot + FactoryHour3Tot + FactoryHour4Tot + FactoryHour5Tot + FactoryHour6Tot + FactoryHour7Tot + FactoryHour8Tot + FactoryHour9Tot + FactoryHour10Tot;
                    StyleLC3 := HoProLiRec."Style No.";
                    LineLC3 := HoProLiRec."Work Center No.";
                end;

                //Group Target
                HoProLiRec.Reset();
                HoProLiRec.SetRange("Prod Date", PlanDate);
                HoProLiRec.SetRange(Type, HoProLiRec.Type::Sewing);
                HoProLiRec.SetFilter(Item, '=%1', 'PASS PCS');
                if HoProLiRec.FindSet() then begin
                    HoProLiRec.CalcSums("Target_Hour 01");
                    FactoryH1 := HoProLiRec."Target_Hour 01";

                    HoProLiRec.CalcSums("Target_Hour 02");
                    FactoryH2 := HoProLiRec."Target_Hour 02";

                    HoProLiRec.CalcSums("Target_Hour 03");
                    FactoryH3 := HoProLiRec."Target_Hour 03";

                    HoProLiRec.CalcSums("Target_Hour 04");
                    FactoryH4 := HoProLiRec."Target_Hour 04";

                    HoProLiRec.CalcSums("Target_Hour 05");
                    FactoryH5 := HoProLiRec."Target_Hour 05";

                    HoProLiRec.CalcSums("Target_Hour 06");
                    FactoryH6 := HoProLiRec."Target_Hour 06";

                    HoProLiRec.CalcSums("Target_Hour 07");
                    FactoryH7 := HoProLiRec."Target_Hour 07";

                    HoProLiRec.CalcSums("Target_Hour 08");
                    FactoryH8 := HoProLiRec."Target_Hour 08";

                    HoProLiRec.CalcSums("Target_Hour 09");
                    FactoryH9 := HoProLiRec."Target_Hour 09";

                    HoProLiRec.CalcSums("Target_Hour 10");
                    FactoryH10 := HoProLiRec."Target_Hour 10";

                    if (HoProLiRec."Style No." = StyleLC9) and (HoProLiRec."Work Center No." = LineLC9) then begin
                        FactoryH1 := 0;
                        FactoryH2 := 0;
                        FactoryH3 := 0;
                        FactoryH4 := 0;
                        FactoryH5 := 0;
                        FactoryH6 := 0;
                        FactoryH7 := 0;
                        FactoryH8 := 0;
                        FactoryH9 := 0;
                        FactoryH10 := 0;
                    end;

                    TotalFactoryTargetHours := FactoryH1 + FactoryH2 + FactoryH3 + FactoryH4 + FactoryH5 + FactoryH6 + FactoryH7 + FactoryH8 + FactoryH9 + FactoryH10;
                    StyleLC9 := HoProLiRec."Style No.";
                    LineLC9 := HoProLiRec."Work Center No.";
                end;
                //Group Achieve Finishing
                HoProLiRec.Reset();
                HoProLiRec.SetRange("Prod Date", PlanDate);
                HoProLiRec.SetRange(Type, HoProLiRec.Type::Finishing);
                HoProLiRec.SetFilter(Item, '=%1', 'PASS PCS');
                if HoProLiRec.FindSet() then begin

                    HoProLiRec.CalcSums("Hour 01");
                    FactoryHour1TotFin := HoProLiRec."Hour 01";

                    HoProLiRec.CalcSums("Hour 02");
                    FactoryHour2TotFin := HoProLiRec."Hour 02";

                    HoProLiRec.CalcSums("Hour 03");
                    FactoryHour3TotFin := HoProLiRec."Hour 03";

                    HoProLiRec.CalcSums("Hour 04");
                    FactoryHour4TotFin := HoProLiRec."Hour 04";

                    HoProLiRec.CalcSums("Hour 05");
                    FactoryHour5TotFin := HoProLiRec."Hour 05";

                    HoProLiRec.CalcSums("Hour 06");
                    FactoryHour6TotFin := HoProLiRec."Hour 06";

                    HoProLiRec.CalcSums("Hour 07");
                    FactoryHour7TotFin := HoProLiRec."Hour 07";

                    HoProLiRec.CalcSums("Hour 08");
                    FactoryHour8TotFin := HoProLiRec."Hour 08";

                    HoProLiRec.CalcSums("Hour 09");
                    FactoryHour9TotFin := HoProLiRec."Hour 09";

                    HoProLiRec.CalcSums("Hour 10");
                    FactoryHour10TotFin := HoProLiRec."Hour 10";

                    // if (HoProLiRec."Style No." = StyleLC4) and (HoProLiRec."Work Center No." = LineLC4) then begin
                    //     FactoryHour1TotFin := 0;
                    //     FactoryHour2TotFin := 0;
                    //     FactoryHour3TotFin := 0;
                    //     FactoryHour4TotFin := 0;
                    //     FactoryHour5TotFin := 0;
                    //     FactoryHour6TotFin := 0;
                    //     FactoryHour7TotFin := 0;
                    //     FactoryHour8TotFin := 0;
                    //     FactoryHour9TotFin := 0;
                    //     FactoryHour10TotFin := 0;

                    // end;
                    FactoryTotalAchiveHoursFin := FactoryHour1TotFin + FactoryHour2TotFin + FactoryHour3TotFin + FactoryHour4TotFin + FactoryHour5TotFin + FactoryHour6TotFin + FactoryHour7TotFin + FactoryHour8TotFin + FactoryHour9TotFin + FactoryHour10TotFin;
                    StyleLC4 := HoProLiRec."Style No.";
                    LineLC4 := HoProLiRec."Work Center No.";
                end;


                ProdoutDate := 0D;
                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange(Type, ProductionHeaderRec.Type::Saw);
                ProductionHeaderRec.SetRange("Style No.", "Style No.");
                ProductionHeaderRec.SetFilter("Prod Updated", '=%1', 1);
                ProductionHeaderRec.SetCurrentKey("Prod Date");
                ProductionHeaderRec.Ascending(true);
                if ProductionHeaderRec.FindLast() then begin
                    ProdoutDate := ProductionHeaderRec."Prod Date";
                end;

                ProdOutFirstDate := 0D;
                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange(Type, ProductionHeaderRec.Type::Saw);
                ProductionHeaderRec.SetFilter("Prod Updated", '=%1', 1);
                ProductionHeaderRec.SetCurrentKey("Prod Date");
                ProductionHeaderRec.Ascending(true);
                if ProductionHeaderRec.FindFirst() then begin
                    ProdOutFirstDate := ProductionHeaderRec."Prod Date";
                end;

                NavAppProdRec.Reset();
                NavAppProdRec.SetRange("Style No.", "Style No.");
                NavAppProdRec.SetRange("Resource No.", "Resource No.");
                // NavAppProdRec.SetRange("PO No.", "PO No.");
                NavAppProdRec.SetCurrentKey(PlanDate);
                NavAppProdRec.Ascending(true);
                if NavAppProdRec.FindFirst() then begin
                    NavappfirstDate := NavAppProdRec.PlanDate;
                end;

                VarienceNew := 0;
                NavAppProdRec.Reset();
                NavAppProdRec.SetRange("Style No.", "Style No.");
                NavAppProdRec.SetRange("Resource No.", "Resource No.");
                // NavAppProdRec.SetRange("PO No.", "PO No.");
                NavAppProdRec.SetRange("Lot No.", "Lot No.");
                NavAppProdRec.SetFilter(PlanDate, '%1..%2', NavappfirstDate, ProdoutDate);
                if NavAppProdRec.FindSet() then begin
                    repeat
                        VarienceNew += NavAppProdRec.ProdUpdQty - NavAppProdRec.Qty;
                    until NavAppProdRec.Next() = 0;
                end;
                Target1 := 0;
                Hours := 0;
                HourlyTarget := 0;
                // HourlyTarger2 := 0;
                DayTarget := 0;
                HoProLineRec.Reset();
                HoProLineRec.SetRange("Prod Date", PlanDate);
                HoProLineRec.SetRange("Style No.", "Style No.");
                HoProLineRec.SetRange(Type, HoProLineRec.Type::Sewing);
                HoProLineRec.SetRange("Factory No.", "Factory No.");
                HoProLineRec.SetFilter(Item, '=%1', 'PASS PCS');
                HoProLineRec.SetRange("Work Center No.", "Resource No.");
                if HoProLineRec.FindSet() then begin

                    DayTarget := HoProLineRec.Target;

                    Target1 := DayTarget;
                    if ("Style No." = StyleLC) and ("Resource No." = LineLC) then begin
                        DayTarget := 0;
                    end;
                    StyleLC := "Style No.";
                    LineLC := "Resource No.";
                end;

                //Working Hours
                if Hours > 0 then
                    HourlyTarget += DayTarget / Hours
                else
                    HourlyTarget := 0;

                TOtalTarget := HourlyTarget;
                //Hourly Target

                HourlyTarger2 := (60 / SMV) * (Eff / 100.00) * MC;


                //Company Logo
                comRec.Get;
                comRec.CalcFields(Picture);

                StyleRec.Reset();
                StyleRec.SetRange("No.", "Style No.");
                if StyleRec.FindFirst() then begin
                    BuyerName := StyleRec."Buyer Name";
                    Style := StyleRec."Style No.";
                    Factory := StyleRec."Factory Name";
                    GarmentType := StyleRec."Garment Type Name";
                    MerchandizerName := StyleRec."Merchandiser Name";
                    BrandName := StyleRec."Brand Name";
                    CM := StyleRec."CM Price (Doz)";

                end;

                WorkcenterRec.Reset();
                WorkcenterRec.SetRange("No.", "Resource No.");
                if WorkcenterRec.FindFirst() then begin
                    ResourceName := WorkcenterRec.Name;
                end;

                NavLinesRec.Reset();
                NavLinesRec.SetRange("Style No.", "Style No.");
                NavLinesRec.SetRange("PO No.", "PO No.");
                NavLinesRec.SetRange("Line No.", "Line No.");
                if NavLinesRec.FindFirst() then begin
                    InputDate := NavLinesRec.StartDateTime;
                    OutputComDate := NavLinesRec.FinishDateTime;
                    PlanTarget := NavLinesRec.Target;
                    MC := NavLinesRec.Carder;
                end;


                AchieveQty := 0;
                NavAppProdRec.Reset();
                NavAppProdRec.SetRange("Style No.", "Style No.");
                NavAppProdRec.SetRange("Resource No.", "Resource No.");
                if NavAppProdRec.FindSet() then begin
                    repeat
                        AchieveQty += NavAppProdRec.ProdUpdQty;
                    until NavAppProdRec.Next() = 0;
                end;


                PlanedQty := 0;
                NavLinesRec.Reset();
                NavLinesRec.SetRange("Style No.", "Style No.");
                NavLinesRec.SetRange("Resource No.", "Resource No.");
                if NavLinesRec.FindSet() then begin
                    repeat
                        PlanedQty += NavLinesRec.Qty;
                    until NavLinesRec.Next() = 0;
                end;

                PlanQty := PlanedQty + AchieveQty;

                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Style No.");
                StylePoRec.SetRange("Lot No.", "Lot No.");
                // StylePoRec.SetRange("PO No.", "PO No.");
                if StylePoRec.FindFirst() then begin
                    PoNo := StylePoRec."PO No.";
                    ShipDate := StylePoRec."Ship Date";
                    OrderQy := StylePoRec.Qty;
                end;

                //Input/Output Total
                InputQtyTodayTotal := 0;
                OutputQty := 0;
                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange("Style No.", "Style No.");
                ProductionHeaderRec.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec.SetFilter("Prod Date", '%1..%2', ProdOutFirstDate, PlanDate);
                ProductionHeaderRec.SetRange(Type, ProductionHeaderRec.Type::Saw);
                if ProductionHeaderRec.Findset() then begin
                    repeat
                        InputQtyTodayTotal += ProductionHeaderRec."Input Qty";
                        OutputQty += ProductionHeaderRec."Output Qty";
                    until ProductionHeaderRec.Next() = 0;
                end;

                //Input/Output Today
                InputQtyTodayTo := 0;
                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange("Style No.", "Style No.");
                ProductionHeaderRec.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec.SetRange("Prod Date", PlanDate);
                ProductionHeaderRec.SetRange(Type, ProductionHeaderRec.Type::Saw);
                if ProductionHeaderRec.FindFirst() then begin
                    InputQtyTodayTo := ProductionHeaderRec."Input Qty";
                end;


                //Cutting
                //Input/Ouput Total (up to date)
                CutInputQtyTotal := 0;
                CutOutputQtyTotal := 0;
                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange("Style No.", "Style No.");
                ProductionHeaderRec.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec.SetFilter("Prod Date", '%1..%2', ProdOutFirstDate, PlanDate);
                ProductionHeaderRec.SetFilter(Type, '=%1', ProductionHeaderRec.Type::Cut);
                if ProductionHeaderRec.FindSet() then begin
                    repeat
                        CutInputQtyTotal += ProductionHeaderRec."Input Qty";
                        CutOutputQtyTotal += ProductionHeaderRec."Output Qty";
                    until ProductionHeaderRec.Next() = 0;
                end;


                CutInputToday := 0;
                //Input/Ouput Today (up to date)
                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange("Style No.", "Style No.");
                ProductionHeaderRec.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec.SetRange("Prod Date", PlanDate);
                ProductionHeaderRec.SetFilter(Type, '=%1', ProductionHeaderRec.Type::Cut);
                if ProductionHeaderRec.FindFirst() then begin
                    CutInputToday := ProductionHeaderRec."Output Qty";
                end;

                //EMB
                EMBInputQtyTotal := 0;
                EMBOutputQtyTotal := 0;
                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange("Style No.", "Style No.");
                ProductionHeaderRec.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec.SetFilter("Prod Date", '%1..%2', ProdOutFirstDate, PlanDate);
                ProductionHeaderRec.SetFilter(Type, '=%1', ProductionHeaderRec.Type::Emb);
                if ProductionHeaderRec.Findset() then begin
                    repeat
                        EMBInputQtyTotal += ProductionHeaderRec."Input Qty";
                        EMBOutputQtyTotal += ProductionHeaderRec."Output Qty";
                    until ProductionHeaderRec.Next() = 0;
                end;

                //Input WIP 
                ProductionHeaderRec.Reset();
                ProductionHeaderRec.SetRange("Style No.", "Style No.");
                ProductionHeaderRec.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec.SetRange("Prod Date", PlanDate);
                ProductionHeaderRec.SetFilter(Type, '=%1', ProductionHeaderRec.Type::Emb);
                if ProductionHeaderRec.FindFirst() then begin
                    if ProductionHeaderRec."Input Qty" > 0 then
                        InputWIP := EMBOutputQtyTotal - InputQtyTodayTotal
                    else
                        InputWIP := CutInputQtyTotal - InputQtyTodayTotal;
                end;


                // Wash today
                SendWashQty := 0;
                ProductionHeaderRec4.Reset();
                ProductionHeaderRec4.SetRange("Style No.", "Style No.");
                ProductionHeaderRec4.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec4.SetRange("Prod Date", PlanDate);
                ProductionHeaderRec4.SetFilter(Type, '=%1', ProductionHeaderRec3.Type::Wash);
                if ProductionHeaderRec4.FindFirst() then begin
                    SendWashQty := ProductionHeaderRec4."Input Qty";
                    ReceiveWashQty := ProductionHeaderRec4."Output Qty";
                end;

                //Wash total
                ReceiveWashQty := 0;
                ProductionHeaderRec4.Reset();
                ProductionHeaderRec4.SetRange("Style No.", "Style No.");
                ProductionHeaderRec4.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec4.SetFilter("Prod Date", '%1..%2', ProdOutFirstDate, PlanDate);
                ProductionHeaderRec4.SetFilter(Type, '=%1', ProductionHeaderRec4.Type::Wash);
                if ProductionHeaderRec4.FindSet() then begin
                    repeat
                        SendWashQty += ProductionHeaderRec4."Input Qty";
                        RCVWashTotal += ProductionHeaderRec4."Output Qty";
                    until ProductionHeaderRec4.Next() = 0;
                end;


                //Output Start Date
                OutPutStartDate := 0D;
                ProductionHeaderRec2.Reset();
                ProductionHeaderRec2.SetRange("Style No.", "Style No.");
                ProductionHeaderRec2.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec2.SetFilter("Output Qty", '<>%1', 0);
                ProductionHeaderRec2.SetFilter(Type, '=%1', ProductionHeaderRec3.Type::Saw);
                ProductionHeaderRec2.SetCurrentKey("Prod Date");
                ProductionHeaderRec2.Ascending(true);
                if ProductionHeaderRec2.FindFirst() then begin
                    OutPutStartDate := ProductionHeaderRec2."Prod Date";
                end;


                PlanInput := 0D;
                NavAppProdRec.Reset();
                NavAppProdRec.SetRange("Style No.", "Style No.");
                NavAppProdRec.SetRange("Resource No.", "Resource No.");
                NavAppProdRec.SetCurrentKey(PlanDate);
                NavAppProdRec.Ascending(true);
                if NavAppProdRec.FindFirst() then begin
                    PlanInput := NavAppProdRec.PlanDate - 2;
                end;

                // Actual Finish Date
                ActualFinishDate := 0D;
                ProductionHeaderRec4.Reset();
                ProductionHeaderRec4.SetRange("Style No.", "Style No.");
                ProductionHeaderRec4.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec4.SetFilter("Output Qty", '<>%1', 0);
                ProductionHeaderRec4.SetFilter(Type, '=%1', ProductionHeaderRec4.Type::Saw);
                ProductionHeaderRec4.SetCurrentKey("Prod Date");
                ProductionHeaderRec4.Ascending(true);
                if ProductionHeaderRec4.FindLast() then begin
                    ActualFinishDate := ProductionHeaderRec4."Prod Date";
                end;

                //Actual Input Date
                ActualInputDate := 0D;
                ProductionHeaderRec3.Reset();
                ProductionHeaderRec3.SetRange("Style No.", "Style No.");
                ProductionHeaderRec3.SetRange("Resource No.", "Resource No.");
                ProductionHeaderRec3.SetFilter("Input Qty", '<>%1', 0);
                ProductionHeaderRec3.SetFilter(Type, '=%1', ProductionHeaderRec3.Type::Saw);
                ProductionHeaderRec3.SetCurrentKey("Prod Date");
                ProductionHeaderRec3.Ascending(true);
                if ProductionHeaderRec3.FindFirst() then
                    ActualInputDate := ProductionHeaderRec3."Prod Date";

                //Plan finsh date
                Planfinish := 0D;
                NavAppProdRec.Reset();
                NavAppProdRec.SetRange("Style No.", "Style No.");
                NavAppProdRec.SetRange("Resource No.", "Resource No.");
                NavAppProdRec.SetCurrentKey(PlanDate);
                NavAppProdRec.Ascending(true);
                if NavAppProdRec.FindLast() then begin
                    Planfinish := NavAppProdRec.PlanDate;
                end;

                TargetProdPlan := 0;
                NavAppProdRec.Reset();
                NavAppProdRec.SetRange("Style No.", "Style No.");
                NavAppProdRec.SetRange("Resource No.", "Resource No.");
                NavAppProdRec.SetRange("Factory No.", "Factory No.");
                NavAppProdRec.SetFilter("PlanDate", '<=%1', PlanDate);
                if NavAppProdRec.FindSet() then begin
                    repeat
                        TargetProdPlan += NavAppProdRec.Qty;
                    until NavAppProdRec.Next() = 0;
                end;



                LocationRec.SetRange(Code, "Factory No.");
                if LocationRec.FindFirst() then begin
                    FactoryName := LocationRec.Name;
                end;


                //CM (Pcs) of the style
                CMPcs := 0;
                EstCostRec.Reset();
                EstCostRec.SetRange("Style No.", "Style No.");
                if EstCostRec.FindSet() then
                    CMPcs := EstCostRec."MFG Cost Pcs";

                WorkingHrs := 0;
                ResCapacityEntryRec.Reset();
                ResCapacityEntryRec.SETRANGE("No.", "Resource No.");
                ResCapacityEntryRec.SETRANGE(Date, PlanDate);
                if ResCapacityEntryRec.FindSet() then begin
                    repeat
                        WorkingHrs += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                    until ResCapacityEntryRec.Next() = 0;

                end;

            end;

            trigger OnPreDataItem()
            begin

                SetRange(PlanDate, FilterDate);
                SetRange("Factory No.", FactortFilter);

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

                    field(FactortFilter; FactortFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';

                        trigger OnLookup(var texts: text): Boolean
                        var
                            LocationRec: Record Location;
                            UserRec: Record "User Setup";
                        begin
                            UserRec.Reset();
                            UserRec.Get(UserId);

                            LocationRec.Reset();
                            if UserRec.UserRole <> 'CHAIRMAN USER' then
                                LocationRec.SetRange(Code, UserRec."Factory Code");

                            LocationRec.SetFilter("Sewing Unit", '=%1', true);
                            if LocationRec.FindSet() then begin
                                if Page.RunModal(15, LocationRec) = Action::LookupOK then begin
                                    FactortFilter := LocationRec.Code;
                                end;
                            end;
                        end;
                    }

                    field(FilterDate; FilterDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Production Date';
                    }
                }
            }
        }
    }


    trigger OnInitReport()
    var
    begin
        FilterDate := WorkDate();
    end;

    var
        HourlyLineRec: Record "Hourly Production Lines";
        WFHTot: Integer;
        WIPFin: Integer;
        ResCapacityEntryRec: Record "Calendar Entry";
        WorkingHrs: Decimal;
        StyleLC9: Code[20];
        LineLC9: Code[20];
        FactoryH1: Decimal;
        FactoryH2: Decimal;
        FactoryH3: Decimal;
        FactoryH4: Decimal;
        FactoryH5: Decimal;
        FactoryH6: Decimal;
        FactoryH7: Decimal;
        FactoryH8: Decimal;
        FactoryH9: Decimal;
        FactoryH10: Decimal;
        TOt1Hour0: Decimal;
        FactoryQty: Decimal;
        FactoyHours: Decimal;
        StyleLC8: Code[20];
        LineLC8: Code[20];
        StyleLC7: Code[20];
        LineLC7: Code[20];
        StyleLC6: Code[20];
        LineLC6: Code[20];
        StyleLC5: Code[20];
        LineLC5: Code[20];
        StyleLC4: Code[20];
        LineLC4: Code[20];
        StyleLC3: Code[20];
        LineLC3: Code[20];
        StyleLC2: Code[20];
        LineLC2: Code[20];
        Target1: Decimal;
        StyleLC: Code[20];
        LineLC: Code[20];
        TimeVariable: Time;
        TOt1Hour: Decimal;
        TOt2Hour: Decimal;
        TOt3Hour: Decimal;
        TOt4Hour: Decimal;
        TOt5Hour: Decimal;
        TOt6Hour: Decimal;
        TOt7Hour: Decimal;
        TOt8Hour: Decimal;
        TOt9Hour: Decimal;
        TOt10Hour: Decimal;
        HourlyTarger2: Decimal;
        FactoryTotalAchiveHoursFin: Integer;
        FactoryHour1TotFin: Integer;
        FactoryHour2TotFin: Integer;
        FactoryHour3TotFin: Integer;
        FactoryHour4TotFin: Integer;
        FactoryHour5TotFin: Integer;
        FactoryHour6TotFin: Integer;
        FactoryHour7TotFin: Integer;
        FactoryHour8TotFin: Integer;
        FactoryHour9TotFin: Integer;
        FactoryHour10TotFin: Integer;
        FactoryCodeTotal: Code[20];
        TotalFactoryTargetHours: Decimal;
        TotalFactoryAchiveHours: Decimal;
        FactoryHour1Tot: Integer;
        FactoryHour2Tot: Integer;
        FactoryHour3Tot: Integer;
        FactoryHour4Tot: Integer;
        FactoryHour5Tot: Integer;
        FactoryHour6Tot: Integer;
        FactoryHour7Tot: Integer;
        FactoryHour8Tot: Integer;
        FactoryHour9Tot: Integer;
        FactoryHour10Tot: Integer;
        NavappfirstDate: Date;
        SendWashTotal: BigInteger;
        RCVWashTotal: BigInteger;
        Hours: Decimal;
        ProdOutFirstDate: Date;
        ProdoutDate: Date;
        AchieveQty: Integer;
        PlanedQty: Decimal;
        VarienceNew: Decimal;
        TOtalTarget: Decimal;
        TotalAchiveHoursFin: Integer;
        Hour1TotFin: Integer;
        Hour2TotFin: Integer;
        Hour3TotFin: Integer;
        Hour4TotFin: Integer;
        Hour5TotFin: Integer;
        Hour6TotFin: Integer;
        Hour7TotFin: Integer;
        Hour8TotFin: Integer;
        Hour9TotFin: Integer;
        Hour10TotFin: Integer;
        FactoryNoFin: Code[20];
        LineNOFIn: Text[50];
        ItemFin: Text[50];
        StylenameFIn: Text[100];
        Hour1F: Integer;
        Hour2F: Integer;
        Hour3F: Integer;
        Hour4F: Integer;
        Hour5F: Integer;
        Hour6F: Integer;
        Hour7F: Integer;
        Hour8F: Integer;
        Hour9F: Integer;
        Hour10F: Integer;
        HoFinLineRec: Record "Hourly Production Lines";
        TotalAchiveHours: Integer;
        Hour1Tot: Integer;
        Hour2Tot: Integer;
        Hour3Tot: Integer;
        Hour4Tot: Integer;
        Hour5Tot: Integer;
        Hour6Tot: Integer;
        Hour7Tot: Integer;
        Hour8Tot: Integer;
        Hour9Tot: Integer;
        Hour10Tot: Integer;
        HoProLiRec: Record "Hourly Production Lines";
        StyleName: Text[100];
        CM: Decimal;
        DayTarget: Decimal;
        CutInputToday: BigInteger;
        InputWIP: decimal;
        HourlyTarget: Decimal;
        TargetProdPlan: Decimal;
        ActualFinishDate: Date;
        ProductionHeaderRec4: Record ProductionOutHeader;
        ProductionHeaderRec3: Record ProductionOutHeader;
        ActualInputDate: Date;
        Planfinish: Date;
        NavAppProdRec2: Record "NavApp Prod Plans Details";
        PlanInput: Date;
        NavAppProdRec: Record "NavApp Prod Plans Details";
        EstCostRec: Record "BOM Estimate Cost";
        BrandName: Text[50];
        FactoryName: Text[100];
        LocationRec: Record Location;
        PoNo: Code[20];
        FactortFilter: Code[20];
        FilterDate: Date;
        ActualPlanDT: Date;
        variance: Decimal;
        TodayOutput: BigInteger;
        comRec: Record "Company Information";
        OutputQty: BigInteger;
        InputQtyTodayTotal: BigInteger;
        InputQtyTodayTo: BigInteger;
        EMBInputQtyTotal: BigInteger;
        EMBOutputQtyTotal: BigInteger;
        CutInputQtyTotal: BigInteger;
        CutOutputQtyTotal: BigInteger;
        MerchandizerName: Text[50];
        MC: Integer;
        OutPutStartDate: Date;
        ProductionHeaderRec: Record ProductionOutHeader;
        ProductionHeaderRec2: Record ProductionOutHeader;
        OrderQy: BigInteger;
        ShipDate: Date;
        StylePoRec: Record "Style Master PO";
        PlanTarget: BigInteger;
        OutputComDate: DateTime;
        InputDate: DateTime;
        PlanQty: BigInteger;
        NavLinesRec: Record "NavApp Planning Lines";
        GarmentType: Text[50];
        ResourceName: Text[100];
        WorkcenterRec: Record "Work Center";
        BuyerName: Text[50];
        StyleRec: Record "Style Master";
        Factory: Text[100];
        Style: Text[50];
        CMPcs: Decimal;
        SendWashQty: Decimal;
        ReceiveWashQty: Decimal;

}