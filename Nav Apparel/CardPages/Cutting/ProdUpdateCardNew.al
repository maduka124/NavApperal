page 50371 "Prod Update Card"
{
    PageType = Card;
    Caption = 'Production Update';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(ProdDate; ProdDate)
                {
                    ApplicationArea = All;
                    Caption = 'Production Date';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Update Production")
            {
                ApplicationArea = All;
                Image = UpdateShipment;

                trigger OnAction()
                var
                    ProdOutHeaderRec: Record ProductionOutHeader;
                    "Output Qty": BigInteger;
                begin
                    if ProdDate >= WorkDate() then
                        Error('Production date should be before todays date. Cannot proceed.');

                    Reschedule();
                end;
            }

            // action("reverse prod update")
            // {
            //     Caption = 'reverse prod updatea';
            //     Image = RemoveLine;
            //     ApplicationArea = All;

            //     trigger OnAction();
            //     var
            //         Prod: Record ProductionOutHeader;
            //         Da: Date;
            //     begin
            //         Da := DMY2DATE(30, 1, 2023);
            //         Prod.Reset();
            //         Prod.SetRange("Prod Date", da);
            //         Prod.FindSet();
            //         Prod.ModifyAll("Prod Updated", 0);
            //     end;
            // }
        }
    }

    trigger OnInit()
    var
    begin
        ProdDate := WorkDate() - 1;
    end;


    procedure Reschedule()
    var
        WorkCenCapacityEntryRec: Record "Calendar Entry";
        WorkCenterRec: Record "Work Center";
        LearningCurveRec: Record "Learning Curve";
        ProdPlansDetails: Record "NavApp Prod Plans Details";
        JobPlaLineRec: Record "NavApp Planning Lines";
        JobPlaLine1Rec: Record "NavApp Planning Lines";
        JobPlaLine2Rec: Record "NavApp Planning Lines";
        ProdOutHeaderRec: Record ProductionOutHeader;
        StyleMasterPORec: Record "Style Master PO";
        ResCapacityEntryRec: Record "Calendar Entry";
        SHCalHolidayRec: Record "Shop Calendar Holiday";
        SHCalWorkRec: Record "Shop Calendar Working Days";
        LocationRec: Record Location;
        ProductionOutLine: Record ProductionOutLine;
        NavAppCodeUnit3Rec: Codeunit NavAppCodeUnit3;

        Holiday: code[10];
        Flag: Integer;
        LineTotal_Out: Decimal;
        dtStart: Date;
        dtEnd: Date;
        TImeStart: Time;
        WorkCenterNo: Code[20];
        LineNo: BigInteger;
        Temp: Text;
        WorkCenterName: Text;
        Eff: Decimal;
        Carder: Integer;
        SMV: Decimal;
        Hours: Decimal;
        TargetPerDay: BigInteger;
        HoursPerDay: Decimal;
        TargetPerHour: Decimal;
        TempQty: Decimal;
        TempQty1: Decimal;
        TempDate: Date;
        TempHours: Decimal;
        i: Integer;
        Rate: Decimal;
        Qty: BigInteger;
        MaxLineNo: BigInteger;
        xQty: Decimal;
        OutputQty: BigInteger;
        status: Integer;
        dtNextMonth: date;
        dtLastDate: date;
        dtSt: Date;
        dtEd: Date;
        DayForWeek: Record Date;
        Day: Integer;
        Count: Integer;
        TempTIme: Time;
        TimeEnd1: Time;
        TimeEnd2: Time;
        dtEnd1: Date;
        RowCount: Integer;
        N: Integer;
        RowCount1: Integer;
        N1: Integer;
        StartTime2: time;
        ArrayOfAllocations: Array[100] of BigInteger;
        Prev_FinishedDateTime: DateTime;
        Curr_StartDateTime: DateTime;
        HoursGap: Decimal;
        LCurveFinishDate: Date;
        LCurveStartTime: Time;
        LCurveFinishTime: Time;
        LcurveTemp: Decimal;
        LcurveHoursPerday: Decimal;
        LCurveStartTimePerDay: Time;
        LCurveSpent: Decimal;
        X: Integer;
        XX: Integer;
        HoursPerDay1: Decimal;
        HoursPerDay2: Decimal;
        ddddddtttt: DateTime;
        FactoryFinishTime: Time;
    begin

        //Check for blank factory / line records
        ProdOutHeaderRec.Reset();
        ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
        ProdOutHeaderRec.SetFilter("Prod Date", '=%1', ProdDate);
        ProdOutHeaderRec.SetFilter("Factory Name", '=%1', '');
        if ProdOutHeaderRec.FindSet() then
            ProdOutHeaderRec.DeleteAll();


        //Check for blank factory / line records
        ProdOutHeaderRec.Reset();
        ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
        ProdOutHeaderRec.SetFilter("Prod Date", '=%1', ProdDate);
        if ProdOutHeaderRec.FindSet() then begin
            repeat
                // if ProdOutHeaderRec."Factory Name" = '' then
                //     Error('Prod. Out Entries exists with blank Factory. Entry No : %1', ProdOutHeaderRec."No.");

                if ProdOutHeaderRec."Resource Name" = '' then
                    Error('Prod. Out Entries exists with blank Line. Entry No : %1', ProdOutHeaderRec."No.");
            until ProdOutHeaderRec.Next() = 0;
        end;

        //Get all factories
        LocationRec.Reset();
        LocationRec.SetFilter("Sewing Unit", '=%1', true);
        // LocationRec.SetRange(Code, 'PAL');
        if LocationRec.FindSet() then begin

            repeat
                //Get all work center line details
                WorkCenterRec.Reset();
                WorkCenterRec.SetRange("Factory No.", LocationRec.Code);
                WorkCenterRec.SetFilter("Planning Line", '=%1', true);
                // WorkCenterRec.SetRange("No.", 'PAL-01');
                if WorkCenterRec.FindSet() then begin

                    repeat
                        //Get the last working date.
                        dtLastDate := ProdDate - 1;
                        HoursPerDay := 0;
                        TimeEnd1 := 0T;
                        TimeEnd2 := 0T;

                        repeat
                            ResCapacityEntryRec.Reset();
                            ResCapacityEntryRec.SETRANGE("No.", WorkCenterRec."No.");
                            ResCapacityEntryRec.SETRANGE(Date, dtLastDate);
                            if ResCapacityEntryRec.FindSet() then begin
                                repeat
                                    HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                until ResCapacityEntryRec.Next() = 0;
                            end;

                            if HoursPerDay = 0 then begin

                                //Validate the day (Holiday or Weekend)
                                SHCalHolidayRec.Reset();
                                SHCalHolidayRec.SETRANGE("Shop Calendar Code", WorkCenterRec."Shop Calendar Code");
                                SHCalHolidayRec.SETRANGE(Date, dtLastDate);

                                if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                    DayForWeek.Get(DayForWeek."Period Type"::Date, dtLastDate);

                                    case DayForWeek."Period No." of
                                        1:
                                            Day := 0;
                                        2:
                                            Day := 1;
                                        3:
                                            Day := 2;
                                        4:
                                            Day := 3;
                                        5:
                                            Day := 4;
                                        6:
                                            Day := 5;
                                        7:
                                            Day := 6;
                                    end;

                                    SHCalWorkRec.Reset();
                                    SHCalWorkRec.SETRANGE("Shop Calendar Code", WorkCenterRec."Shop Calendar Code");
                                    SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                    if SHCalWorkRec.FindSet() then   //If not weekend
                                        Error('Calender for date : %1  Work center : %2 has not calculated', dtLastDate, WorkCenterRec.Name);
                                end;
                            end;

                            if HoursPerDay = 0 then
                                dtLastDate := dtLastDate - 1;

                        until HoursPerDay > 0;

                        HoursPerDay := 0;
                        //Check previuos day production update done or not
                        ProdOutHeaderRec.Reset();
                        ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
                        ProdOutHeaderRec.SetRange("Factory Code", LocationRec.Code);
                        ProdOutHeaderRec.SetFilter("Prod Date", '=%1', dtLastDate);
                        ProdOutHeaderRec.SetRange("Resource No.", WorkCenterRec."No.");
                        if ProdOutHeaderRec.FindSet() then begin
                            repeat
                                if ProdOutHeaderRec."Prod Updated" = 0 then
                                    Error('Production not updated for : %1', dtLastDate);
                            until ProdOutHeaderRec.Next() = 0;
                        end;

                        //Check Production already updated not not for the selected date
                        ProdOutHeaderRec.Reset();
                        ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
                        ProdOutHeaderRec.SetRange("Factory Code", LocationRec.Code);
                        ProdOutHeaderRec.SetFilter("Prod Date", '=%1', ProdDate);
                        ProdOutHeaderRec.SetRange("Resource No.", WorkCenterRec."No.");
                        if ProdOutHeaderRec.FindSet() then begin
                            repeat
                                if ProdOutHeaderRec."Prod Updated" = 1 then
                                    Error('Production already updated for : %1', ProdDate);
                            until ProdOutHeaderRec.Next() = 0;
                        end;

                        //Validate Line out Qty Vs Color size qty
                        ProdOutHeaderRec.Reset();
                        ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
                        ProdOutHeaderRec.SetRange("Factory Code", LocationRec.Code);
                        ProdOutHeaderRec.SetFilter("Prod Date", '=%1', ProdDate);
                        ProdOutHeaderRec.SetRange("Resource No.", WorkCenterRec."No.");
                        if ProdOutHeaderRec.FindSet() then begin
                            repeat
                                LineTotal_Out := 0;
                                //Line Out Qty
                                ProductionOutLine.Reset();
                                ProductionOutLine.SetRange("No.", ProdOutHeaderRec."No.");
                                ProductionOutLine.SetRange(In_Out, 'OUT');

                                if ProductionOutLine.FindSet() then
                                    repeat
                                        if ProductionOutLine."Colour No" <> '*' then
                                            LineTotal_Out += ProductionOutLine.Total;
                                    until ProductionOutLine.Next() = 0;


                                if LineTotal_Out <> ProdOutHeaderRec."Output Qty" then begin
                                    Error('Output quantity should match color/size total quantity in Daily Sewing Out No : %1', ProdOutHeaderRec."No.");
                                    exit;
                                end;

                            until ProdOutHeaderRec.Next() = 0;
                        end;


                        //Initialize for the work center line
                        Carder := WorkCenterRec.Carder;
                        eff := WorkCenterRec.PlanEff;
                        WorkCenterName := WorkCenterRec.Name;
                        WorkCenterNo := WorkCenterRec."No.";
                        dtStart := ProdDate + 1;
                        TImeStart := LocationRec."Start Time";
                        HoursPerDay := 0;
                        TempQty := 0;
                        TempQty1 := 0;
                        xQty := 0;
                        TempHours := 0;
                        OutputQty := 0;
                        // TImeStart := 0T;
                        TimeEnd1 := 0T;
                        TimeEnd2 := 0T;
                        dtEnd1 := 0D;
                        RowCount := 0;
                        N := 0;

                        //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                        repeat

                            WorkCenCapacityEntryRec.Reset();
                            WorkCenCapacityEntryRec.SETRANGE("No.", WorkCenterNo);
                            WorkCenCapacityEntryRec.SETRANGE(Date, dtStart);

                            if WorkCenCapacityEntryRec.FindSet() then begin
                                repeat
                                    HoursPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                until WorkCenCapacityEntryRec.Next() = 0;
                            end
                            else begin
                                Count := 0;
                                dtNextMonth := CalcDate('<+1M>', dtStart);
                                dtSt := CalcDate('<-CM>', dtNextMonth);
                                dtEd := CalcDate('<+CM>', dtNextMonth);

                                WorkCenCapacityEntryRec.Reset();
                                WorkCenCapacityEntryRec.SETRANGE("No.", WorkCenterNo);
                                WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);

                                if WorkCenCapacityEntryRec.FindSet() then
                                    Count += WorkCenCapacityEntryRec.Count;

                                if Count < 14 then
                                    Error('Calender is not setup for the Line : %1', WorkCenterName);
                            end;


                            if HoursPerDay = 0 then
                                dtStart := dtStart + 1;

                        until HoursPerDay > 0;

                        //Get no of existing all planning lines for the work center line
                        JobPlaLineRec.Reset();
                        JobPlaLineRec.SetCurrentKey(StartDateTime);
                        JobPlaLineRec.Ascending(true);
                        JobPlaLineRec.SetRange("Resource No.", WorkCenterNo);
                        JobPlaLineRec.SetFilter("Start Date", '<=%1', ProdDate);

                        if JobPlaLineRec.FindFirst() then
                            RowCount := JobPlaLineRec.Count;

                        if RowCount > 0 then begin

                            for N := 1 To RowCount do begin

                                //Get existing all planning lines for the work center line
                                JobPlaLineRec.Reset();
                                JobPlaLineRec.SetCurrentKey(StartDateTime);
                                JobPlaLineRec.Ascending(true);
                                JobPlaLineRec.SetRange("Resource No.", WorkCenterNo);
                                JobPlaLineRec.SetFilter("Start Date", '<=%1', ProdDate);

                                if JobPlaLineRec.FindFirst() then begin

                                    TempQty := 0;

                                    if JobPlaLineRec.Carder <> 0 then
                                        Carder := JobPlaLineRec.Carder;

                                    if JobPlaLineRec.Eff <> 0 then
                                        Eff := JobPlaLineRec.Eff;

                                    SMV := JobPlaLineRec.SMV;
                                    LineNo := JobPlaLineRec."Line No.";
                                    TargetPerHour := round(((60 / SMV) * Carder * Eff) / 100, 1);
                                    TargetPerDay := round(TargetPerHour * HoursPerDay, 1);
                                    TempDate := dtStart;

                                    // TargetPerDay := round(((60 / SMV) * Carder * HoursPerDay * Eff) / 100, 1);
                                    // TargetPerHour := round(TargetPerDay / HoursPerDay, 1);

                                    // //Update Prod status of all lines                                                
                                    // ProdOutHeaderRec.Reset();
                                    // ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
                                    // ProdOutHeaderRec.SetFilter("Prod Date", '=%1', ProdDate);
                                    // ProdOutHeaderRec.SetRange("Resource No.", WorkCenterNo);
                                    // if ProdOutHeaderRec.FindSet() then
                                    //     ProdOutHeaderRec.ModifyAll("Prod Updated", 1);


                                    //Get sewing out qty for the prod date
                                    OutputQty := 0;
                                    ProdOutHeaderRec.Reset();
                                    ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
                                    ProdOutHeaderRec.SetFilter("Prod Date", '=%1', ProdDate);
                                    ProdOutHeaderRec.SetRange("Resource No.", WorkCenterNo);
                                    ProdOutHeaderRec.SetRange("Out Style No.", JobPlaLineRec."Style No.");
                                    ProdOutHeaderRec.SetRange("Out PO No", JobPlaLineRec."PO No.");
                                    ProdOutHeaderRec.SetRange("Out Lot No.", JobPlaLineRec."Lot No.");

                                    if ProdOutHeaderRec.FindSet() then
                                        repeat
                                            OutputQty += ProdOutHeaderRec."Output Qty";
                                        until ProdOutHeaderRec.Next() = 0;


                                    //Update production status for the selected date
                                    ProdPlansDetails.Reset();
                                    ProdPlansDetails.SetRange("Line No.", LineNo);
                                    ProdPlansDetails.SetRange("Resource No.", WorkCenterNo);
                                    ProdPlansDetails.SetRange(PlanDate, ProdDate);
                                    if ProdPlansDetails.FindSet() then begin
                                        ProdPlansDetails.ProdUpd := 1;
                                        ProdPlansDetails.ProdUpdQty := OutputQty;
                                        ProdPlansDetails.Modify();
                                    end;

                                    //Delete Old lines which are not updated as production completed
                                    ProdPlansDetails.Reset();
                                    ProdPlansDetails.SetRange("Line No.", LineNo);
                                    ProdPlansDetails.SetFilter(ProdUpd, '<>%1', 1);
                                    if ProdPlansDetails.FindSet() then
                                        ProdPlansDetails.DeleteAll();

                                    if dtEnd1 <> 0D then begin
                                        TempDate := dtEnd1;
                                        dtStart := dtEnd1;
                                    end;

                                    // if LineNo = 2666 then
                                    //     Message('AFL-04');

                                    //Check learning curve                        
                                    LCurveFinishDate := dtStart;
                                    LCurveFinishTime := TImeStart;
                                    LCurveStartTime := TImeStart;

                                    //get learning curve hours spent so far
                                    LCurveSpent := 0;
                                    ProdPlansDetails.Reset();
                                    ProdPlansDetails.SetRange("Line No.", LineNo);
                                    ProdPlansDetails.SetFilter(ProdUpd, '=%1', 1);
                                    ProdPlansDetails.SetFilter("Learning Curve No.", '<>%1', 0);
                                    if ProdPlansDetails.FindSet() then
                                        repeat
                                            LCurveSpent += ProdPlansDetails."LCurve Hours Per Day";
                                        until ProdPlansDetails.Next() = 0;

                                    if JobPlaLineRec."Learning Curve No." <> 0 then begin
                                        LearningCurveRec.Reset();
                                        LearningCurveRec.SetRange("No.", JobPlaLineRec."Learning Curve No.");
                                        if LearningCurveRec.FindSet() then begin

                                            if LearningCurveRec.Type = LearningCurveRec.Type::Hourly then begin
                                                LcurveTemp := LearningCurveRec.Day1 - LCurveSpent;

                                                if LcurveTemp > 0 then begin

                                                    repeat
                                                        FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(WorkCenterNo, LCurveFinishDate, LocationRec."Start Time");

                                                        if ((FactoryFinishTime - LCurveStartTime) / 3600000 <= LcurveTemp) then begin
                                                            LcurveTemp -= (FactoryFinishTime - LCurveStartTime) / 3600000;
                                                            LCurveStartTime := LocationRec."Start Time";
                                                            LCurveFinishDate += 1;

                                                            //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                                            HoursPerDay := 0;
                                                            repeat

                                                                ResCapacityEntryRec.Reset();
                                                                ResCapacityEntryRec.SETRANGE("No.", WorkCenterNo);
                                                                ResCapacityEntryRec.SETRANGE(Date, LCurveFinishDate);
                                                                if ResCapacityEntryRec.FindSet() then begin
                                                                    repeat
                                                                        HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                                                    until ResCapacityEntryRec.Next() = 0;
                                                                end;

                                                                if HoursPerDay = 0 then begin

                                                                    //Validate the day (Holiday or Weekend)
                                                                    SHCalHolidayRec.Reset();
                                                                    SHCalHolidayRec.SETRANGE("Shop Calendar Code", WorkCenterRec."Shop Calendar Code");
                                                                    SHCalHolidayRec.SETRANGE(Date, LCurveFinishDate);
                                                                    if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                                                        DayForWeek.Get(DayForWeek."Period Type"::Date, LCurveFinishDate);

                                                                        case DayForWeek."Period No." of
                                                                            1:
                                                                                Day := 0;
                                                                            2:
                                                                                Day := 1;
                                                                            3:
                                                                                Day := 2;
                                                                            4:
                                                                                Day := 3;
                                                                            5:
                                                                                Day := 4;
                                                                            6:
                                                                                Day := 5;
                                                                            7:
                                                                                Day := 6;
                                                                        end;

                                                                        SHCalWorkRec.Reset();
                                                                        SHCalWorkRec.SETRANGE("Shop Calendar Code", WorkCenterRec."Shop Calendar Code");
                                                                        SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                                                        if SHCalWorkRec.FindSet() then   //If not weekend
                                                                            Error('Calender for date : %1  Work center : %2 has not calculated', LCurveFinishDate, WorkCenterName);
                                                                    end;
                                                                end;

                                                                if HoursPerDay = 0 then
                                                                    LCurveFinishDate := LCurveFinishDate + 1;

                                                            until HoursPerDay > 0;
                                                        end
                                                        else begin
                                                            LCurveStartTime := LCurveStartTime + 60 * 60 * 1000 * LcurveTemp;
                                                            LcurveTemp -= LcurveTemp;
                                                        end;
                                                    until LcurveTemp <= 0;

                                                    LCurveFinishTime := LCurveStartTime;
                                                end;
                                            end;
                                        end;
                                    end;

                                    repeat
                                        //Get working hours for the day
                                        HoursPerDay := 0;
                                        Holiday := 'No';
                                        TempHours := 0;
                                        Rate := 0;

                                        WorkCenCapacityEntryRec.Reset();
                                        WorkCenCapacityEntryRec.SETRANGE("No.", WorkCenterNo);
                                        WorkCenCapacityEntryRec.SETRANGE(Date, TempDate);
                                        if WorkCenCapacityEntryRec.FindSet() then begin
                                            repeat
                                                HoursPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                            until WorkCenCapacityEntryRec.Next() = 0;
                                        end
                                        else begin
                                            Count := 0;
                                            dtNextMonth := CalcDate('<+1M>', TempDate);
                                            dtSt := CalcDate('<-CM>', dtNextMonth);
                                            dtEd := CalcDate('<+CM>', dtNextMonth);

                                            WorkCenCapacityEntryRec.Reset();
                                            WorkCenCapacityEntryRec.SETRANGE("No.", WorkCenterNo);
                                            WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);
                                            if WorkCenCapacityEntryRec.FindSet() then
                                                Count += WorkCenCapacityEntryRec.Count;

                                            if Count < 14 then
                                                Error('Calender is not setup for the Line : %1', WorkCenterName);
                                        end;

                                        //if production updated, learning curve shoube incremented
                                        if JobPlaLineRec.ProdUpdDays > 0 then
                                            i := JobPlaLineRec.ProdUpdDays;
                                        // else
                                        //     i := 0;

                                        if HoursPerDay = 0 then begin

                                            //Validate the day (Holiday or Weekend)
                                            SHCalHolidayRec.Reset();
                                            SHCalHolidayRec.SETRANGE("Shop Calendar Code", WorkCenterRec."Shop Calendar Code");
                                            SHCalHolidayRec.SETRANGE(Date, TempDate);
                                            if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                                DayForWeek.Get(DayForWeek."Period Type"::Date, TempDate);

                                                case DayForWeek."Period No." of
                                                    1:
                                                        Day := 0;
                                                    2:
                                                        Day := 1;
                                                    3:
                                                        Day := 2;
                                                    4:
                                                        Day := 3;
                                                    5:
                                                        Day := 4;
                                                    6:
                                                        Day := 5;
                                                    7:
                                                        Day := 6;
                                                end;

                                                SHCalWorkRec.Reset();
                                                SHCalWorkRec.SETRANGE("Shop Calendar Code", WorkCenterRec."Shop Calendar Code");
                                                SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                                if SHCalWorkRec.FindSet() then   //If not weekend
                                                    Error('Calender for date : %1  Work center : %2 has not calculated', TempDate, WorkCenterRec.Name)
                                                else
                                                    Holiday := 'Yes';
                                            end
                                            else
                                                Holiday := 'Yes';
                                        end;

                                        //No learning curve for holidays
                                        if HoursPerDay > 0 then
                                            i += 1;

                                        if (i = 1) and (HoursPerDay > 0) then begin
                                            //Calculate hours for the first day (substracti hours if delay start)
                                            HoursPerDay := HoursPerDay - (TImeStart - LocationRec."Start Time") / 3600000;
                                        end;

                                        if JobPlaLineRec."Learning Curve No." <> 0 then begin

                                            //Aplly learning curve
                                            LearningCurveRec.Reset();
                                            LearningCurveRec.SetRange("No.", JobPlaLineRec."Learning Curve No.");
                                            if LearningCurveRec.FindSet() then begin

                                                if LearningCurveRec.Type = LearningCurveRec.Type::"Efficiency Wise" then begin    //Efficiency wise
                                                    case i of
                                                        1:
                                                            Rate := LearningCurveRec.Day1;
                                                        2:
                                                            Rate := LearningCurveRec.Day2;
                                                        3:
                                                            Rate := LearningCurveRec.Day3;
                                                        4:
                                                            Rate := LearningCurveRec.Day4;
                                                        5:
                                                            Rate := LearningCurveRec.Day5;
                                                        6:
                                                            Rate := LearningCurveRec.Day6;
                                                        7:
                                                            Rate := LearningCurveRec.Day7;
                                                        else
                                                            Rate := 100;
                                                    end;

                                                    if Rate = 0 then
                                                        Rate := 100;

                                                    if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < (JobPlaLineRec.Qty - OutputQty)) then begin
                                                        TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                        xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                    end
                                                    else begin
                                                        TempQty1 := (JobPlaLineRec.Qty - OutputQty) - TempQty;
                                                        TempQty := TempQty + TempQty1;
                                                        TempHours := TempQty1 / TargetPerHour;
                                                        xQty := TempQty1;

                                                        // if (TempHours IN [0.0001 .. 0.99]) then
                                                        //     TempHours := 1;

                                                        // TempHours := round(TempHours, 1, '>');
                                                        TempHours := round(TempHours, 0.01);

                                                    end;
                                                end
                                                else begin  //Hourly

                                                    Rate := 100;
                                                    LcurveHoursPerday := 0;
                                                    LCurveStartTimePerDay := 0T;

                                                    if LCurveFinishDate > TempDate then begin
                                                        LcurveHoursPerday := HoursPerDay;   //Hourly target calculation purpose

                                                        if LcurveHoursPerday = 0 then
                                                            LCurveStartTimePerDay := 0T
                                                        else begin
                                                            if i = 1 then
                                                                LCurveStartTimePerDay := LCurveStartTime
                                                            else
                                                                LCurveStartTimePerDay := LocationRec."Start Time";
                                                        end;
                                                        HoursPerDay := 0;
                                                    end
                                                    else begin
                                                        if LCurveFinishDate = TempDate then begin
                                                            if i = 1 then begin
                                                                if ((LCurveFinishTime - TImeStart) / 3600000) < 0 then begin

                                                                    LcurveHoursPerday := (TImeStart - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                                    if LcurveHoursPerday = 0 then
                                                                        LCurveStartTimePerDay := 0T
                                                                    else
                                                                        LCurveStartTimePerDay := TImeStart;

                                                                    HoursPerDay := HoursPerDay - (TImeStart - LCurveFinishTime) / 3600000;
                                                                end
                                                                else begin

                                                                    LcurveHoursPerday := (LCurveFinishTime - TImeStart) / 3600000;   //Hourly target calculation purpose
                                                                    if LcurveHoursPerday = 0 then
                                                                        LCurveStartTimePerDay := 0T
                                                                    else
                                                                        LCurveStartTimePerDay := TImeStart;

                                                                    HoursPerDay := HoursPerDay - (LCurveFinishTime - TImeStart) / 3600000;
                                                                end;
                                                            end
                                                            else begin
                                                                if ((LCurveFinishTime - LocationRec."Start Time") / 3600000) < 0 then begin

                                                                    LcurveHoursPerday := (LocationRec."Start Time" - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                                    if LcurveHoursPerday = 0 then
                                                                        LCurveStartTimePerDay := 0T
                                                                    else
                                                                        LCurveStartTimePerDay := LocationRec."Start Time";

                                                                    HoursPerDay := HoursPerDay - (LocationRec."Start Time" - LCurveFinishTime) / 3600000;
                                                                end
                                                                else begin

                                                                    LcurveHoursPerday := (LCurveFinishTime - LocationRec."Start Time") / 3600000;   //Hourly target calculation purpose
                                                                    if LcurveHoursPerday = 0 then
                                                                        LCurveStartTimePerDay := 0T
                                                                    else
                                                                        LCurveStartTimePerDay := LocationRec."Start Time";

                                                                    HoursPerDay := HoursPerDay - (LCurveFinishTime - LocationRec."Start Time") / 3600000;
                                                                end;
                                                            end;
                                                        end;
                                                    end;

                                                    if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < (JobPlaLineRec.Qty - OutputQty)) then begin
                                                        TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                        xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                    end
                                                    else begin
                                                        TempQty1 := (JobPlaLineRec.Qty - OutputQty) - TempQty;
                                                        xQty := TempQty1;
                                                        TempQty := TempQty + TempQty1;
                                                        TempHours := TempQty1 / TargetPerHour;

                                                        // if (TempHours IN [0.0001 .. 0.99]) then
                                                        //     TempHours := 1;

                                                        // TempHours := round(TempHours, 1, '>');
                                                        TempHours := round(TempHours, 0.01);
                                                    end;
                                                end;
                                            end;
                                        end
                                        else begin
                                            if (TempQty + round((TargetPerHour * HoursPerDay), 1)) < (JobPlaLineRec.Qty - OutputQty) then begin
                                                TempQty += round((TargetPerHour * HoursPerDay), 1);
                                                xQty := round(TargetPerHour * HoursPerDay, 1);
                                            end
                                            else begin
                                                TempQty1 := (JobPlaLineRec.Qty - OutputQty) - TempQty;
                                                TempQty := TempQty + TempQty1;
                                                TempHours := TempQty1 / TargetPerHour;
                                                xQty := TempQty1;

                                                // if (TempHours IN [0.0001 .. 0.99]) then
                                                //     TempHours := 1;

                                                // TempHours := round(TempHours, 1, '>');
                                                TempHours := round(TempHours, 0.01);
                                            end;
                                        end;

                                        // if JobPlaLineRec."Learning Curve No." <> 0 then begin

                                        //     //Aplly learning curve
                                        //     LearningCurveRec.Reset();
                                        //     LearningCurveRec.SetRange("No.", JobPlaLineRec."Learning Curve No.");
                                        //     if LearningCurveRec.FindSet() then begin
                                        //         case i of
                                        //             1:
                                        //                 Rate := LearningCurveRec.Day1;
                                        //             2:
                                        //                 Rate := LearningCurveRec.Day2;
                                        //             3:
                                        //                 Rate := LearningCurveRec.Day3;
                                        //             4:
                                        //                 Rate := LearningCurveRec.Day4;
                                        //             5:
                                        //                 Rate := LearningCurveRec.Day5;
                                        //             6:
                                        //                 Rate := LearningCurveRec.Day6;
                                        //             7:
                                        //                 Rate := LearningCurveRec.Day7;
                                        //             else
                                        //                 Rate := 100;
                                        //         end;
                                        //     end;

                                        //     if Rate = 0 then
                                        //         Rate := 100;

                                        //     if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < (JobPlaLineRec.Qty - OutputQty)) then begin
                                        //         TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                        //         xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                        //     end
                                        //     else begin
                                        //         TempQty1 := (JobPlaLineRec.Qty - OutputQty) - TempQty;
                                        //         TempQty := TempQty + TempQty1;
                                        //         TempHours := TempQty1 / TargetPerHour;
                                        //         xQty := TempQty1;

                                        //         if (TempHours IN [0.0001 .. 0.99]) then
                                        //             TempHours := 1;

                                        //         // TempHours := round(TempHours, 1, '>');
                                        //         TempHours := round(TempHours, 0.01);
                                        //     end;
                                        // end
                                        // else begin

                                        //     if (TempQty + (TargetPerHour * HoursPerDay)) < (JobPlaLineRec.Qty - OutputQty) then begin
                                        //         TempQty += (TargetPerHour * HoursPerDay);
                                        //         xQty := TargetPerHour * HoursPerDay;
                                        //     end
                                        //     else begin
                                        //         TempQty1 := (JobPlaLineRec.Qty - OutputQty) - TempQty;
                                        //         TempQty := TempQty + TempQty1;
                                        //         TempHours := TempQty1 / TargetPerHour;
                                        //         xQty := TempQty1;

                                        //         if (TempHours IN [0.0001 .. 0.99]) then
                                        //             TempHours := 1;

                                        //         // TempHours := round(TempHours, 1, '>');
                                        //         TempHours := round(TempHours, 0.01);
                                        //     end;

                                        // end;

                                        //Get Max Lineno
                                        MaxLineNo := 0;
                                        ProdPlansDetails.Reset();
                                        if ProdPlansDetails.FindLast() then
                                            MaxLineNo := ProdPlansDetails."No.";

                                        MaxLineNo += 1;
                                        FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(WorkCenterNo, TempDate, LocationRec."Start Time");

                                        if (JobPlaLineRec.Qty - OutputQty) > 0 then begin
                                            //insert to ProdPlansDetails
                                            ProdPlansDetails.Init();
                                            ProdPlansDetails."No." := MaxLineNo;
                                            ProdPlansDetails.PlanDate := TempDate;
                                            ProdPlansDetails."Style No." := JobPlaLineRec."Style No.";
                                            ProdPlansDetails."Style Name" := JobPlaLineRec."Style Name";
                                            ProdPlansDetails."PO No." := JobPlaLineRec."PO No.";
                                            ProdPlansDetails."Lot No." := JobPlaLineRec."Lot No.";
                                            ProdPlansDetails."Line No." := LineNo;
                                            ProdPlansDetails."Resource No." := WorkCenterNo;
                                            ProdPlansDetails.Carder := Carder;
                                            ProdPlansDetails.Eff := Eff;
                                            ProdPlansDetails.SMV := JobPlaLineRec.SMV;

                                            if Holiday = 'NO' then begin
                                                if TimeEnd1 <> 0T then
                                                    ProdPlansDetails."Start Time" := TimeEnd1
                                                else
                                                    if i = 1 then
                                                        ProdPlansDetails."Start Time" := TImeStart
                                                    else
                                                        ProdPlansDetails."Start Time" := LocationRec."Start Time";

                                                if TempHours = 0 then
                                                    ProdPlansDetails."Finish Time" := FactoryFinishTime
                                                else begin
                                                    if i = 1 then
                                                        if (FactoryFinishTime < ProdPlansDetails."Start Time" + 60 * 60 * 1000 * TempHours) then
                                                            ProdPlansDetails."Finish Time" := FactoryFinishTime
                                                        else
                                                            ProdPlansDetails."Finish Time" := ProdPlansDetails."Start Time" + 60 * 60 * 1000 * TempHours
                                                    else begin
                                                        if TimeEnd1 = 0T then
                                                            ProdPlansDetails."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours
                                                        else
                                                            ProdPlansDetails."Finish Time" := ProdPlansDetails."Start Time" + 60 * 60 * 1000 * TempHours;
                                                    end;
                                                end;
                                            end;

                                            ProdPlansDetails.Qty := xQty;
                                            ProdPlansDetails.Target := TargetPerDay;

                                            if Holiday = 'NO' then begin
                                                if TempHours > 0 then
                                                    ProdPlansDetails.HoursPerDay := TempHours
                                                else
                                                    ProdPlansDetails.HoursPerDay := HoursPerDay;
                                            end
                                            else begin
                                                ProdPlansDetails.HoursPerDay := 0;
                                            end;

                                            if Holiday = 'YES' then begin
                                                ProdPlansDetails."LCurve Hours Per Day" := 0;
                                                ProdPlansDetails."LCurve Start Time" := 0T;
                                                ProdPlansDetails."Learning Curve No." := 0;
                                            end
                                            else begin
                                                ProdPlansDetails."LCurve Hours Per Day" := LcurveHoursPerday;
                                                ProdPlansDetails."LCurve Start Time" := LCurveStartTimePerDay;

                                                if ProdPlansDetails."LCurve Hours Per Day" = 0 then
                                                    ProdPlansDetails."Learning Curve No." := 0
                                                else
                                                    ProdPlansDetails."Learning Curve No." := JobPlaLineRec."Learning Curve No.";
                                            end;

                                            ProdPlansDetails.ProdUpd := 0;
                                            ProdPlansDetails.ProdUpdQty := 0;
                                            ProdPlansDetails."Created User" := UserId;
                                            ProdPlansDetails."Created Date" := WorkDate();
                                            ProdPlansDetails."Factory No." := JobPlaLineRec.Factory;
                                            ProdPlansDetails.Insert();
                                        end;

                                        TempDate := TempDate + 1;
                                        TimeEnd1 := 0T;

                                    until (TempQty >= (JobPlaLineRec.Qty - OutputQty));

                                    TempDate := TempDate - 1;

                                    if (TempHours = 0) and ((JobPlaLineRec.Qty - OutputQty) > 0) then
                                        TempDate := TempDate - 1;

                                    JobPlaLineRec."Start Date" := dtStart;
                                    JobPlaLineRec."End Date" := TempDate;

                                    if TimeEnd2 <> 0T then
                                        JobPlaLineRec."Start Time" := TimeEnd2
                                    else
                                        JobPlaLineRec."Start Time" := TImeStart;

                                    if TempHours = 0 then
                                        JobPlaLineRec."Finish Time" := FactoryFinishTime
                                    else begin
                                        if i = 1 then
                                            if (FactoryFinishTime < JobPlaLineRec."Start Time" + 60 * 60 * 1000 * TempHours) then
                                                JobPlaLineRec."Finish Time" := FactoryFinishTime
                                            else
                                                JobPlaLineRec."Finish Time" := JobPlaLineRec."Start Time" + 60 * 60 * 1000 * TempHours
                                        else begin
                                            if TimeEnd2 = 0T then
                                                JobPlaLineRec."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours
                                            else
                                                JobPlaLineRec."Finish Time" := JobPlaLineRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                        end;
                                    end;

                                    if TimeEnd2 <> 0T then
                                        JobPlaLineRec.StartDateTime := CREATEDATETIME(dtStart, TimeEnd2)
                                    else
                                        JobPlaLineRec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);

                                    //Get previuos finish time;
                                    if N = 1 then
                                        Prev_FinishedDateTime := JobPlaLineRec.FinishDateTime
                                    else
                                        Prev_FinishedDateTime := 0DT;

                                    JobPlaLineRec.FinishDateTime := CREATEDATETIME(TempDate, JobPlaLineRec."Finish Time");
                                    JobPlaLineRec.ProdUpdDays := JobPlaLineRec.ProdUpdDays + 1;
                                    JobPlaLineRec.Qty := JobPlaLineRec.Qty - OutputQty;
                                    JobPlaLineRec.Modify();

                                    TempTIme := JobPlaLineRec."Finish Time";
                                    TimeEnd1 := JobPlaLineRec."Finish Time";
                                    TimeEnd2 := JobPlaLineRec."Finish Time";
                                    dtEnd1 := TempDate;

                                    //Update StyleMsterPO table
                                    StyleMasterPORec.Reset();
                                    StyleMasterPORec.SetRange("Style No.", JobPlaLineRec."Style No.");
                                    StyleMasterPORec.SetRange("lot No.", JobPlaLineRec."lot No.");
                                    StyleMasterPORec.FindSet();

                                    // if (StyleMasterPORec.PlannedQty - OutputQty) < 0 then
                                    //     Error('Planned Qty is minus. Cannot proceed. PO No :  %1', StyleMasterPORec."PO No.");

                                    StyleMasterPORec.PlannedQty := StyleMasterPORec.PlannedQty - OutputQty;
                                    StyleMasterPORec.OutputQty := StyleMasterPORec.OutputQty + OutputQty;
                                    StyleMasterPORec.Modify();

                                    //delete allocation if remaining qty is 0 or less than 0
                                    JobPlaLine1Rec.Reset();
                                    JobPlaLine1Rec.SetRange("Line No.", LineNo);
                                    if JobPlaLine1Rec.FindSet() then begin
                                        if JobPlaLine1Rec.Qty <= 0 then
                                            JobPlaLine1Rec.DeleteAll();
                                    end;


                                    //////////////////////////////Check whether new allocation conflicts other allocation     
                                    TempHours := 0;

                                    JobPlaLine1Rec.Reset();
                                    JobPlaLine1Rec.SetRange("Resource No.", WorkCenterNo);
                                    JobPlaLine1Rec.SetRange("StartDateTime", CreateDateTime(dtStart, JobPlaLineRec."Start Time"), CreateDateTime(TempDate, TempTIme));
                                    JobPlaLine1Rec.SetCurrentKey(StartDateTime);
                                    JobPlaLine1Rec.Ascending(true);
                                    JobPlaLine1Rec.SetFilter("Line No.", '<>%1', LineNo);
                                    if JobPlaLine1Rec.FindSet() then begin         //conflicts yes, then get all allocations for the line

                                        JobPlaLine1Rec.Reset();
                                        JobPlaLine1Rec.SetRange("Resource No.", WorkCenterNo);
                                        JobPlaLine1Rec.SetFilter("StartDateTime", '>=%1', CreateDateTime(dtStart, JobPlaLineRec."Start Time"));
                                        JobPlaLine1Rec.SetCurrentKey(StartDateTime);
                                        JobPlaLine1Rec.Ascending(true);
                                        JobPlaLine1Rec.SetFilter("Line No.", '<>%1', LineNo);
                                        if JobPlaLine1Rec.FindSet() then begin

                                            HoursPerDay := 0;
                                            i := 0;
                                            N1 := 0;
                                            TempQty := 0;
                                            RowCount1 := JobPlaLine1Rec.Count;
                                            StartTime2 := JobPlaLineRec."Start Time";

                                            if RowCount1 > 0 then begin

                                                //Clear all Array data
                                                for N1 := 1 To 100 do begin
                                                    ArrayOfAllocations[N1] := 0;
                                                end;

                                                N1 := 0;
                                                //Assign all line no of the work center line
                                                repeat
                                                    N1 += 1;
                                                    ArrayOfAllocations[N1] := JobPlaLine1Rec."Line No.";
                                                until JobPlaLine1Rec.Next() = 0;

                                                N1 := 0;
                                                for N1 := 1 To RowCount1 do begin

                                                    HoursGap := 0;
                                                    TempHours := 0;
                                                    JobPlaLine1Rec.Reset();
                                                    JobPlaLine1Rec.SetRange("Resource No.", WorkCenterNo);
                                                    JobPlaLine1Rec.SetFilter("Line No.", '=%1', ArrayOfAllocations[N1]);

                                                    if JobPlaLine1Rec.FindSet() then begin
                                                        i := 0;
                                                        Qty := JobPlaLine1Rec.Qty;
                                                        LineNo := JobPlaLine1Rec."Line No.";
                                                        SMV := JobPlaLine1Rec.SMV;

                                                        if JobPlaLine1Rec.Carder <> 0 then
                                                            Carder := JobPlaLine1Rec.Carder;

                                                        if JobPlaLine1Rec.Eff <> 0 then
                                                            Eff := JobPlaLine1Rec.Eff;

                                                        dtStart := TempDate;
                                                        TImeStart := TempTIme;
                                                        Curr_StartDateTime := JobPlaLine1Rec.StartDateTime;
                                                        FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(WorkCenterNo, dtStart, LocationRec."Start Time");

                                                        //Calculate hourly gap between prevous and current allocation
                                                        if Prev_FinishedDateTime <> 0DT then begin
                                                            if DT2DATE(Prev_FinishedDateTime) = DT2DATE(Curr_StartDateTime) then
                                                                HoursGap := 0
                                                            else begin
                                                                XX := (DT2DATE(Curr_StartDateTime) - DT2DATE(Prev_FinishedDateTime) + 1);
                                                                HoursPerDay2 := 0;

                                                                for X := 1 To XX do begin
                                                                    HoursPerDay1 := 0;
                                                                    ResCapacityEntryRec.Reset();
                                                                    ResCapacityEntryRec.SETRANGE("No.", WorkCenterNo);
                                                                    ResCapacityEntryRec.SETRANGE(Date, DT2DATE(Prev_FinishedDateTime) + (X - 1));

                                                                    if ResCapacityEntryRec.FindSet() then begin
                                                                        repeat
                                                                            HoursPerDay1 += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                                                        until ResCapacityEntryRec.Next() = 0;
                                                                    end;

                                                                    if HoursPerDay1 > 0 then begin
                                                                        if X = 1 then  //First Date
                                                                            HoursGap := CREATEDATETIME(DT2DATE(Prev_FinishedDateTime), FactoryFinishTime) - Prev_FinishedDateTime
                                                                        else
                                                                            if X = XX then  //Last date
                                                                                HoursGap := HoursGap + (Curr_StartDateTime - CREATEDATETIME(DT2DATE(Curr_StartDateTime), LocationRec."start Time"))
                                                                            else
                                                                                HoursPerDay2 := HoursPerDay2 + HoursPerDay1;
                                                                    end;
                                                                end;

                                                                HoursGap := HoursGap / 3600000;

                                                                if (HoursGap IN [0.0001 .. 0.99]) then
                                                                    HoursGap := 1;

                                                                HoursGap := round(HoursGap, 1, '>');
                                                                HoursGap := HoursGap + HoursPerDay2;
                                                            end;
                                                        end;

                                                        if HoursGap < 30 then
                                                            HoursGap := 0;

                                                        //Based on Hourly Gap, calculate start Date/time of current allocation 
                                                        if HoursGap > 0 then begin
                                                            ddddddtttt := CREATEDATETIME(dtStart, TImeStart);
                                                            FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(WorkCenterNo, dtStart, LocationRec."Start Time");

                                                            if (CREATEDATETIME(dtStart, FactoryFinishTime) <= (ddddddtttt + (60 * 60 * 1000 * HoursGap))) then begin
                                                                HoursGap := HoursGap - (FactoryFinishTime - TImeStart) / 3600000;
                                                                TImeStart := LocationRec."Start Time";
                                                                dtStart := dtStart + 1;

                                                                if HoursGap > 0 then begin
                                                                    repeat
                                                                        //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                                                        repeat
                                                                            HoursPerDay := 0;
                                                                            WorkCenCapacityEntryRec.Reset();
                                                                            WorkCenCapacityEntryRec.SETRANGE("No.", WorkCenterNo);
                                                                            WorkCenCapacityEntryRec.SETRANGE(Date, dtStart);
                                                                            if WorkCenCapacityEntryRec.FindSet() then begin
                                                                                repeat
                                                                                    HoursPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                                                                until WorkCenCapacityEntryRec.Next() = 0;
                                                                            end
                                                                            else begin
                                                                                Count := 0;
                                                                                dtNextMonth := CalcDate('<+1M>', dtStart);
                                                                                dtSt := CalcDate('<-CM>', dtNextMonth);
                                                                                dtEd := CalcDate('<+CM>', dtNextMonth);

                                                                                WorkCenCapacityEntryRec.Reset();
                                                                                WorkCenCapacityEntryRec.SETRANGE("No.", WorkCenterNo);
                                                                                WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);
                                                                                if WorkCenCapacityEntryRec.FindSet() then
                                                                                    Count += WorkCenCapacityEntryRec.Count;

                                                                                if Count < 14 then
                                                                                    Error('Calender is not setup for the Line : %1', WorkCenterName);
                                                                            end;

                                                                            if HoursPerDay = 0 then
                                                                                dtStart := dtStart + 1;
                                                                        until HoursPerDay > 0;

                                                                        if (HoursPerDay > HoursGap) then begin
                                                                            TImeStart := TImeStart + (60 * 60 * 1000 * HoursGap);
                                                                            HoursGap := 0;
                                                                        end
                                                                        else begin
                                                                            HoursGap := HoursGap - HoursPerDay;
                                                                            dtStart := dtStart + 1;
                                                                        end;

                                                                    until HoursGap = 0;
                                                                end
                                                            end
                                                            else begin
                                                                TImeStart := TImeStart + (60 * 60 * 1000 * HoursGap);
                                                                HoursGap := 0;
                                                            end;

                                                            TempDate := dtStart;
                                                        end;

                                                        HoursPerDay := 0;
                                                        FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(WorkCenterNo, dtStart, LocationRec."Start Time");

                                                        //if start time greater than parameter Finish time, set start time next day morning
                                                        if ((TImeStart - FactoryFinishTime) >= 0) then begin
                                                            TImeStart := LocationRec."Start Time";
                                                            dtStart := dtStart + 1;
                                                            TempDate := dtStart;
                                                        end;

                                                        //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                                        repeat

                                                            WorkCenCapacityEntryRec.Reset();
                                                            WorkCenCapacityEntryRec.SETRANGE("No.", WorkCenterNo);
                                                            WorkCenCapacityEntryRec.SETRANGE(Date, dtStart);

                                                            if WorkCenCapacityEntryRec.FindSet() then begin
                                                                repeat
                                                                    HoursPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                                                until WorkCenCapacityEntryRec.Next() = 0;
                                                            end
                                                            else begin
                                                                Count := 0;
                                                                dtNextMonth := CalcDate('<+1M>', dtStart);
                                                                dtSt := CalcDate('<-CM>', dtNextMonth);
                                                                dtEd := CalcDate('<+CM>', dtNextMonth);

                                                                WorkCenCapacityEntryRec.Reset();
                                                                WorkCenCapacityEntryRec.SETRANGE("No.", WorkCenterNo);
                                                                WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);

                                                                if WorkCenCapacityEntryRec.FindSet() then
                                                                    Count += WorkCenCapacityEntryRec.Count;

                                                                if Count < 14 then
                                                                    Error('Calender is not setup for the Line : %1', WorkCenterName);
                                                            end;


                                                            if HoursPerDay = 0 then
                                                                dtStart := dtStart + 1;

                                                        until HoursPerDay > 0;

                                                        TargetPerDay := round(((60 / SMV) * Carder * HoursPerDay * Eff) / 100, 1);
                                                        TargetPerHour := round(TargetPerDay / HoursPerDay, 1);
                                                        TempQty := 0;

                                                        //Get sewing out qty for the prod date
                                                        OutputQty := 0;
                                                        ProdOutHeaderRec.Reset();
                                                        ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
                                                        ProdOutHeaderRec.SetFilter("Prod Date", '=%1', ProdDate);
                                                        ProdOutHeaderRec.SetRange("Resource No.", WorkCenterNo);
                                                        ProdOutHeaderRec.SetRange("Out Style No.", JobPlaLine1Rec."Style No.");
                                                        ProdOutHeaderRec.SetRange("Out PO No", JobPlaLine1Rec."PO No.");
                                                        ProdOutHeaderRec.SetRange("Out Lot No.", JobPlaLine1Rec."Lot No.");
                                                        if ProdOutHeaderRec.FindSet() then
                                                            repeat
                                                                OutputQty += ProdOutHeaderRec."Output Qty";
                                                            until ProdOutHeaderRec.Next() = 0;

                                                        //Update production status for the selected date
                                                        ProdPlansDetails.Reset();
                                                        ProdPlansDetails.SetRange("Line No.", LineNo);
                                                        ProdPlansDetails.SetRange("Resource No.", WorkCenterNo);
                                                        ProdPlansDetails.SetRange(PlanDate, ProdDate);
                                                        if ProdPlansDetails.FindSet() then begin
                                                            ProdPlansDetails.ProdUpd := 1;
                                                            ProdPlansDetails.ProdUpdQty := OutputQty;
                                                            ProdPlansDetails.Modify();
                                                        end;

                                                        //Delete Old lines which are not updated as production completed
                                                        ProdPlansDetails.Reset();
                                                        ProdPlansDetails.SetRange("Line No.", LineNo);
                                                        ProdPlansDetails.SetFilter(ProdUpd, '<>%1', 1);
                                                        if ProdPlansDetails.FindSet() then
                                                            ProdPlansDetails.DeleteAll();

                                                        //Check learning curve                        
                                                        LCurveFinishDate := dtStart;
                                                        LCurveFinishTime := TImeStart;
                                                        LCurveStartTime := TImeStart;

                                                        if JobPlaLine1Rec."Learning Curve No." <> 0 then begin
                                                            LearningCurveRec.Reset();
                                                            LearningCurveRec.SetRange("No.", JobPlaLine1Rec."Learning Curve No.");
                                                            if LearningCurveRec.FindSet() then begin

                                                                if LearningCurveRec.Type = LearningCurveRec.Type::Hourly then begin
                                                                    LcurveTemp := LearningCurveRec.Day1;

                                                                    repeat
                                                                        FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(WorkCenterNo, LCurveFinishDate, LocationRec."Start Time");

                                                                        if ((FactoryFinishTime - LCurveStartTime) / 3600000 <= LcurveTemp) then begin
                                                                            LcurveTemp -= (FactoryFinishTime - LCurveStartTime) / 3600000;
                                                                            LCurveStartTime := LocationRec."Start Time";
                                                                            LCurveFinishDate += 1;

                                                                            //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                                                            HoursPerDay := 0;
                                                                            repeat

                                                                                ResCapacityEntryRec.Reset();
                                                                                ResCapacityEntryRec.SETRANGE("No.", WorkCenterNo);
                                                                                ResCapacityEntryRec.SETRANGE(Date, LCurveFinishDate);
                                                                                if ResCapacityEntryRec.FindSet() then begin
                                                                                    repeat
                                                                                        HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                                                                    until ResCapacityEntryRec.Next() = 0;
                                                                                end;

                                                                                if HoursPerDay = 0 then begin

                                                                                    //Validate the day (Holiday or Weekend)
                                                                                    SHCalHolidayRec.Reset();
                                                                                    SHCalHolidayRec.SETRANGE("Shop Calendar Code", WorkCenterRec."Shop Calendar Code");
                                                                                    SHCalHolidayRec.SETRANGE(Date, LCurveFinishDate);
                                                                                    if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                                                                        DayForWeek.Get(DayForWeek."Period Type"::Date, LCurveFinishDate);

                                                                                        case DayForWeek."Period No." of
                                                                                            1:
                                                                                                Day := 0;
                                                                                            2:
                                                                                                Day := 1;
                                                                                            3:
                                                                                                Day := 2;
                                                                                            4:
                                                                                                Day := 3;
                                                                                            5:
                                                                                                Day := 4;
                                                                                            6:
                                                                                                Day := 5;
                                                                                            7:
                                                                                                Day := 6;
                                                                                        end;

                                                                                        SHCalWorkRec.Reset();
                                                                                        SHCalWorkRec.SETRANGE("Shop Calendar Code", WorkCenterRec."Shop Calendar Code");
                                                                                        SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                                                                        if SHCalWorkRec.FindSet() then   //If not weekend
                                                                                            Error('Calender for date : %1  Work center : %2 has not calculated', LCurveFinishDate, WorkCenterName);
                                                                                    end;
                                                                                end;

                                                                                if HoursPerDay = 0 then
                                                                                    LCurveFinishDate := LCurveFinishDate + 1;

                                                                            until HoursPerDay > 0;
                                                                        end
                                                                        else begin
                                                                            LCurveStartTime := LCurveStartTime + 60 * 60 * 1000 * LcurveTemp;
                                                                            LcurveTemp -= LcurveTemp;
                                                                        end;
                                                                    until LcurveTemp <= 0;

                                                                    LCurveFinishTime := LCurveStartTime;
                                                                end;
                                                            end;
                                                        end;

                                                        repeat
                                                            //Get working hours for the day
                                                            HoursPerDay := 0;
                                                            Rate := 0;
                                                            Holiday := 'No';
                                                            TempHours := 0;

                                                            WorkCenCapacityEntryRec.Reset();
                                                            WorkCenCapacityEntryRec.SETRANGE("No.", WorkCenterNo);
                                                            WorkCenCapacityEntryRec.SETRANGE(Date, TempDate);
                                                            if WorkCenCapacityEntryRec.FindSet() then begin
                                                                repeat
                                                                    HoursPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                                                until WorkCenCapacityEntryRec.Next() = 0;
                                                            end
                                                            else begin
                                                                Count := 0;
                                                                dtNextMonth := CalcDate('<+1M>', TempDate);
                                                                dtSt := CalcDate('<-CM>', dtNextMonth);
                                                                dtEd := CalcDate('<+CM>', dtNextMonth);

                                                                WorkCenCapacityEntryRec.Reset();
                                                                WorkCenCapacityEntryRec.SETRANGE("No.", WorkCenterNo);
                                                                WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);

                                                                if WorkCenCapacityEntryRec.FindSet() then
                                                                    Count += WorkCenCapacityEntryRec.Count;

                                                                if Count < 14 then
                                                                    Error('Calender is not setup for the Line : %1', WorkCenterName);
                                                            end;

                                                            if HoursPerDay = 0 then begin

                                                                //Validate the day (Holiday or Weekend)
                                                                SHCalHolidayRec.Reset();
                                                                SHCalHolidayRec.SETRANGE("Shop Calendar Code", WorkCenterRec."Shop Calendar Code");
                                                                SHCalHolidayRec.SETRANGE(Date, TempDate);

                                                                if not SHCalHolidayRec.FindSet() then begin  //If not holiday
                                                                    DayForWeek.Get(DayForWeek."Period Type"::Date, TempDate);

                                                                    case DayForWeek."Period No." of
                                                                        1:
                                                                            Day := 0;
                                                                        2:
                                                                            Day := 1;
                                                                        3:
                                                                            Day := 2;
                                                                        4:
                                                                            Day := 3;
                                                                        5:
                                                                            Day := 4;
                                                                        6:
                                                                            Day := 5;
                                                                        7:
                                                                            Day := 6;
                                                                    end;

                                                                    SHCalWorkRec.Reset();
                                                                    SHCalWorkRec.SETRANGE("Shop Calendar Code", WorkCenterRec."Shop Calendar Code");
                                                                    SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                                                    if SHCalWorkRec.FindSet() then   //If not weekend
                                                                        Error('Calender for date : %1  Work center : %2 has not calculated', TempDate, WorkCenterRec.Name)
                                                                    else
                                                                        Holiday := 'Yes';
                                                                end
                                                                else
                                                                    Holiday := 'Yes';
                                                            end;

                                                            //No learning curve for holidays
                                                            if HoursPerDay > 0 then
                                                                i += 1;

                                                            if (i = 1) and (HoursPerDay > 0) then begin
                                                                //Calculate hours for the first day (substracti hours if delay start)
                                                                HoursPerDay := HoursPerDay - (TImeStart - LocationRec."Start Time") / 3600000;
                                                            end;

                                                            if JobPlaLine1Rec."Learning Curve No." <> 0 then begin

                                                                //Aplly learning curve
                                                                LearningCurveRec.Reset();
                                                                LearningCurveRec.SetRange("No.", JobPlaLine1Rec."Learning Curve No.");
                                                                if LearningCurveRec.FindSet() then begin

                                                                    if LearningCurveRec.Type = LearningCurveRec.Type::"Efficiency Wise" then begin    //Efficiency wise
                                                                        case i of
                                                                            1:
                                                                                Rate := LearningCurveRec.Day1;
                                                                            2:
                                                                                Rate := LearningCurveRec.Day2;
                                                                            3:
                                                                                Rate := LearningCurveRec.Day3;
                                                                            4:
                                                                                Rate := LearningCurveRec.Day4;
                                                                            5:
                                                                                Rate := LearningCurveRec.Day5;
                                                                            6:
                                                                                Rate := LearningCurveRec.Day6;
                                                                            7:
                                                                                Rate := LearningCurveRec.Day7;
                                                                            else
                                                                                Rate := 100;
                                                                        end;

                                                                        if Rate = 0 then
                                                                            Rate := 100;

                                                                        if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < (Qty - OutputQty)) then begin
                                                                            TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                                            xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                                        end
                                                                        else begin
                                                                            TempQty1 := (Qty - OutputQty) - TempQty;
                                                                            TempQty := TempQty + TempQty1;
                                                                            TempHours := TempQty1 / TargetPerHour;
                                                                            xQty := TempQty1;

                                                                            // if (TempHours IN [0.0001 .. 0.99]) then
                                                                            //     TempHours := 1;

                                                                            // TempHours := round(TempHours, 1, '>');
                                                                            TempHours := round(TempHours, 0.01);

                                                                        end;
                                                                    end
                                                                    else begin  //Hourly

                                                                        Rate := 100;
                                                                        LcurveHoursPerday := 0;
                                                                        LCurveStartTimePerDay := 0T;

                                                                        if LCurveFinishDate > TempDate then begin
                                                                            LcurveHoursPerday := HoursPerDay;   //Hourly target calculation purpose

                                                                            if LcurveHoursPerday = 0 then
                                                                                LCurveStartTimePerDay := 0T
                                                                            else begin
                                                                                if i = 1 then
                                                                                    LCurveStartTimePerDay := LCurveStartTime
                                                                                else
                                                                                    LCurveStartTimePerDay := LocationRec."Start Time";
                                                                            end;
                                                                            HoursPerDay := 0;
                                                                        end
                                                                        else begin
                                                                            if LCurveFinishDate = TempDate then begin
                                                                                if i = 1 then begin
                                                                                    if ((LCurveFinishTime - TImeStart) / 3600000) < 0 then begin

                                                                                        LcurveHoursPerday := (TImeStart - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                                                        if LcurveHoursPerday = 0 then
                                                                                            LCurveStartTimePerDay := 0T
                                                                                        else
                                                                                            LCurveStartTimePerDay := TImeStart;

                                                                                        HoursPerDay := HoursPerDay - (TImeStart - LCurveFinishTime) / 3600000;
                                                                                    end
                                                                                    else begin

                                                                                        LcurveHoursPerday := (LCurveFinishTime - TImeStart) / 3600000;   //Hourly target calculation purpose
                                                                                        if LcurveHoursPerday = 0 then
                                                                                            LCurveStartTimePerDay := 0T
                                                                                        else
                                                                                            LCurveStartTimePerDay := TImeStart;

                                                                                        HoursPerDay := HoursPerDay - (LCurveFinishTime - TImeStart) / 3600000;
                                                                                    end;
                                                                                end
                                                                                else begin
                                                                                    if ((LCurveFinishTime - LocationRec."Start Time") / 3600000) < 0 then begin

                                                                                        LcurveHoursPerday := (LocationRec."Start Time" - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                                                        if LcurveHoursPerday = 0 then
                                                                                            LCurveStartTimePerDay := 0T
                                                                                        else
                                                                                            LCurveStartTimePerDay := LocationRec."Start Time";

                                                                                        HoursPerDay := HoursPerDay - (LocationRec."Start Time" - LCurveFinishTime) / 3600000;
                                                                                    end
                                                                                    else begin

                                                                                        LcurveHoursPerday := (LCurveFinishTime - LocationRec."Start Time") / 3600000;   //Hourly target calculation purpose
                                                                                        if LcurveHoursPerday = 0 then
                                                                                            LCurveStartTimePerDay := 0T
                                                                                        else
                                                                                            LCurveStartTimePerDay := LocationRec."Start Time";

                                                                                        HoursPerDay := HoursPerDay - (LCurveFinishTime - LocationRec."Start Time") / 3600000;
                                                                                    end;
                                                                                end;
                                                                            end;
                                                                        end;

                                                                        if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < (Qty - OutputQty)) then begin
                                                                            TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                                            xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                                        end
                                                                        else begin
                                                                            TempQty1 := (Qty - OutputQty) - TempQty;
                                                                            xQty := TempQty1;
                                                                            TempQty := TempQty + TempQty1;
                                                                            TempHours := TempQty1 / TargetPerHour;

                                                                            // if (TempHours IN [0.0001 .. 0.99]) then
                                                                            //     TempHours := 1;

                                                                            // TempHours := round(TempHours, 1, '>');
                                                                            TempHours := round(TempHours, 0.01);
                                                                        end;
                                                                    end;
                                                                end;
                                                            end
                                                            else begin
                                                                if (TempQty + round((TargetPerHour * HoursPerDay), 1)) < (Qty - OutputQty) then begin
                                                                    TempQty += round((TargetPerHour * HoursPerDay), 1);
                                                                    xQty := round(TargetPerHour * HoursPerDay, 1);
                                                                end
                                                                else begin
                                                                    TempQty1 := (Qty - OutputQty) - TempQty;
                                                                    TempQty := TempQty + TempQty1;
                                                                    TempHours := TempQty1 / TargetPerHour;
                                                                    xQty := TempQty1;

                                                                    // if (TempHours IN [0.0001 .. 0.99]) then
                                                                    //     TempHours := 1;

                                                                    // TempHours := round(TempHours, 1, '>');
                                                                    TempHours := round(TempHours, 0.01);
                                                                end;
                                                            end;

                                                            // if JobPlaLine1Rec."Learning Curve No." <> 0 then begin

                                                            //     //Aplly learning curve
                                                            //     LearningCurveRec.Reset();
                                                            //     LearningCurveRec.SetRange("No.", JobPlaLine1Rec."Learning Curve No.");
                                                            //     if LearningCurveRec.FindSet() then begin
                                                            //         case i of
                                                            //             1:
                                                            //                 Rate := LearningCurveRec.Day1;
                                                            //             2:
                                                            //                 Rate := LearningCurveRec.Day2;
                                                            //             3:
                                                            //                 Rate := LearningCurveRec.Day3;
                                                            //             4:
                                                            //                 Rate := LearningCurveRec.Day4;
                                                            //             5:
                                                            //                 Rate := LearningCurveRec.Day5;
                                                            //             6:
                                                            //                 Rate := LearningCurveRec.Day6;
                                                            //             7:
                                                            //                 Rate := LearningCurveRec.Day7;
                                                            //             else
                                                            //                 Rate := 100;
                                                            //         end;
                                                            //     end;

                                                            //     if Rate = 0 then
                                                            //         Rate := 100;

                                                            //     if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < (Qty - OutputQty)) then begin
                                                            //         TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                            //         xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                                            //     end
                                                            //     else begin
                                                            //         TempQty1 := (Qty - OutputQty) - TempQty;
                                                            //         TempQty := TempQty + TempQty1;
                                                            //         TempHours := TempQty1 / TargetPerHour;
                                                            //         xQty := TempQty1;

                                                            //         if (TempHours IN [0.0001 .. 0.99]) then
                                                            //             TempHours := 1;

                                                            //         // TempHours := round(TempHours, 1, '>');
                                                            //         TempHours := round(TempHours, 0.01);

                                                            //     end;
                                                            // end
                                                            // else begin

                                                            //     if (TempQty + (TargetPerHour * HoursPerDay)) < (Qty - OutputQty) then begin
                                                            //         TempQty += (TargetPerHour * HoursPerDay);
                                                            //         xQty := TargetPerHour * HoursPerDay;
                                                            //     end
                                                            //     else begin
                                                            //         TempQty1 := (Qty - OutputQty) - TempQty;
                                                            //         TempQty := TempQty + TempQty1;
                                                            //         TempHours := TempQty1 / TargetPerHour;
                                                            //         xQty := TempQty1;

                                                            //         if (TempHours IN [0.0001 .. 0.99]) then
                                                            //             TempHours := 1;

                                                            //         // TempHours := round(TempHours, 1, '>');
                                                            //         TempHours := round(TempHours, 0.01);
                                                            //     end;

                                                            // end;

                                                            //Get Max Lineno
                                                            MaxLineNo := 0;
                                                            ProdPlansDetails.Reset();
                                                            if ProdPlansDetails.FindLast() then
                                                                MaxLineNo := ProdPlansDetails."No.";

                                                            MaxLineNo += 1;
                                                            FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(WorkCenterNo, TempDate, LocationRec."Start Time");

                                                            //insert to ProdPlansDetails
                                                            ProdPlansDetails.Init();
                                                            ProdPlansDetails."No." := MaxLineNo;
                                                            ProdPlansDetails.PlanDate := TempDate;
                                                            ProdPlansDetails."Style No." := JobPlaLine1Rec."Style No.";
                                                            ProdPlansDetails."Style Name" := JobPlaLine1Rec."Style Name";
                                                            ProdPlansDetails."PO No." := JobPlaLine1Rec."PO No.";
                                                            ProdPlansDetails."Lot No." := JobPlaLine1Rec."Lot No.";
                                                            ProdPlansDetails."Line No." := LineNo;
                                                            ProdPlansDetails."Resource No." := WorkCenterNo;
                                                            ProdPlansDetails.Carder := Carder;
                                                            ProdPlansDetails.Eff := Eff;
                                                            ProdPlansDetails.SMV := JobPlaLine1Rec.SMV;

                                                            if Holiday = 'NO' then begin
                                                                if i = 1 then
                                                                    ProdPlansDetails."Start Time" := TImeStart
                                                                else
                                                                    ProdPlansDetails."Start Time" := LocationRec."Start Time";

                                                                if TempHours = 0 then
                                                                    ProdPlansDetails."Finish Time" := FactoryFinishTime
                                                                else begin
                                                                    if i = 1 then
                                                                        if (FactoryFinishTime < TImeStart + 60 * 60 * 1000 * TempHours) then
                                                                            ProdPlansDetails."Finish Time" := FactoryFinishTime
                                                                        else
                                                                            ProdPlansDetails."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                                                                    else
                                                                        ProdPlansDetails."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                                                end;
                                                            end;

                                                            ProdPlansDetails.Qty := xQty;
                                                            ProdPlansDetails.Target := TargetPerDay;

                                                            if Holiday = 'NO' then begin
                                                                if TempHours > 0 then
                                                                    ProdPlansDetails.HoursPerDay := TempHours
                                                                else
                                                                    ProdPlansDetails.HoursPerDay := HoursPerDay;
                                                            end
                                                            else begin
                                                                ProdPlansDetails.HoursPerDay := 0;
                                                            end;

                                                            if Holiday = 'YES' then begin
                                                                ProdPlansDetails."LCurve Hours Per Day" := 0;
                                                                ProdPlansDetails."LCurve Start Time" := 0T;
                                                                ProdPlansDetails."Learning Curve No." := 0;
                                                            end
                                                            else begin
                                                                ProdPlansDetails."LCurve Hours Per Day" := LcurveHoursPerday;
                                                                ProdPlansDetails."LCurve Start Time" := LCurveStartTimePerDay;

                                                                if ProdPlansDetails."LCurve Hours Per Day" = 0 then
                                                                    ProdPlansDetails."Learning Curve No." := 0
                                                                else
                                                                    ProdPlansDetails."Learning Curve No." := JobPlaLine1Rec."Learning Curve No.";
                                                            end;

                                                            ProdPlansDetails.ProdUpd := 0;
                                                            ProdPlansDetails.ProdUpdQty := 0;
                                                            ProdPlansDetails."Created User" := UserId;
                                                            ProdPlansDetails."Created Date" := WorkDate();
                                                            ProdPlansDetails."Factory No." := JobPlaLine1Rec.Factory;
                                                            ProdPlansDetails.Insert();

                                                            TempDate := TempDate + 1;

                                                        until (TempQty >= (Qty - OutputQty));

                                                        TempDate := TempDate - 1;

                                                        if TempHours = 0 then
                                                            TempDate := TempDate - 1;

                                                        //modift the line
                                                        JobPlaLine2Rec.Reset();
                                                        JobPlaLine2Rec.SetRange("Line No.", LineNo);
                                                        JobPlaLine2Rec.FindSet();

                                                        JobPlaLine2Rec."Start Date" := dtStart;
                                                        JobPlaLine2Rec."End Date" := TempDate;
                                                        JobPlaLine2Rec."Start Time" := TImeStart;

                                                        if TempHours = 0 then
                                                            JobPlaLine2Rec."Finish Time" := FactoryFinishTime
                                                        else begin
                                                            if i = 1 then
                                                                if (FactoryFinishTime < TImeStart + 60 * 60 * 1000 * TempHours) then
                                                                    JobPlaLine2Rec."Finish Time" := FactoryFinishTime
                                                                else
                                                                    JobPlaLine2Rec."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                                                            else
                                                                JobPlaLine2Rec."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                                        end;

                                                        JobPlaLine2Rec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);
                                                        JobPlaLine2Rec.FinishDateTime := CREATEDATETIME(TempDate, JobPlaLine2Rec."Finish Time");
                                                        JobPlaLine2Rec.Qty := Qty - OutputQty;

                                                        Prev_FinishedDateTime := JobPlaLine1Rec.FinishDateTime;
                                                        JobPlaLine2Rec.Modify();

                                                        TempTIme := JobPlaLine2Rec."Finish Time";

                                                        //delete allocation if remaining qty is 0 or less than 0
                                                        JobPlaLine2Rec.Reset();
                                                        JobPlaLine2Rec.SetRange("Line No.", LineNo);

                                                        if JobPlaLine2Rec.FindSet() then begin
                                                            if JobPlaLine2Rec.Qty <= 0 then
                                                                JobPlaLine2Rec.DeleteAll();
                                                        end;
                                                    end;

                                                    StartTime2 := JobPlaLine2Rec."Start Time";
                                                    LineNo := JobPlaLine1Rec."Line No.";
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                                status := 1;
                            end;
                        end;
                    until WorkCenterRec.Next() = 0;
                end;
            until LocationRec.Next() = 0;

            //Update Prod status of all lines                                                
            ProdOutHeaderRec.Reset();
            ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
            ProdOutHeaderRec.SetFilter("Prod Date", '=%1', ProdDate);

            if ProdOutHeaderRec.FindSet() then
                ProdOutHeaderRec.ModifyAll("Prod Updated", 1);

            if status = 1 then
                Message('Production updated')
            else
                Message('Production not updated')
        end
        else
            Error('Cannot find factory details.');

    end;


    procedure PassParameters(FactoryNoPara: Code[20]);
    var
    begin
        FactoryNo := FactoryNoPara;
    end;


    var
        ProdDate: Date;
        FactoryNo: code[20];
}