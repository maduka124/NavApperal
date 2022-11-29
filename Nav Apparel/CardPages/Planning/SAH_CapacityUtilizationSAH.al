page 50855 CapacityUtilizationSAH
{
    PageType = Card;
    SourceTable = YearTable;
    Caption = 'Capacity Utilization By SAH';

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(Year; Year)
                {
                    ApplicationArea = all;
                    TableRelation = YearTable.Year;
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
                begin

                    if Year > 0 then begin

                        /////////Capacity Allocations
                        //Get max record
                        CapacityAlloRec.Reset();
                        if CapacityAlloRec.Findlast() then
                            SeqNo := CapacityAlloRec."No.";

                        //Check for existing records
                        CapacityAlloRec.Reset();
                        CapacityAlloRec.SetRange(Year, Year);
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
                                            CapacityAlloRec.Year := Year;
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


                        /////////Planning Efficiency                        
                        //Check for existing records
                        PlanEfficiencyRec.Reset();
                        PlanEfficiencyRec.SetRange(Year, Year);
                        if not PlanEfficiencyRec.FindSet() then begin
                            //Insert lines
                            PlanEfficiencyRec.Init();
                            PlanEfficiencyRec.Year := Year;
                            PlanEfficiencyRec."Created User" := UserId;
                            PlanEfficiencyRec.Insert();
                        end;


                        /////////Factory Capacity                      
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

                                            StartDate := DMY2DATE(1, i, Year);

                                            case i of
                                                1:
                                                    FinishDate := DMY2DATE(31, i, Year);
                                                2:
                                                    begin
                                                        if Year mod 4 = 0 then
                                                            FinishDate := DMY2DATE(29, i, Year)
                                                        else
                                                            FinishDate := DMY2DATE(28, i, Year);
                                                    end;
                                                3:
                                                    FinishDate := DMY2DATE(31, i, Year);
                                                4:
                                                    FinishDate := DMY2DATE(30, i, Year);
                                                5:
                                                    FinishDate := DMY2DATE(31, i, Year);
                                                6:
                                                    FinishDate := DMY2DATE(30, i, Year);
                                                7:
                                                    FinishDate := DMY2DATE(31, i, Year);
                                                8:
                                                    FinishDate := DMY2DATE(31, i, Year);
                                                9:
                                                    FinishDate := DMY2DATE(30, i, Year);
                                                10:
                                                    FinishDate := DMY2DATE(31, i, Year);
                                                11:
                                                    FinishDate := DMY2DATE(30, i, Year);
                                                12:
                                                    FinishDate := DMY2DATE(31, i, Year);
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
                                            PlanEfficiencyRec.SetRange(Year, Year);
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
                                FactoryCapacityRec.SetRange(Year, Year);
                                FactoryCapacityRec.SetRange("Factory Code", LocationsRec.Code);
                                if not FactoryCapacityRec.FindSet() then begin  //insert

                                    //Insert lines
                                    FactoryCapacityRec.Init();
                                    FactoryCapacityRec.Year := Year;
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


                        //Merchand group wise allocaton
                        //Insert all group heads
                        MerchanGroupTableRec.Reset();
                        if MerchanGroupTableRec.FindSet() then begin
                            repeat
                                SAH_MerchGRPWiseAllocRec.Init();
                                SAH_MerchGRPWiseAllocRec."Group Id" := MerchanGroupTableRec."Group Id";
                                SAH_MerchGRPWiseAllocRec."Group Head" := MerchanGroupTableRec."Group Head";
                                SAH_MerchGRPWiseAllocRec."Group Name" := MerchanGroupTableRec."Group Name";
                                SAH_MerchGRPWiseAllocRec.Year := Year;
                                SAH_MerchGRPWiseAllocRec."Created User" := UserId;
                                SAH_MerchGRPWiseAllocRec."Created Date" := WorkDate();
                                SAH_MerchGRPWiseAllocRec.Insert();
                            until MerchanGroupTableRec.Next() = 0;
                        end;



                    end
                    else
                        Error('Year is blank.');
                end;
            }
        }
    }


    trigger OnOpenPage()
    var
        YearRec: Record YearTable;
        Y: Integer;
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
    end;
}