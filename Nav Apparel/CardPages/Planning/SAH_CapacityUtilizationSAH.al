page 50855 CapacityUtilizationSAH
{
    PageType = Card;
    SourceTable = SAH_CapacityUtiliSAHHeader;
    Caption = 'Capacity Utilization By SAH';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(No; rec.No)
                {
                    ApplicationArea = all;
                    Editable = false;

                }

                field(Year; rec.Year)
                {
                    ApplicationArea = all;
                }
            }

            group("Capacity Allocation")
            {
                part(SAH_CapacityAllocationListPart; SAH_CapacityAllocationListPart)
                {
                    ApplicationArea = All;
                    Caption = '';
                    SubPageLink = Year = field(Year);
                }
            }

            group("Plan Efficiency")
            {
                part(SAH_PlanEfficiencyListPart; SAH_PlanEfficiencyListPart)
                {
                    ApplicationArea = All;
                    Caption = '';
                    SubPageLink = Year = field(Year);
                }
            }

            group("Factory Capacity")
            {
                part(SAH_FactoryCapacityListPart; SAH_FactoryCapacityListPart)
                {
                    ApplicationArea = All;
                    Caption = '';
                    SubPageLink = Year = field(Year);
                }
            }

            group("Merchand Group Wise Allocation")
            {
                part(SAH_MerchGRPWiseAlloListPart; SAH_MerchGRPWiseAlloListPart)
                {
                    ApplicationArea = All;
                    Caption = '';
                    SubPageLink = Year = field(Year);
                }
            }

            group("SAH Used")
            {
                part(SAH_MerchGRPWiseSAHUseListPart; SAH_MerchGRPWiseSAHUseListPart)
                {
                    ApplicationArea = All;
                    Caption = '';
                    //SubPageLink = Year = field(Year);
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Generate Data")
            {
                ApplicationArea = All;
                Image = CreateYear;

                trigger OnAction();
                var
                    CapacityAlloRec: Record SAH_CapacityAllocation;
                    PlanEfficiencyRec: Record SAH_PlanEfficiency;
                    FactoryCapacityRec: Record SAH_FactoryCapacity;
                    SAH_MerchGRPWiseAllocRec: Record SAH_MerchGRPWiseAllocation;
                    MerchanGroupTableRec: Record MerchandizingGroupTable;
                    LocationsRec: Record Location;
                    WorkCenterRec: Record "Work Center";
                    CalenderRec: Record "Calendar Entry";
                    CustomerRec: Record Customer;
                    StyleMasterRec: Record "Style Master";
                    StyleMasterPORec: Record "Style Master PO";
                    SAH_MerchGRPWiseBalRec: Record SAH_MerchGRPWiseBalance;
                    SAH_MerchGRPWiseAvgSMVRec: Record SAH_MerchGRPWiseAvgSMV;
                    SeqNo: BigInteger;
                    Total1: Decimal;
                    Total2: Decimal;
                    Total3: Decimal;
                    Total4: Decimal;
                    Total5: Decimal;
                    Total6: Decimal;
                    Total7: Decimal;
                    Total8: Decimal;
                    Total9: Decimal;
                    Total10: Decimal;
                    Total11: Decimal;
                    Total12: Decimal;
                    Total1_A: Decimal;
                    Total2_A: Decimal;
                    Total3_A: Decimal;
                    Total4_A: Decimal;
                    Total5_A: Decimal;
                    Total6_A: Decimal;
                    Total7_A: Decimal;
                    Total8_A: Decimal;
                    Total9_A: Decimal;
                    Total10_A: Decimal;
                    Total11_A: Decimal;
                    Total12_A: Decimal;
                    TotalAvgSMV1: Decimal;
                    TotalAvgSMV2: Decimal;
                    TotalAvgSMV3: Decimal;
                    TotalAvgSMV4: Decimal;
                    TotalAvgSMV5: Decimal;
                    TotalAvgSMV6: Decimal;
                    TotalAvgSMV7: Decimal;
                    TotalAvgSMV8: Decimal;
                    TotalAvgSMV9: Decimal;
                    TotalAvgSMV10: Decimal;
                    TotalAvgSMV11: Decimal;
                    TotalAvgSMV12: Decimal;
                    Total1_POQty: Decimal;
                    Total2_POQty: Decimal;
                    Total3_POQty: Decimal;
                    Total4_POQty: Decimal;
                    Total5_POQty: Decimal;
                    Total6_POQty: Decimal;
                    Total7_POQty: Decimal;
                    Total8_POQty: Decimal;
                    Total9_POQty: Decimal;
                    Total10_POQty: Decimal;
                    Total11_POQty: Decimal;
                    Total12_POQty: Decimal;
                    Carders: Integer;
                    HoursPerDay: Decimal;
                    NoofDays: Decimal;
                    NoofDays1: Decimal;
                    NoofDays2: Decimal;
                    NoofDays3: Decimal;
                    NoofDays4: Decimal;
                    NoofDays5: Decimal;
                    NoofDays6: Decimal;
                    NoofDays7: Decimal;
                    NoofDays8: Decimal;
                    NoofDays9: Decimal;
                    NoofDays10: Decimal;
                    NoofDays11: Decimal;
                    NoofDays12: Decimal;
                    i: Integer;
                    StartDate: date;
                    FinishDate: Date;
                    MerGR: Code[20];
                    Month: Integer;
                begin

                    if rec.Year > 0 then begin

                        /////////////////////////////Capacity Allocations
                        //Get max record
                        CapacityAlloRec.Reset();
                        if CapacityAlloRec.Findlast() then
                            SeqNo := CapacityAlloRec."No.";

                        //Check for existing records
                        CapacityAlloRec.Reset();
                        CapacityAlloRec.SetRange(Year, rec.Year);
                        if not CapacityAlloRec.FindSet() then begin

                            //Get all the factories
                            LocationsRec.Reset();
                            LocationsRec.SetFilter("Sewing Unit", '=%1', true);
                            if LocationsRec.FindSet() then begin
                                repeat

                                    //Get all the lines for the above factory
                                    WorkCenterRec.Reset();
                                    WorkCenterRec.SetRange("Factory No.", LocationsRec.Code);
                                    if WorkCenterRec.FindSet() then begin
                                        repeat
                                            SeqNo += 1;

                                            //Insert lines
                                            CapacityAlloRec.Init();
                                            CapacityAlloRec."No." := SeqNo;
                                            CapacityAlloRec.Year := rec.Year;
                                            CapacityAlloRec."Factory Code" := LocationsRec.Code;
                                            CapacityAlloRec."Factory Name" := LocationsRec.Name;
                                            CapacityAlloRec."Line No." := WorkCenterRec."No.";
                                            CapacityAlloRec."Line Name" := WorkCenterRec.Name;
                                            CapacityAlloRec."Created User" := UserId;
                                            CapacityAlloRec.Insert();

                                        until WorkCenterRec.Next() = 0;
                                    end;

                                until LocationsRec.Next() = 0;
                            end;
                        end;


                        ///////////////////////////////Planning Efficiency                        
                        //Check for existing records
                        PlanEfficiencyRec.Reset();
                        PlanEfficiencyRec.SetRange(Year, rec.Year);
                        if not PlanEfficiencyRec.FindSet() then begin
                            //Insert lines
                            PlanEfficiencyRec.Init();
                            PlanEfficiencyRec.Year := rec.Year;
                            PlanEfficiencyRec."Created User" := UserId;
                            PlanEfficiencyRec.Insert();
                        end;


                        ////////////////////////////////////Factory Capacity                      
                        //Get all the factories
                        LocationsRec.Reset();
                        LocationsRec.SetFilter("Sewing Unit", '=%1', true);
                        if LocationsRec.FindSet() then begin
                            repeat
                                HoursPerDay := (LocationsRec."Finish Time" - LocationsRec."Start Time") / 3600000;
                                Total1 := 0;
                                Total2 := 0;
                                Total3 := 0;
                                Total4 := 0;
                                Total5 := 0;
                                Total6 := 0;
                                Total7 := 0;
                                Total8 := 0;
                                Total9 := 0;
                                Total10 := 0;
                                Total11 := 0;
                                Total12 := 0;

                                //Get all the lines for the above factory
                                WorkCenterRec.Reset();
                                WorkCenterRec.SetRange("Factory No.", LocationsRec.Code);
                                if WorkCenterRec.FindSet() then begin
                                    repeat
                                        Carders := WorkCenterRec.Carder;

                                        //No of days for a month
                                        for i := 1 to 12 do begin

                                            StartDate := DMY2DATE(1, i, rec.Year);

                                            case i of
                                                1:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                                2:
                                                    begin
                                                        if rec.Year mod 4 = 0 then
                                                            FinishDate := DMY2DATE(29, i, rec.Year)
                                                        else
                                                            FinishDate := DMY2DATE(28, i, rec.Year);
                                                    end;
                                                3:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                                4:
                                                    FinishDate := DMY2DATE(30, i, rec.Year);
                                                5:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                                6:
                                                    FinishDate := DMY2DATE(30, i, rec.Year);
                                                7:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                                8:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                                9:
                                                    FinishDate := DMY2DATE(30, i, rec.Year);
                                                10:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                                11:
                                                    FinishDate := DMY2DATE(30, i, rec.Year);
                                                12:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                            end;


                                            //Get no of working days
                                            CalenderRec.Reset();
                                            CalenderRec.SETRANGE("No.", WorkCenterRec."No.");
                                            CalenderRec.SETRANGE(Date, StartDate, FinishDate);
                                            NoofDays := 0;

                                            if CalenderRec.FindSet() then begin
                                                repeat
                                                    if CalenderRec."Capacity (Total)" > 0 then
                                                        NoofDays += 1;
                                                until CalenderRec.Next() = 0;
                                            end;


                                            //Get efficiency
                                            PlanEfficiencyRec.Reset();
                                            PlanEfficiencyRec.SetRange(Year, rec.Year);
                                            PlanEfficiencyRec.FindSet();

                                            case i of
                                                1:
                                                    begin
                                                        NoofDays1 := NoofDays;
                                                        Total1 += (Carders * HoursPerDay * NoofDays1 * PlanEfficiencyRec.JAN) / 100;
                                                    end;
                                                2:
                                                    begin
                                                        NoofDays2 := NoofDays;
                                                        Total2 += (Carders * HoursPerDay * NoofDays2 * PlanEfficiencyRec.FEB) / 100;
                                                    end;
                                                3:
                                                    begin
                                                        NoofDays3 := NoofDays;
                                                        Total3 += (Carders * HoursPerDay * NoofDays3 * PlanEfficiencyRec.MAR) / 100;
                                                    end;
                                                4:
                                                    begin
                                                        NoofDays4 := NoofDays;
                                                        Total4 += (Carders * HoursPerDay * NoofDays4 * PlanEfficiencyRec.APR) / 100;
                                                    end;
                                                5:
                                                    begin
                                                        NoofDays5 := NoofDays;
                                                        Total5 += (Carders * HoursPerDay * NoofDays5 * PlanEfficiencyRec.MAY) / 100;
                                                    end;
                                                6:
                                                    begin
                                                        NoofDays6 := NoofDays;
                                                        Total6 += (Carders * HoursPerDay * NoofDays6 * PlanEfficiencyRec.JUN) / 100;
                                                    end;
                                                7:
                                                    begin
                                                        NoofDays7 := NoofDays;
                                                        Total7 += (Carders * HoursPerDay * NoofDays7 * PlanEfficiencyRec.JUL) / 100;
                                                    end;
                                                8:
                                                    begin
                                                        NoofDays8 := NoofDays;
                                                        Total8 += (Carders * HoursPerDay * NoofDays8 * PlanEfficiencyRec.AUG) / 100;
                                                    end;
                                                9:
                                                    begin
                                                        NoofDays9 := NoofDays;
                                                        Total9 += (Carders * HoursPerDay * NoofDays9 * PlanEfficiencyRec.SEP) / 100;
                                                    end;
                                                10:
                                                    begin
                                                        NoofDays10 := NoofDays;
                                                        Total10 += (Carders * HoursPerDay * NoofDays10 * PlanEfficiencyRec.OCT) / 100;
                                                    end;
                                                11:
                                                    begin
                                                        NoofDays11 := NoofDays;
                                                        Total11 += (Carders * HoursPerDay * NoofDays11 * PlanEfficiencyRec.NOV) / 100;
                                                    end;
                                                12:
                                                    begin
                                                        NoofDays12 := NoofDays;
                                                        Total12 += (Carders * HoursPerDay * NoofDays12 * PlanEfficiencyRec.DEC) / 100;
                                                    end;
                                            end;

                                        end;

                                    until WorkCenterRec.Next() = 0;
                                end;


                                //Check for existing records
                                FactoryCapacityRec.Reset();
                                FactoryCapacityRec.SetRange(Year, rec.Year);
                                FactoryCapacityRec.SetRange("Factory Code", LocationsRec.Code);
                                if not FactoryCapacityRec.FindSet() then begin  //insert

                                    //Insert lines
                                    FactoryCapacityRec.Init();
                                    FactoryCapacityRec.Year := rec.Year;
                                    FactoryCapacityRec."Factory Code" := LocationsRec.Code;
                                    FactoryCapacityRec."Factory Name" := LocationsRec.Name;
                                    FactoryCapacityRec.JAN := Total1;
                                    FactoryCapacityRec.FEB := Total2;
                                    FactoryCapacityRec.MAR := Total3;
                                    FactoryCapacityRec.APR := Total4;
                                    FactoryCapacityRec.MAY := Total5;
                                    FactoryCapacityRec.JUN := Total6;
                                    FactoryCapacityRec.JUL := Total7;
                                    FactoryCapacityRec.AUG := Total8;
                                    FactoryCapacityRec.SEP := Total9;
                                    FactoryCapacityRec.OCT := Total10;
                                    FactoryCapacityRec.NOV := Total11;
                                    FactoryCapacityRec.DEC := Total12;
                                    FactoryCapacityRec."Created User" := UserId;
                                    FactoryCapacityRec."Created Date" := WorkDate();
                                    FactoryCapacityRec.Insert();

                                end
                                else begin  //Modify
                                    FactoryCapacityRec.JAN := Total1;
                                    FactoryCapacityRec.FEB := Total2;
                                    FactoryCapacityRec.MAR := Total3;
                                    FactoryCapacityRec.APR := Total4;
                                    FactoryCapacityRec.MAY := Total5;
                                    FactoryCapacityRec.JUN := Total6;
                                    FactoryCapacityRec.JUL := Total7;
                                    FactoryCapacityRec.AUG := Total8;
                                    FactoryCapacityRec.SEP := Total9;
                                    FactoryCapacityRec.OCT := Total10;
                                    FactoryCapacityRec.NOV := Total11;
                                    FactoryCapacityRec.DEC := Total12;
                                    FactoryCapacityRec.Modify();
                                end;

                            until LocationsRec.Next() = 0;
                        end;


                        //////////////////////////////////Merchand group wise allocaton
                        //Insert all group heads
                        MerchanGroupTableRec.Reset();
                        if MerchanGroupTableRec.FindSet() then begin
                            repeat
                                SAH_MerchGRPWiseAllocRec.Reset();
                                SAH_MerchGRPWiseAllocRec.SetRange(Year, rec.Year);
                                SAH_MerchGRPWiseAllocRec.SetRange("Group Id", MerchanGroupTableRec."Group Id");
                                if not SAH_MerchGRPWiseAllocRec.findset() then begin

                                    SAH_MerchGRPWiseAllocRec.Init();
                                    SAH_MerchGRPWiseAllocRec."Group Id" := MerchanGroupTableRec."Group Id";
                                    SAH_MerchGRPWiseAllocRec."Group Head" := MerchanGroupTableRec."Group Head";
                                    SAH_MerchGRPWiseAllocRec."Group Name" := MerchanGroupTableRec."Group Name";
                                    SAH_MerchGRPWiseAllocRec.Year := rec.Year;
                                    SAH_MerchGRPWiseAllocRec."Created User" := UserId;
                                    SAH_MerchGRPWiseAllocRec."Created Date" := WorkDate();
                                    SAH_MerchGRPWiseAllocRec.Insert();
                                end
                                else begin
                                    SAH_MerchGRPWiseAllocRec.JAN := 0;
                                    SAH_MerchGRPWiseAllocRec.FEB := 0;
                                    SAH_MerchGRPWiseAllocRec.MAR := 0;
                                    SAH_MerchGRPWiseAllocRec.APR := 0;
                                    SAH_MerchGRPWiseAllocRec.MAY := 0;
                                    SAH_MerchGRPWiseAllocRec.JUN := 0;
                                    SAH_MerchGRPWiseAllocRec.JUL := 0;
                                    SAH_MerchGRPWiseAllocRec.AUG := 0;
                                    SAH_MerchGRPWiseAllocRec.SEP := 0;
                                    SAH_MerchGRPWiseAllocRec.OCT := 0;
                                    SAH_MerchGRPWiseAllocRec.NOV := 0;
                                    SAH_MerchGRPWiseAllocRec.DEC := 0;
                                    SAH_MerchGRPWiseAllocRec.Modify();
                                end;

                            until MerchanGroupTableRec.Next() = 0;
                        end;

                        //Get all the factories
                        LocationsRec.Reset();
                        LocationsRec.SetFilter("Sewing Unit", '=%1', true);
                        if LocationsRec.FindSet() then begin
                            repeat
                                HoursPerDay := (LocationsRec."Finish Time" - LocationsRec."Start Time") / 3600000;
                                Total1 := 0;
                                Total2 := 0;
                                Total3 := 0;
                                Total4 := 0;
                                Total5 := 0;
                                Total6 := 0;
                                Total7 := 0;
                                Total8 := 0;
                                Total9 := 0;
                                Total10 := 0;
                                Total11 := 0;
                                Total12 := 0;

                                //Get all the lines for the above factory
                                WorkCenterRec.Reset();
                                WorkCenterRec.SetRange("Factory No.", LocationsRec.Code);
                                if WorkCenterRec.FindSet() then begin
                                    repeat
                                        Carders := WorkCenterRec.Carder;

                                        //No of days for a month
                                        for i := 1 to 12 do begin

                                            StartDate := DMY2DATE(1, i, rec.Year);

                                            case i of
                                                1:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                                2:
                                                    begin
                                                        if rec.Year mod 4 = 0 then
                                                            FinishDate := DMY2DATE(29, i, rec.Year)
                                                        else
                                                            FinishDate := DMY2DATE(28, i, rec.Year);
                                                    end;
                                                3:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                                4:
                                                    FinishDate := DMY2DATE(30, i, rec.Year);
                                                5:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                                6:
                                                    FinishDate := DMY2DATE(30, i, rec.Year);
                                                7:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                                8:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                                9:
                                                    FinishDate := DMY2DATE(30, i, rec.Year);
                                                10:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                                11:
                                                    FinishDate := DMY2DATE(30, i, rec.Year);
                                                12:
                                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                            end;


                                            //Get no of working days
                                            CalenderRec.Reset();
                                            CalenderRec.SETRANGE("No.", WorkCenterRec."No.");
                                            CalenderRec.SETRANGE(Date, StartDate, FinishDate);
                                            NoofDays := 0;

                                            if CalenderRec.FindSet() then begin
                                                repeat
                                                    if CalenderRec."Capacity (Total)" > 0 then
                                                        NoofDays += 1;
                                                until CalenderRec.Next() = 0;
                                            end;


                                            //Get efficiency
                                            PlanEfficiencyRec.Reset();
                                            PlanEfficiencyRec.SetRange(Year, rec.Year);
                                            PlanEfficiencyRec.FindSet();

                                            case i of
                                                1:
                                                    begin
                                                        NoofDays1 := NoofDays;
                                                        Total1 += (Carders * HoursPerDay * NoofDays1 * PlanEfficiencyRec.JAN) / 100;
                                                    end;
                                                2:
                                                    begin
                                                        NoofDays2 := NoofDays;
                                                        Total2 += (Carders * HoursPerDay * NoofDays2 * PlanEfficiencyRec.FEB) / 100;
                                                    end;
                                                3:
                                                    begin
                                                        NoofDays3 := NoofDays;
                                                        Total3 += (Carders * HoursPerDay * NoofDays3 * PlanEfficiencyRec.MAR) / 100;
                                                    end;
                                                4:
                                                    begin
                                                        NoofDays4 := NoofDays;
                                                        Total4 += (Carders * HoursPerDay * NoofDays4 * PlanEfficiencyRec.APR) / 100;
                                                    end;
                                                5:
                                                    begin
                                                        NoofDays5 := NoofDays;
                                                        Total5 += (Carders * HoursPerDay * NoofDays5 * PlanEfficiencyRec.MAY) / 100;
                                                    end;
                                                6:
                                                    begin
                                                        NoofDays6 := NoofDays;
                                                        Total6 += (Carders * HoursPerDay * NoofDays6 * PlanEfficiencyRec.JUN) / 100;
                                                    end;
                                                7:
                                                    begin
                                                        NoofDays7 := NoofDays;
                                                        Total7 += (Carders * HoursPerDay * NoofDays7 * PlanEfficiencyRec.JUL) / 100;
                                                    end;
                                                8:
                                                    begin
                                                        NoofDays8 := NoofDays;
                                                        Total8 += (Carders * HoursPerDay * NoofDays8 * PlanEfficiencyRec.AUG) / 100;
                                                    end;
                                                9:
                                                    begin
                                                        NoofDays9 := NoofDays;
                                                        Total9 += (Carders * HoursPerDay * NoofDays9 * PlanEfficiencyRec.SEP) / 100;
                                                    end;
                                                10:
                                                    begin
                                                        NoofDays10 := NoofDays;
                                                        Total10 += (Carders * HoursPerDay * NoofDays10 * PlanEfficiencyRec.OCT) / 100;
                                                    end;
                                                11:
                                                    begin
                                                        NoofDays11 := NoofDays;
                                                        Total11 += (Carders * HoursPerDay * NoofDays11 * PlanEfficiencyRec.NOV) / 100;
                                                    end;
                                                12:
                                                    begin
                                                        NoofDays12 := NoofDays;
                                                        Total12 += (Carders * HoursPerDay * NoofDays12 * PlanEfficiencyRec.DEC) / 100;
                                                    end;
                                            end;

                                            //Check for allocated Merchand for the month/year/line/factory
                                            CapacityAlloRec.Reset();
                                            CapacityAlloRec.SetRange(Year, rec.Year);
                                            CapacityAlloRec.SetRange("Factory Code", LocationsRec.Code);
                                            CapacityAlloRec.SetRange("Line No.", WorkCenterRec."No.");

                                            if CapacityAlloRec.FindSet() then begin
                                                case i of
                                                    1:
                                                        MerGR := CapacityAlloRec.JAN;
                                                    2:
                                                        MerGR := CapacityAlloRec.FEB;
                                                    3:
                                                        MerGR := CapacityAlloRec.MAR;
                                                    4:
                                                        MerGR := CapacityAlloRec.APR;
                                                    5:
                                                        MerGR := CapacityAlloRec.MAY;
                                                    6:
                                                        MerGR := CapacityAlloRec.JUN;
                                                    7:
                                                        MerGR := CapacityAlloRec.JUL;
                                                    8:
                                                        MerGR := CapacityAlloRec.AUG;
                                                    9:
                                                        MerGR := CapacityAlloRec.SEP;
                                                    10:
                                                        MerGR := CapacityAlloRec.OCT;
                                                    11:
                                                        MerGR := CapacityAlloRec.NOV;
                                                    12:
                                                        MerGR := CapacityAlloRec.DEC;
                                                end;

                                            end;


                                            //update merchand allocation
                                            SAH_MerchGRPWiseAllocRec.Reset();
                                            SAH_MerchGRPWiseAllocRec.SetRange(Year, rec.Year);
                                            SAH_MerchGRPWiseAllocRec.SetRange("Group Id", MerGR);
                                            if SAH_MerchGRPWiseAllocRec.FindSet() then begin

                                                case i of
                                                    1:
                                                        SAH_MerchGRPWiseAllocRec.JAN := SAH_MerchGRPWiseAllocRec.JAN + Total1;
                                                    2:
                                                        SAH_MerchGRPWiseAllocRec.FEB := SAH_MerchGRPWiseAllocRec.FEB + Total2;
                                                    3:
                                                        SAH_MerchGRPWiseAllocRec.MAR := SAH_MerchGRPWiseAllocRec.MAR + Total3;
                                                    4:
                                                        SAH_MerchGRPWiseAllocRec.APR := SAH_MerchGRPWiseAllocRec.APR + Total4;
                                                    5:
                                                        SAH_MerchGRPWiseAllocRec.MAY := SAH_MerchGRPWiseAllocRec.MAY + Total5;
                                                    6:
                                                        SAH_MerchGRPWiseAllocRec.JUN := SAH_MerchGRPWiseAllocRec.JUN + Total6;
                                                    7:
                                                        SAH_MerchGRPWiseAllocRec.JUL := SAH_MerchGRPWiseAllocRec.JUL + Total7;
                                                    8:
                                                        SAH_MerchGRPWiseAllocRec.AUG := SAH_MerchGRPWiseAllocRec.AUG + Total8;
                                                    9:
                                                        SAH_MerchGRPWiseAllocRec.SEP := SAH_MerchGRPWiseAllocRec.SEP + Total9;
                                                    10:
                                                        SAH_MerchGRPWiseAllocRec.OCT := SAH_MerchGRPWiseAllocRec.OCT + Total10;
                                                    11:
                                                        SAH_MerchGRPWiseAllocRec.NOV := SAH_MerchGRPWiseAllocRec.NOV + Total11;
                                                    12:
                                                        SAH_MerchGRPWiseAllocRec.DEC := SAH_MerchGRPWiseAllocRec.DEC + Total12;
                                                end;

                                                SAH_MerchGRPWiseAllocRec.Modify();
                                            end;

                                        end;

                                    until WorkCenterRec.Next() = 0;
                                end;

                            until LocationsRec.Next() = 0;
                        end;


                        /////////////////////////////////////////Merchand group wise balance/Avg SMV
                        /// Delete old records
                        SAH_MerchGRPWiseBalRec.Reset();
                        SAH_MerchGRPWiseBalRec.SetRange(Year, rec.Year);
                        if SAH_MerchGRPWiseBalRec.FindSet() then
                            SAH_MerchGRPWiseBalRec.DeleteAll();

                        SAH_MerchGRPWiseAvgSMVRec.Reset();
                        SAH_MerchGRPWiseAvgSMVRec.SetRange(Year, rec.Year);
                        if SAH_MerchGRPWiseAvgSMVRec.FindSet() then
                            SAH_MerchGRPWiseAvgSMVRec.DeleteAll();

                        ///Get allocations list
                        SAH_MerchGRPWiseAllocRec.Reset();
                        SAH_MerchGRPWiseAllocRec.SetRange(Year, rec.Year);
                        if SAH_MerchGRPWiseAllocRec.findset() then begin
                            repeat

                                //insert full allocated amount
                                SAH_MerchGRPWiseBalRec.Init();
                                SAH_MerchGRPWiseBalRec."Group Id" := SAH_MerchGRPWiseAllocRec."Group Id";
                                SAH_MerchGRPWiseBalRec."Group Head" := SAH_MerchGRPWiseAllocRec."Group Head";
                                SAH_MerchGRPWiseBalRec."Group Name" := SAH_MerchGRPWiseAllocRec."Group Name";
                                SAH_MerchGRPWiseBalRec.Year := rec.Year;
                                SAH_MerchGRPWiseBalRec.JAN := SAH_MerchGRPWiseAllocRec.JAN;
                                SAH_MerchGRPWiseBalRec.FEB := SAH_MerchGRPWiseAllocRec.FEB;
                                SAH_MerchGRPWiseBalRec.MAR := SAH_MerchGRPWiseAllocRec.MAR;
                                SAH_MerchGRPWiseBalRec.APR := SAH_MerchGRPWiseAllocRec.APR;
                                SAH_MerchGRPWiseBalRec.MAY := SAH_MerchGRPWiseAllocRec.MAY;
                                SAH_MerchGRPWiseBalRec.JUN := SAH_MerchGRPWiseAllocRec.JUN;
                                SAH_MerchGRPWiseBalRec.JUL := SAH_MerchGRPWiseAllocRec.JUL;
                                SAH_MerchGRPWiseBalRec.AUG := SAH_MerchGRPWiseAllocRec.AUG;
                                SAH_MerchGRPWiseBalRec.SEP := SAH_MerchGRPWiseAllocRec.SEP;
                                SAH_MerchGRPWiseBalRec.OCT := SAH_MerchGRPWiseAllocRec.OCT;
                                SAH_MerchGRPWiseBalRec.NOV := SAH_MerchGRPWiseAllocRec.NOV;
                                SAH_MerchGRPWiseBalRec.DEC := SAH_MerchGRPWiseAllocRec.DEC;
                                SAH_MerchGRPWiseBalRec."Created Date" := WorkDate();
                                SAH_MerchGRPWiseBalRec."Created User" := UserId;
                                SAH_MerchGRPWiseBalRec.Insert();

                                Total1 := 0;
                                Total2 := 0;
                                Total3 := 0;
                                Total4 := 0;
                                Total5 := 0;
                                Total6 := 0;
                                Total7 := 0;
                                Total8 := 0;
                                Total9 := 0;
                                Total10 := 0;
                                Total11 := 0;
                                Total12 := 0;

                                Total1_A := 0;
                                Total2_A := 0;
                                Total3_A := 0;
                                Total4_A := 0;
                                Total5_A := 0;
                                Total6_A := 0;
                                Total7_A := 0;
                                Total8_A := 0;
                                Total9_A := 0;
                                Total10_A := 0;
                                Total11_A := 0;
                                Total12_A := 0;

                                Total1_POQty := 0;
                                Total2_POQty := 0;
                                Total3_POQty := 0;
                                Total4_POQty := 0;
                                Total5_POQty := 0;
                                Total6_POQty := 0;
                                Total7_POQty := 0;
                                Total8_POQty := 0;
                                Total9_POQty := 0;
                                Total10_POQty := 0;
                                Total11_POQty := 0;
                                Total12_POQty := 0;

                                //Get Customer list for the group id
                                CustomerRec.Reset();
                                CustomerRec.SetRange("Group Id", SAH_MerchGRPWiseAllocRec."Group Id");
                                if CustomerRec.findset() then begin
                                    repeat

                                        //Get style list for the customer
                                        StyleMasterRec.Reset();
                                        StyleMasterRec.SetRange("Buyer No.", CustomerRec."No.");
                                        if StyleMasterRec.findset() then begin
                                            repeat

                                                //Get style po list for the customer
                                                StyleMasterPORec.Reset();
                                                StyleMasterPORec.SetRange("Style No.", StyleMasterRec."No.");
                                                if StyleMasterPORec.findset() then begin
                                                    repeat

                                                        if StyleMasterPORec."Ship Date" = 0D then
                                                            Error('Ship Date is blank in style : %1', StyleMasterRec."Style No.");

                                                        evaluate(Month, copystr(Format(StyleMasterPORec."Ship Date"), 4, 2));

                                                        case Month of
                                                            1:
                                                                begin
                                                                    Total1 += (StyleMasterPORec.Qty * StyleMasterRec.SMV) / 60;
                                                                    Total1_A += StyleMasterPORec.Qty * StyleMasterRec.SMV;
                                                                    Total1_POQty += StyleMasterPORec.Qty;
                                                                end;
                                                            2:
                                                                begin
                                                                    Total2 += (StyleMasterPORec.Qty * StyleMasterRec.SMV) / 60;
                                                                    Total2_A += StyleMasterPORec.Qty * StyleMasterRec.SMV;
                                                                    Total2_POQty += StyleMasterPORec.Qty;
                                                                end;
                                                            3:
                                                                begin
                                                                    Total3 += (StyleMasterPORec.Qty * StyleMasterRec.SMV) / 60;
                                                                    Total3_A += StyleMasterPORec.Qty * StyleMasterRec.SMV;
                                                                    Total3_POQty += StyleMasterPORec.Qty;
                                                                end;
                                                            4:
                                                                begin
                                                                    Total4 += (StyleMasterPORec.Qty * StyleMasterRec.SMV) / 60;
                                                                    Total4_A += StyleMasterPORec.Qty * StyleMasterRec.SMV;
                                                                    Total4_POQty += StyleMasterPORec.Qty;
                                                                end;
                                                            5:
                                                                begin
                                                                    Total5 += (StyleMasterPORec.Qty * StyleMasterRec.SMV) / 60;
                                                                    Total5_A += StyleMasterPORec.Qty * StyleMasterRec.SMV;
                                                                    Total5_POQty += StyleMasterPORec.Qty;
                                                                end;
                                                            6:
                                                                begin
                                                                    Total6 += (StyleMasterPORec.Qty * StyleMasterRec.SMV) / 60;
                                                                    Total6_A += StyleMasterPORec.Qty * StyleMasterRec.SMV;
                                                                    Total6_POQty += StyleMasterPORec.Qty;
                                                                end;
                                                            7:
                                                                begin
                                                                    Total7 += (StyleMasterPORec.Qty * StyleMasterRec.SMV) / 60;
                                                                    Total7_A += StyleMasterPORec.Qty * StyleMasterRec.SMV;
                                                                    Total7_POQty += StyleMasterPORec.Qty;
                                                                end;
                                                            8:
                                                                begin
                                                                    Total8 += (StyleMasterPORec.Qty * StyleMasterRec.SMV) / 60;
                                                                    Total8_A += StyleMasterPORec.Qty * StyleMasterRec.SMV;
                                                                    Total8_POQty += StyleMasterPORec.Qty;
                                                                end;
                                                            9:
                                                                begin
                                                                    Total9 += (StyleMasterPORec.Qty * StyleMasterRec.SMV) / 60;
                                                                    Total9_A += StyleMasterPORec.Qty * StyleMasterRec.SMV;
                                                                    Total9_POQty += StyleMasterPORec.Qty;
                                                                end;
                                                            10:
                                                                begin
                                                                    Total10 += (StyleMasterPORec.Qty * StyleMasterRec.SMV) / 60;
                                                                    Total10_A += StyleMasterPORec.Qty * StyleMasterRec.SMV;
                                                                    Total10_POQty += StyleMasterPORec.Qty;
                                                                end;
                                                            11:
                                                                begin
                                                                    Total11 += (StyleMasterPORec.Qty * StyleMasterRec.SMV) / 60;
                                                                    Total11_A += StyleMasterPORec.Qty * StyleMasterRec.SMV;
                                                                    Total11_POQty += StyleMasterPORec.Qty;
                                                                end;
                                                            12:
                                                                begin
                                                                    Total12 += (StyleMasterPORec.Qty * StyleMasterRec.SMV) / 60;
                                                                    Total12_A += StyleMasterPORec.Qty * StyleMasterRec.SMV;
                                                                    Total12_POQty += StyleMasterPORec.Qty;
                                                                end;
                                                        end;

                                                    until StyleMasterPORec.Next() = 0;
                                                end;

                                            until StyleMasterRec.Next() = 0;
                                        end;

                                    until CustomerRec.Next() = 0;

                                    //modift balance table
                                    SAH_MerchGRPWiseBalRec.Reset();
                                    SAH_MerchGRPWiseBalRec.SetRange(Year, rec.Year);
                                    SAH_MerchGRPWiseBalRec.SetRange("Group Id", SAH_MerchGRPWiseAllocRec."Group Id");
                                    SAH_MerchGRPWiseBalRec.FindSet();
                                    SAH_MerchGRPWiseBalRec.JAN := SAH_MerchGRPWiseBalRec.JAN - Total1;
                                    SAH_MerchGRPWiseBalRec.FEB := SAH_MerchGRPWiseBalRec.FEB - Total2;
                                    SAH_MerchGRPWiseBalRec.MAR := SAH_MerchGRPWiseBalRec.MAR - Total3;
                                    SAH_MerchGRPWiseBalRec.APR := SAH_MerchGRPWiseBalRec.APR - Total4;
                                    SAH_MerchGRPWiseBalRec.MAY := SAH_MerchGRPWiseBalRec.MAY - Total5;
                                    SAH_MerchGRPWiseBalRec.JUN := SAH_MerchGRPWiseBalRec.JUN - Total6;
                                    SAH_MerchGRPWiseBalRec.JUL := SAH_MerchGRPWiseBalRec.JUL - Total7;
                                    SAH_MerchGRPWiseBalRec.AUG := SAH_MerchGRPWiseBalRec.AUG - Total8;
                                    SAH_MerchGRPWiseBalRec.SEP := SAH_MerchGRPWiseBalRec.SEP - Total9;
                                    SAH_MerchGRPWiseBalRec.OCT := SAH_MerchGRPWiseBalRec.OCT - Total10;
                                    SAH_MerchGRPWiseBalRec.NOV := SAH_MerchGRPWiseBalRec.NOV - Total11;
                                    SAH_MerchGRPWiseBalRec.DEC := SAH_MerchGRPWiseBalRec.DEC - Total12;
                                    SAH_MerchGRPWiseBalRec.JAN_Utilized := Total1;
                                    SAH_MerchGRPWiseBalRec.FEB_Utilized := Total2;
                                    SAH_MerchGRPWiseBalRec.MAR_Utilized := Total3;
                                    SAH_MerchGRPWiseBalRec.APR_Utilized := Total4;
                                    SAH_MerchGRPWiseBalRec.MAY_Utilized := Total5;
                                    SAH_MerchGRPWiseBalRec.JUN_Utilized := Total6;
                                    SAH_MerchGRPWiseBalRec.JUL_Utilized := Total7;
                                    SAH_MerchGRPWiseBalRec.AUG_Utilized := Total8;
                                    SAH_MerchGRPWiseBalRec.SEP_Utilized := Total9;
                                    SAH_MerchGRPWiseBalRec.OCT_Utilized := Total10;
                                    SAH_MerchGRPWiseBalRec.NOV_Utilized := Total11;
                                    SAH_MerchGRPWiseBalRec.DEC_Utilized := Total12;
                                    SAH_MerchGRPWiseBalRec.Modify();

                                    //insert avg smv
                                    if Total1_POQty <> 0 then
                                        TotalAvgSMV1 := Total1_A / Total1_POQty
                                    else
                                        TotalAvgSMV1 := 0;

                                    if Total2_POQty <> 0 then
                                        TotalAvgSMV2 := Total2_A / Total2_POQty
                                    else
                                        TotalAvgSMV2 := 0;

                                    if Total3_POQty <> 0 then
                                        TotalAvgSMV3 := Total3_A / Total3_POQty
                                    else
                                        TotalAvgSMV3 := 0;

                                    if Total4_POQty <> 0 then
                                        TotalAvgSMV4 := Total4_A / Total4_POQty
                                    else
                                        TotalAvgSMV4 := 0;

                                    if Total5_POQty <> 0 then
                                        TotalAvgSMV5 := Total5_A / Total5_POQty
                                    else
                                        TotalAvgSMV5 := 0;

                                    if Total6_POQty <> 0 then
                                        TotalAvgSMV6 := Total6_A / Total6_POQty
                                    else
                                        TotalAvgSMV6 := 0;

                                    if Total7_POQty <> 0 then
                                        TotalAvgSMV7 := Total7_A / Total7_POQty
                                    else
                                        TotalAvgSMV7 := 0;

                                    if Total8_POQty <> 0 then
                                        TotalAvgSMV8 := Total8_A / Total8_POQty
                                    else
                                        TotalAvgSMV8 := 0;

                                    if Total9_POQty <> 0 then
                                        TotalAvgSMV9 := Total9_A / Total9_POQty
                                    else
                                        TotalAvgSMV9 := 0;

                                    if Total10_POQty <> 0 then
                                        TotalAvgSMV10 := Total10_A / Total10_POQty
                                    else
                                        TotalAvgSMV10 := 0;

                                    if Total11_POQty <> 0 then
                                        TotalAvgSMV11 := Total11_A / Total11_POQty
                                    else
                                        TotalAvgSMV11 := 0;

                                    if Total12_POQty <> 0 then
                                        TotalAvgSMV12 := Total12_A / Total12_POQty
                                    else
                                        TotalAvgSMV12 := 0;

                                    SAH_MerchGRPWiseAvgSMVRec.Init();
                                    SAH_MerchGRPWiseAvgSMVRec."Group Id" := SAH_MerchGRPWiseAllocRec."Group Id";
                                    SAH_MerchGRPWiseAvgSMVRec."Group Head" := SAH_MerchGRPWiseAllocRec."Group Head";
                                    SAH_MerchGRPWiseAvgSMVRec."Group Name" := SAH_MerchGRPWiseAllocRec."Group Name";
                                    SAH_MerchGRPWiseAvgSMVRec.Year := rec.Year;
                                    SAH_MerchGRPWiseAvgSMVRec.JAN := TotalAvgSMV1;
                                    SAH_MerchGRPWiseAvgSMVRec.FEB := TotalAvgSMV2;
                                    SAH_MerchGRPWiseAvgSMVRec.MAR := TotalAvgSMV3;
                                    SAH_MerchGRPWiseAvgSMVRec.APR := TotalAvgSMV4;
                                    SAH_MerchGRPWiseAvgSMVRec.MAY := TotalAvgSMV5;
                                    SAH_MerchGRPWiseAvgSMVRec.JUN := TotalAvgSMV6;
                                    SAH_MerchGRPWiseAvgSMVRec.JUL := TotalAvgSMV7;
                                    SAH_MerchGRPWiseAvgSMVRec.AUG := TotalAvgSMV8;
                                    SAH_MerchGRPWiseAvgSMVRec.SEP := TotalAvgSMV9;
                                    SAH_MerchGRPWiseAvgSMVRec.OCT := TotalAvgSMV10;
                                    SAH_MerchGRPWiseAvgSMVRec.NOV := TotalAvgSMV11;
                                    SAH_MerchGRPWiseAvgSMVRec.DEC := TotalAvgSMV12;
                                    SAH_MerchGRPWiseAvgSMVRec."Created Date" := WorkDate();
                                    SAH_MerchGRPWiseAvgSMVRec."Created User" := UserId;
                                    SAH_MerchGRPWiseAvgSMVRec.Insert();

                                end;
                            until SAH_MerchGRPWiseAllocRec.Next() = 0;
                        end;



                        Message('Completed');
                    end
                    else
                        Error('Year is blank.');
                end;
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        SAH_FactoryCapacity: Record SAH_FactoryCapacity;
        SAH_CapacityAllocation: Record SAH_CapacityAllocation;
        SAH_MerchGRPWiseAllocation: Record SAH_MerchGRPWiseAllocation;
        SAH_MerchGRPWiseAvgSMV: Record SAH_MerchGRPWiseAvgSMV;
        SAH_MerchGRPWiseBalance: Record SAH_MerchGRPWiseBalance;
        SAH_MerchGRPWiseSAHUsed: Record SAH_MerchGRPWiseSAHUsed;
        SAH_PlanEfficiency: Record SAH_PlanEfficiency;

    begin
        SAH_FactoryCapacity.Reset();
        SAH_FactoryCapacity.SetRange(Year, rec.Year);
        if SAH_FactoryCapacity.FindSet() then
            SAH_FactoryCapacity.DeleteAll();

        SAH_CapacityAllocation.Reset();
        SAH_CapacityAllocation.SetRange(Year, rec.Year);
        if SAH_CapacityAllocation.FindSet() then
            SAH_CapacityAllocation.DeleteAll();

        SAH_MerchGRPWiseAllocation.Reset();
        SAH_MerchGRPWiseAllocation.SetRange(Year, rec.Year);
        if SAH_MerchGRPWiseAllocation.FindSet() then
            SAH_MerchGRPWiseAllocation.DeleteAll();

        SAH_MerchGRPWiseAvgSMV.Reset();
        SAH_MerchGRPWiseAvgSMV.SetRange(Year, rec.Year);
        if SAH_MerchGRPWiseAvgSMV.FindSet() then
            SAH_MerchGRPWiseAvgSMV.DeleteAll();

        SAH_MerchGRPWiseBalance.Reset();
        SAH_MerchGRPWiseBalance.SetRange(Year, rec.Year);
        if SAH_MerchGRPWiseBalance.FindSet() then
            SAH_MerchGRPWiseBalance.DeleteAll();

        SAH_MerchGRPWiseSAHUsed.Reset();
        SAH_MerchGRPWiseSAHUsed.SetRange(Year, rec.Year);
        if SAH_MerchGRPWiseSAHUsed.FindSet() then
            SAH_MerchGRPWiseSAHUsed.DeleteAll();

        SAH_PlanEfficiency.Reset();
        SAH_PlanEfficiency.SetRange(Year, rec.Year);
        if SAH_PlanEfficiency.FindSet() then
            SAH_PlanEfficiency.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        YearRec: Record YearTable;
        Monthrec: Record MonthTable;
        Y: Integer;
        Name: text[20];
        i: Integer;
    begin
        evaluate(Y, copystr(Format(Today()), 7, 2));
        Y := 2000 + Y;
        YearRec.Reset();
        YearRec.SetRange(Year, Y);
        if not YearRec.FindSet() then begin
            YearRec.Init();
            YearRec.Year := Y;
            YearRec.Insert();
        end;


        Monthrec.Reset();
        if not Monthrec.FindSet() then begin
            for i := 1 to 12 do begin
                case i of
                    1:
                        Name := 'January';
                    2:
                        Name := 'February';
                    3:
                        Name := 'March';
                    4:
                        Name := 'April';
                    5:
                        Name := 'May';
                    6:
                        Name := 'June';
                    7:
                        Name := 'July';
                    8:
                        Name := 'August';
                    9:
                        Name := 'September';
                    10:
                        Name := 'October';
                    11:
                        Name := 'November';
                    12:
                        Name := 'December';
                end;

                Monthrec.Init();
                Monthrec."Month No" := i;
                Monthrec."Month Name" := Name;
                Monthrec.Insert();

            end;
        end;
    end;
}