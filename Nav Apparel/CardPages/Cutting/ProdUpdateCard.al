page 51298 "Prod Update Card"
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
        ProdOutHeaderRec: Record ProductionOutHeader;
        StyleMasterPORec: Record "Style Master PO";
        ResCapacityEntryRec: Record "Calendar Entry";
        SHCalHolidayRec: Record "Shop Calendar Holiday";
        SHCalWorkRec: Record "Shop Calendar Working Days";
        LocationRec: Record Location;
        ProductionOutLine: Record ProductionOutLine;

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
        Found: Boolean;
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
        dtEnd1: Date;
        RowCount: Integer;
        N: Integer;
    begin

        //Check for blank factory / line records
        ProdOutHeaderRec.Reset();
        ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
        ProdOutHeaderRec.SetFilter("Prod Date", '=%1', ProdDate);
        if ProdOutHeaderRec.FindSet() then begin
            repeat
                if ProdOutHeaderRec."Factory Name" = '' then
                    Error('Entries exists with blank Factory. Entry No : %1', ProdOutHeaderRec."No.");

                if ProdOutHeaderRec."Resource Name" = '' then
                    Error('Entries exists with blank Line. Entry No : %1', ProdOutHeaderRec."No.");
            until ProdOutHeaderRec.Next() = 0;
        end;

        //Get all factories
        LocationRec.Reset();
        LocationRec.SetFilter("Sewing Unit", '=%1', true);
        LocationRec.SetRange(Code, 'VDSL');

        if LocationRec.FindSet() then begin
            repeat

                //Get all work center line details
                WorkCenterRec.Reset();
                WorkCenterRec.SetRange("Factory No.", LocationRec.Code);
                WorkCenterRec.SetFilter("Planning Line", '=%1', true);
                WorkCenterRec.SetRange("No.", 'VDSL-TEAM-01');

                if WorkCenterRec.FindSet() then begin

                    repeat

                        //Get the last working date.
                        dtLastDate := ProdDate - 1;
                        HoursPerDay := 0;
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
                                JobPlaLineRec.FindFirst();

                                TempQty := 0;

                                if JobPlaLineRec.Carder <> 0 then
                                    Carder := JobPlaLineRec.Carder;

                                if JobPlaLineRec.Eff <> 0 then
                                    Eff := JobPlaLineRec.Eff;

                                SMV := JobPlaLineRec.SMV;
                                LineNo := JobPlaLineRec."Line No.";


                                TargetPerDay := round(((60 / SMV) * Carder * HoursPerDay * Eff) / 100, 1);
                                TargetPerHour := round(TargetPerDay / HoursPerDay, 1);
                                TempDate := dtStart;


                                //Update Prod status of all lines                                                
                                ProdOutHeaderRec.Reset();
                                ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
                                ProdOutHeaderRec.SetFilter("Prod Date", '=%1', ProdDate);
                                ProdOutHeaderRec.SetRange("Resource No.", WorkCenterNo);

                                if ProdOutHeaderRec.FindSet() then
                                    ProdOutHeaderRec.ModifyAll("Prod Updated", 1);


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

                                // if LineNo = 1028 then
                                //     Message('1028');

                                repeat

                                    //Get working hours for the day
                                    HoursPerDay := 0;
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

                                            if (TempHours IN [0.0001 .. 0.99]) then
                                                TempHours := 1;

                                            TempHours := round(TempHours, 1);

                                        end;
                                    end
                                    else begin

                                        if (TempQty + (TargetPerHour * HoursPerDay)) < (JobPlaLineRec.Qty - OutputQty) then begin
                                            TempQty += (TargetPerHour * HoursPerDay);
                                            xQty := TargetPerHour * HoursPerDay;
                                        end
                                        else begin
                                            TempQty1 := (JobPlaLineRec.Qty - OutputQty) - TempQty;
                                            TempQty := TempQty + TempQty1;
                                            TempHours := TempQty1 / TargetPerHour;
                                            xQty := TempQty1;

                                            if (TempHours IN [0.0001 .. 0.99]) then
                                                TempHours := 1;

                                            TempHours := round(TempHours, 1);
                                        end;

                                    end;


                                    //Get Max Lineno
                                    MaxLineNo := 0;
                                    ProdPlansDetails.Reset();

                                    if ProdPlansDetails.FindLast() then
                                        MaxLineNo := ProdPlansDetails."No.";

                                    MaxLineNo += 1;

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
                                        ProdPlansDetails."Learning Curve No." := JobPlaLineRec."Learning Curve No.";
                                        ProdPlansDetails.SMV := JobPlaLineRec.SMV;

                                        if TimeEnd1 <> 0T then
                                            ProdPlansDetails."Start Time" := TimeEnd1
                                        else
                                            if i = 1 then
                                                ProdPlansDetails."Start Time" := TImeStart
                                            else
                                                ProdPlansDetails."Start Time" := LocationRec."Start Time";


                                        if TempHours = 0 then
                                            ProdPlansDetails."Finish Time" := LocationRec."Finish Time"
                                        else begin
                                            if i = 1 then
                                                if (LocationRec."Finish Time" < ProdPlansDetails."Start Time" + 60 * 60 * 1000 * TempHours) then
                                                    ProdPlansDetails."Finish Time" := LocationRec."Finish Time"
                                                else
                                                    ProdPlansDetails."Finish Time" := ProdPlansDetails."Start Time" + 60 * 60 * 1000 * TempHours
                                            else begin
                                                if TimeEnd1 = 0T then
                                                    ProdPlansDetails."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours
                                                else
                                                    ProdPlansDetails."Finish Time" := ProdPlansDetails."Start Time" + 60 * 60 * 1000 * TempHours;
                                            end;
                                        end;

                                        ProdPlansDetails.Qty := xQty;
                                        ProdPlansDetails.Target := TargetPerDay;
                                        ProdPlansDetails.HoursPerDay := HoursPerDay;
                                        ProdPlansDetails.ProdUpd := 0;
                                        ProdPlansDetails.ProdUpdQty := 0;
                                        ProdPlansDetails."Created User" := UserId;
                                        ProdPlansDetails."Created Date" := WorkDate();
                                        ProdPlansDetails."Factory No." := JobPlaLineRec.Factory;
                                        ProdPlansDetails.Insert();
                                    end;

                                    TempDate := TempDate + 1;

                                until (TempQty >= (JobPlaLineRec.Qty - OutputQty));

                                TempDate := TempDate - 1;

                                if (TempHours = 0) and ((JobPlaLineRec.Qty - OutputQty) > 0) then
                                    TempDate := TempDate - 1;


                                JobPlaLineRec."Start Date" := dtStart;
                                JobPlaLineRec."End Date" := TempDate;

                                if TimeEnd1 <> 0T then
                                    JobPlaLineRec."Start Time" := TimeEnd1
                                else
                                    JobPlaLineRec."Start Time" := TImeStart;

                                if TempHours = 0 then
                                    JobPlaLineRec."Finish Time" := LocationRec."Finish Time"
                                else begin
                                    if i = 1 then
                                        if (LocationRec."Finish Time" < JobPlaLineRec."Start Time" + 60 * 60 * 1000 * TempHours) then
                                            JobPlaLineRec."Finish Time" := LocationRec."Finish Time"
                                        else
                                            JobPlaLineRec."Finish Time" := JobPlaLineRec."Start Time" + 60 * 60 * 1000 * TempHours
                                    else begin
                                        if TimeEnd1 = 0T then
                                            JobPlaLineRec."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours
                                        else
                                            JobPlaLineRec."Finish Time" := JobPlaLineRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                    end;

                                end;


                                if TimeEnd1 <> 0T then
                                    JobPlaLineRec.StartDateTime := CREATEDATETIME(dtStart, TimeEnd1)
                                else
                                    JobPlaLineRec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);

                                JobPlaLineRec.FinishDateTime := CREATEDATETIME(TempDate, JobPlaLineRec."Finish Time");
                                JobPlaLineRec.ProdUpdDays := JobPlaLineRec.ProdUpdDays + 1;
                                JobPlaLineRec.Qty := JobPlaLineRec.Qty - OutputQty;
                                JobPlaLineRec.Modify();

                                TempTIme := JobPlaLineRec."Finish Time";
                                TimeEnd1 := JobPlaLineRec."Finish Time";
                                dtEnd1 := TempDate;

                                //Update StyleMsterPO table
                                StyleMasterPORec.Reset();
                                StyleMasterPORec.SetRange("Style No.", JobPlaLineRec."Style No.");
                                StyleMasterPORec.SetRange("lot No.", JobPlaLineRec."lot No.");
                                StyleMasterPORec.FindSet();
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


                                //Check whether new allocation conflicts other allocation      
                                Flag := 0;
                                JobPlaLine1Rec.Reset();
                                JobPlaLine1Rec.SetRange("Resource No.", WorkCenterNo);
                                JobPlaLine1Rec.SetRange("StartDateTime", CreateDateTime(dtStart, JobPlaLineRec."Start Time"), CreateDateTime(TempDate, TempTIme));
                                JobPlaLine1Rec.SetCurrentKey(StartDateTime);
                                JobPlaLine1Rec.SetAscending(StartDateTime, false);
                                JobPlaLine1Rec.SetFilter("Line No.", '<>%1', LineNo);

                                if JobPlaLine1Rec.FindSet() then           //conflicts yes
                                    Flag := 1
                                else begin                                 //No conflicts
                                                                           //Check for same day allocations
                                    JobPlaLine1Rec.Reset();
                                    JobPlaLine1Rec.SetRange("Resource No.", WorkCenterNo);
                                    JobPlaLine1Rec.SetFilter("Start Date", '<%1', dtStart);
                                    JobPlaLine1Rec.SetCurrentKey(StartDateTime);
                                    JobPlaLine1Rec.SetAscending(StartDateTime, false);
                                    JobPlaLine1Rec.SetFilter("Line No.", '<>%1', LineNo);
                                    if JobPlaLine1Rec.FindSet() then
                                        Flag := 1           //same day allocations yes
                                    else
                                        Flag := 0          //No same day allocations
                                end;

                                if Flag = 1 then begin

                                    Found := false;
                                    HoursPerDay := 0;
                                    i := 0;
                                    TempQty := 0;
                                    dtStart := TempDate;
                                    // TImeStart := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                    TImeStart := TempTIme;
                                    LineNo := JobPlaLine1Rec."Line No.";
                                    Qty := JobPlaLine1Rec.Qty;

                                    //repeat for all the items, until no items 
                                    repeat

                                        i := 0;

                                        if JobPlaLine1Rec.Carder <> 0 then
                                            Carder := JobPlaLine1Rec.Carder;

                                        if JobPlaLine1Rec.Eff <> 0 then
                                            Eff := JobPlaLine1Rec.Eff;

                                        SMV := JobPlaLine1Rec.SMV;

                                        HoursPerDay := 0;
                                        //if start time greater than parameter Finish time, set start time next day morning
                                        if ((TImeStart - LocationRec."Finish Time") >= 0) then begin
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

                                        // //Delete old lines
                                        // ProdPlansDetails.Reset();
                                        // ProdPlansDetails.SetRange("Line No.", LineNo);
                                        // ProdPlansDetails.DeleteAll();

                                        repeat

                                            //Get working hours for the day
                                            HoursPerDay := 0;
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



                                            //No learning curve for holidays
                                            if HoursPerDay > 0 then
                                                i += 1;

                                            if (i = 1) and (HoursPerDay > 0) then begin
                                                //Calculate hours for the first day (substracti hours if delay start)
                                                HoursPerDay := HoursPerDay - (TImeStart - LocationRec."Start Time") / 3600000;
                                            end;

                                            if LineNo = 1018 then
                                                Message('1018');

                                            if JobPlaLine1Rec."Learning Curve No." <> 0 then begin

                                                //Aplly learning curve
                                                LearningCurveRec.Reset();
                                                LearningCurveRec.SetRange("No.", JobPlaLine1Rec."Learning Curve No.");

                                                if LearningCurveRec.FindSet() then begin
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

                                                    if (TempHours IN [0.0001 .. 0.99]) then
                                                        TempHours := 1;

                                                    TempHours := round(TempHours, 1);

                                                end;
                                            end
                                            else begin

                                                if (TempQty + (TargetPerHour * HoursPerDay)) < (Qty - OutputQty) then begin
                                                    TempQty += (TargetPerHour * HoursPerDay);
                                                    xQty := TargetPerHour * HoursPerDay;
                                                end
                                                else begin
                                                    TempQty1 := (Qty - OutputQty) - TempQty;
                                                    TempQty := TempQty + TempQty1;
                                                    TempHours := TempQty1 / TargetPerHour;
                                                    xQty := TempQty1;

                                                    if (TempHours IN [0.0001 .. 0.99]) then
                                                        TempHours := 1;

                                                    TempHours := round(TempHours, 1);
                                                end;

                                            end;


                                            //Get Max Lineno
                                            MaxLineNo := 0;
                                            ProdPlansDetails.Reset();

                                            if ProdPlansDetails.FindLast() then
                                                MaxLineNo := ProdPlansDetails."No.";

                                            MaxLineNo += 1;

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
                                            ProdPlansDetails."Learning Curve No." := JobPlaLine1Rec."Learning Curve No.";
                                            ProdPlansDetails.SMV := JobPlaLine1Rec.SMV;

                                            if i = 1 then
                                                ProdPlansDetails."Start Time" := TImeStart
                                            else
                                                ProdPlansDetails."Start Time" := LocationRec."Start Time";

                                            if TempHours = 0 then
                                                ProdPlansDetails."Finish Time" := LocationRec."Finish Time"
                                            else begin
                                                if i = 1 then
                                                    if (LocationRec."Finish Time" < TImeStart + 60 * 60 * 1000 * TempHours) then
                                                        ProdPlansDetails."Finish Time" := LocationRec."Finish Time"
                                                    else
                                                        ProdPlansDetails."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                                                else
                                                    ProdPlansDetails."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                            end;

                                            // if TempHours = 0 then
                                            //     ProdPlansDetails."Finish Time" := LocationRec."Finish Time"
                                            // else
                                            //     ProdPlansDetails."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;

                                            ProdPlansDetails.Qty := xQty;
                                            ProdPlansDetails.Target := TargetPerDay;
                                            ProdPlansDetails.HoursPerDay := HoursPerDay;
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
                                        JobPlaLine1Rec.Reset();
                                        JobPlaLine1Rec.SetRange("Line No.", LineNo);
                                        JobPlaLine1Rec.FindSet();
                                        JobPlaLine1Rec."Start Date" := dtStart;
                                        JobPlaLine1Rec."End Date" := TempDate;
                                        JobPlaLine1Rec."Start Time" := TImeStart;

                                        if TempHours = 0 then
                                            JobPlaLine1Rec."Finish Time" := LocationRec."Finish Time"
                                        else begin
                                            if i = 1 then
                                                if (LocationRec."Finish Time" < TImeStart + 60 * 60 * 1000 * TempHours) then
                                                    JobPlaLine1Rec."Finish Time" := LocationRec."Finish Time"
                                                else
                                                    JobPlaLine1Rec."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                                            else
                                                JobPlaLine1Rec."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                        end;

                                        // if TempHours = 0 then
                                        //     JobPlaLine1Rec."Finish Time" := LocationRec."Finish Time"
                                        // else
                                        //     JobPlaLine1Rec."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;

                                        JobPlaLine1Rec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);
                                        JobPlaLine1Rec.FinishDateTime := CREATEDATETIME(TempDate, JobPlaLine1Rec."Finish Time");
                                        JobPlaLine1Rec.Qty := Qty - OutputQty;
                                        JobPlaLine1Rec.Modify();

                                        TempTIme := JobPlaLine1Rec."Finish Time";

                                        //delete allocation if remaining qty is 0 or less than 0
                                        JobPlaLine1Rec.Reset();
                                        JobPlaLine1Rec.SetRange("Line No.", LineNo);

                                        if JobPlaLine1Rec.FindSet() then begin
                                            if JobPlaLine1Rec.Qty <= 0 then
                                                JobPlaLine1Rec.DeleteAll();
                                        end;


                                        //Check whether new allocation conflicts other allocation                     
                                        JobPlaLine1Rec.Reset();
                                        JobPlaLine1Rec.SetRange("Resource No.", WorkCenterNo);
                                        JobPlaLine1Rec.SetRange("StartDateTime", CreateDateTime(dtStart, TImeStart), CreateDateTime(TempDate, TempTIme));
                                        JobPlaLine1Rec.SetCurrentKey(StartDateTime);
                                        JobPlaLine1Rec.Ascending(true);
                                        JobPlaLine1Rec.SetFilter("Line No.", '<>%1', LineNo);

                                        if JobPlaLine1Rec.FindSet() then begin
                                            Found := true;
                                            dtStart := TempDate;
                                            TImeStart := TempTIme;
                                            // TImeStart := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                            LineNo := JobPlaLine1Rec."Line No.";
                                            Qty := JobPlaLine1Rec.Qty;
                                        end
                                        else
                                            Found := false;

                                    until (not Found);

                                end;

                                status := 1;

                            end;
                        end;

                    until WorkCenterRec.Next() = 0;

                end;

            until LocationRec.Next() = 0;

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