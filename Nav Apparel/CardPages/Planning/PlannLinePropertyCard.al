page 50343 "Planning Line Property Card"
{
    PageType = Card;
    Caption = 'Planning Line Property';
    SourceTable = "NavApp Planning Lines";
    ApplicationArea = All;
    UsageCategory = Administration;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(Properties)
            {
                field(buyer; Buyer)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Buyer';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Editable = false;
                }

                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Lot No';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'PO No';
                }

                field(OrderQty; OrderQty)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Order Qty';
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Planned Qty';
                }

                field(SMV; rec.SMV)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Carder; rec.Carder)
                {
                    ApplicationArea = All;
                    Caption = 'Man/Machine Req.';

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field(Eff; rec.Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Efficiency (%)';

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field(HoursPerDay; rec.HoursPerDay)
                {
                    ApplicationArea = All;
                    Caption = 'Working Hours Per Day';
                    Editable = false;

                    trigger OnValidate()
                    var
                    begin
                        Cal();
                    end;
                }

                field(Target; rec.Target)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if (rec.Carder = 0) or (rec.HoursPerDay = 0) then begin
                            Message('Carder or HoursPerDay is zero. Cannot continue.');
                        end
                        else
                            rec.Eff := (rec.Target * 100 * rec.SMV) / (60 * rec.Carder * rec.HoursPerDay);

                        if rec.HoursPerDay > 0 then
                            HourlyTarget := round(rec.Target / rec.HoursPerDay, 1)
                        else
                            HourlyTarget := 0;
                    end;
                }

                field(HourlyTarget; HourlyTarget)
                {
                    ApplicationArea = All;
                    Caption = 'Hourly Target';
                    Editable = false;
                    DecimalPlaces = 0;
                }

                field("Learning Curve No."; rec."Learning Curve No.")
                {
                    ApplicationArea = All;
                    Caption = 'Learning Curve';
                }

                field("TGTSEWFIN Date"; rec."TGTSEWFIN Date")
                {
                    ApplicationArea = All;
                    Caption = 'Req. Saw. Finish Date';
                    Editable = false;
                }

                field(BPCD; BPCD)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(ShipDate; ShipDate)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Ship Date';
                }
            }

            part("Property Picture FactBox  Plan"; "Property Picture FactBox Plan")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Style No.");
                Caption = ' ';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Confirm)
            {
                ApplicationArea = All;
                Image = Confirm;
                Caption = 'Confirm';

                trigger OnAction()
                var
                    JobPlaLineRec: Record "NavApp Planning Lines";
                    JobPlaLineModRec: Record "NavApp Planning Lines";
                    ResCapacityEntryRec: Record "Calendar Entry";
                    LearningCurveRec: Record "Learning Curve";
                    SHCalHolidayRec: Record "Shop Calendar Holiday";
                    SHCalWorkRec: Record "Shop Calendar Working Days";
                    ProdPlansDetails: Record "NavApp Prod Plans Details";
                    LocationRec: Record Location;
                    NavAppCodeUnit3Rec: Codeunit NavAppCodeUnit3;
                    ResourceRec: Record "Work Center";
                    WorkCenCapacityEntryRec: Record "Calendar Entry";
                    JobPlaLine2Rec: Record "NavApp Planning Lines";

                    MaxLineNo: BigInteger;
                    dtStart: Date;
                    dtEnd: Date;
                    TImeStart: Time;
                    LineNo: BigInteger;
                    LineNo1: text;
                    TargetPerDay: BigInteger;
                    HrsPerDay: Decimal;
                    TargetPerHour: Decimal;
                    TempDate: Date;
                    Rate: Decimal;
                    TempQty: BigInteger;
                    TempQty1: BigInteger;
                    i: Integer;
                    TempHours: Decimal;
                    DayForWeek: Record Date;
                    Day: Integer;
                    LCurveFinishDate: Date;
                    LCurveStartTime: Time;
                    LCurveFinishTime: Time;
                    LcurveTemp: Decimal;
                    Holiday: code[10];
                    xQty: Decimal;
                    StyleDesc: text[200];
                    Counter: Integer;
                    ApplyLearningCurve: Integer;
                    TempTIme: Time;
                    Prev_FinishedDateTime: DateTime;
                    XX: Integer;
                    X: Integer;
                    HoursPerDay1: Decimal;
                    HoursPerDay2: Decimal;
                    RowCount1: Integer;
                    N1: Integer;
                    StartTime2: time;
                    ArrayOfAllocations: Array[100] of BigInteger;
                    Curr_StartDateTime: DateTime;
                    HoursGap: Decimal;
                    Eff: Decimal;
                    Carder: Integer;
                    SMV: Decimal;
                    Qty: BigInteger;
                    ddddddtttt: DateTime;
                    dtNextMonth: date;
                    dtLastDate: date;
                    dtSt: Date;
                    dtEd: Date;
                    Count: Integer;
                    ApplyLCurve: Boolean;
                    ApplyLCurve1: Boolean;
                    dtTemp: date;
                    PordUpdQty: BigInteger;
                    LcurveHoursPerday: Decimal;
                    LCurveStartTimePerDay: Time;
                    FactoryFinishTime: Time;
                begin
                    //Check the user is planning user or not
                    if PlanningUser = false then
                        Error('You are not authorized to perform this task.');

                    //Get Start and Finish Time
                    LocationRec.Reset();
                    LocationRec.SetRange(code, rec.Factory);
                    LocationRec.FindSet();

                    //Get Resorce line details
                    ResourceRec.Reset();
                    ResourceRec.SetRange("No.", rec."Resource No.");
                    ResourceRec.FindSet();
                    if ResourceRec."LV Days" = 0 then
                        Error('LV Days not setup for the Sewing Line : %1', ResourceRec.Name);

                    HrsPerDay := rec.HoursPerDay;
                    Prev_FinishedDateTime := rec.FinishDateTime;
                    dtStart := rec."Start Date";
                    TImeStart := rec."Start Time";
                    TempDate := dtStart;

                    if rec."Learning Curve No." = 0 then
                        ApplyLCurve := false
                    else begin
                        ApplyLCurve := true;

                        //validate lCurve applying
                        ProdPlansDetails.Reset();
                        ProdPlansDetails.SetFilter(PlanDate, '%1..%2', dtStart - ResourceRec."LV Days", dtStart - 1);
                        ProdPlansDetails.SetRange("Style No.", rec."Style No.");
                        ProdPlansDetails.SetFilter("Line No.", '<>%1', rec."Line No.");
                        if ProdPlansDetails.FindSet() then begin
                            ApplyLCurve := false;
                            Message('Learning Curve already applied for the style %1 within %2 days. ', rec."Style Name", ResourceRec."LV Days");
                        end
                        else begin
                            //Validate same style same allocation
                            ProdPlansDetails.Reset();
                            ProdPlansDetails.SetFilter(PlanDate, '%1..%2', dtStart - ResourceRec."LV Days", dtStart - 1);
                            ProdPlansDetails.SetRange("Style No.", rec."Style No.");
                            ProdPlansDetails.SetFilter("Line No.", '=%1', rec."Line No.");
                            if not ProdPlansDetails.FindSet() then begin
                                ApplyLCurve := true
                            end
                            else begin
                                PordUpdQty := 0;
                                //Get completed lCurve hours
                                repeat
                                    if ProdPlansDetails.ProdUpd = 1 then
                                        PordUpdQty += ProdPlansDetails.ProdUpdQty;
                                until ProdPlansDetails.Next() = 0;

                                //Check for completed lCurve hours
                                LearningCurveRec.Reset();
                                LearningCurveRec.SetRange("No.", rec."Learning Curve No.");
                                if LearningCurveRec.FindSet() then begin
                                    if LearningCurveRec.Day1 > PordUpdQty then
                                        ApplyLCurve := true
                                    else
                                        ApplyLCurve := false;
                                end
                                else
                                    ApplyLCurve := true;
                            end;
                        end;
                    end;

                    //Delete old lines
                    ProdPlansDetails.Reset();
                    ProdPlansDetails.SetRange("Line No.", rec."Line No.");
                    ProdPlansDetails.SetFilter(ProdUpd, '=%1', 0);
                    if ProdPlansDetails.FindSet() then
                        ProdPlansDetails.DeleteAll();

                    //Check learning curve                        
                    LCurveFinishDate := dtStart;
                    LCurveFinishTime := TImeStart;
                    LCurveStartTime := TImeStart;

                    if (rec."Learning Curve No." <> 0) and (ApplyLCurve = true) then begin
                        LearningCurveRec.Reset();
                        LearningCurveRec.SetRange("No.", rec."Learning Curve No.");
                        if LearningCurveRec.FindSet() then begin

                            if LearningCurveRec.Type = LearningCurveRec.Type::Hourly then begin
                                LcurveTemp := LearningCurveRec.Day1 - PordUpdQty;
                                repeat
                                    FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(rec."Resource No.", LCurveFinishDate, LocationRec."Start Time");

                                    if ((FactoryFinishTime - LCurveStartTime) / 3600000 <= LcurveTemp) then begin
                                        LcurveTemp -= (FactoryFinishTime - LCurveStartTime) / 3600000;
                                        LCurveStartTime := LocationRec."Start Time";

                                        //if LcurveTemp > 0 then
                                        LCurveFinishDate += 1;

                                        //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                        HrsPerDay := 0;
                                        repeat

                                            ResCapacityEntryRec.Reset();
                                            ResCapacityEntryRec.SETRANGE("No.", rec."Resource No.");
                                            ResCapacityEntryRec.SETRANGE(Date, LCurveFinishDate);
                                            if ResCapacityEntryRec.FindSet() then begin
                                                repeat
                                                    HrsPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                                until ResCapacityEntryRec.Next() = 0;
                                            end;

                                            if HrsPerDay = 0 then begin

                                                //Validate the day (Holiday or Weekend)
                                                SHCalHolidayRec.Reset();
                                                SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
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
                                                    SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                    SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                                    if SHCalWorkRec.FindSet() then   //If not weekend
                                                        Error('Calender for date : %1  Work center : %2 has not calculated', LCurveFinishDate, ResourceRec.Name);
                                                end;
                                            end;

                                            if HrsPerDay = 0 then
                                                LCurveFinishDate := LCurveFinishDate + 1;

                                        until HrsPerDay > 0;
                                    end
                                    else begin
                                        LCurveStartTime := LCurveStartTime + 60 * 60 * 1000 * LcurveTemp;
                                        LcurveTemp -= LcurveTemp;
                                    end;
                                until LcurveTemp <= 0;

                                LCurveFinishTime := LCurveStartTime;
                            end;
                        end
                        else
                            Error('Cannot find L Curve : %1', rec."Learning Curve No.");
                    end;

                    repeat
                        //Get working hours for the day
                        HrsPerDay := 0;
                        Holiday := 'No';
                        TempHours := 0;
                        Rate := 0;
                        ResCapacityEntryRec.Reset();
                        ResCapacityEntryRec.SETRANGE("No.", rec."Resource No.");
                        ResCapacityEntryRec.SETRANGE(Date, TempDate);
                        if ResCapacityEntryRec.FindSet() then begin
                            repeat
                                HrsPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                            until ResCapacityEntryRec.Next() = 0;
                        end;

                        if HrsPerDay = 0 then begin

                            //Validate the day (Holiday or Weekend)
                            SHCalHolidayRec.Reset();
                            SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
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
                                SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                if SHCalWorkRec.FindSet() then   //If not weekend
                                    Error('Calender for date : %1  Work center : %2 has not calculated', TempDate, ResourceRec.Name)
                                else
                                    Holiday := 'Yes';
                            end
                            else
                                Holiday := 'Yes';
                        end;

                        //No learning curve for holidays
                        if HrsPerDay > 0 then
                            i += 1;

                        if (i = 1) and (HrsPerDay > 0) then begin
                            //Calculate hours for the first day (substracti hours if delay start)
                            HrsPerDay := HrsPerDay - (TImeStart - LocationRec."Start Time") / 3600000;
                        end;

                        TargetPerHour := round(((60 / rec.SMV) * rec.Carder * rec.Eff) / 100, 1);
                        TargetPerDay := round(TargetPerHour * HrsPerDay, 1);

                        if (rec."Learning Curve No." <> 0) and (ApplyLCurve = true) then begin

                            //Aplly learning curve
                            LearningCurveRec.Reset();
                            LearningCurveRec.SetRange("No.", rec."Learning Curve No.");
                            if LearningCurveRec.FindSet() then begin   //Efficiency wise
                                if LearningCurveRec.Type = LearningCurveRec.Type::"Efficiency Wise" then begin
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

                                    if (TempQty + round((TargetPerHour * HrsPerDay) * Rate / 100, 1) < rec.Qty) then begin
                                        TempQty += round((TargetPerHour * HrsPerDay) * Rate / 100, 1);
                                        xQty := round((TargetPerHour * HrsPerDay) * Rate / 100, 1);
                                    end
                                    else begin
                                        TempQty1 := rec.Qty - TempQty;
                                        TempQty := TempQty + TempQty1;
                                        TempHours := TempQty1 / TargetPerHour;
                                        xQty := TempQty1;

                                        if (TempHours IN [0.0001 .. 0.99]) then
                                            TempHours := 1;

                                        // TempHours := round(TempHours, 1, '>');
                                        TempHours := round(TempHours, 0.01);

                                    end;
                                end
                                else begin  //Hourly

                                    Rate := 100;
                                    LcurveHoursPerday := 0;
                                    LCurveStartTimePerDay := 0T;

                                    if LCurveFinishDate > TempDate then begin
                                        LcurveHoursPerday := HrsPerDay;   //Hourly target calculation purpose

                                        if LcurveHoursPerday = 0 then
                                            LCurveStartTimePerDay := 0T
                                        else begin
                                            if i = 1 then
                                                LCurveStartTimePerDay := LCurveStartTime
                                            else
                                                LCurveStartTimePerDay := LocationRec."Start Time";
                                        end;
                                        HrsPerDay := 0;
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

                                                    HrsPerDay := HrsPerDay - (TImeStart - LCurveFinishTime) / 3600000;
                                                end
                                                else begin

                                                    LcurveHoursPerday := (LCurveFinishTime - TImeStart) / 3600000;   //Hourly target calculation purpose
                                                    if LcurveHoursPerday = 0 then
                                                        LCurveStartTimePerDay := 0T
                                                    else
                                                        LCurveStartTimePerDay := TImeStart;

                                                    HrsPerDay := HrsPerDay - (LCurveFinishTime - TImeStart) / 3600000;
                                                end;
                                            end
                                            else begin

                                                if ((LCurveFinishTime - LocationRec."Start Time") / 3600000) < 0 then begin

                                                    LcurveHoursPerday := (LocationRec."Start Time" - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                    if LcurveHoursPerday = 0 then
                                                        LCurveStartTimePerDay := 0T
                                                    else
                                                        LCurveStartTimePerDay := LocationRec."Start Time";

                                                    HrsPerDay := HrsPerDay - (LocationRec."Start Time" - LCurveFinishTime) / 3600000;
                                                end
                                                else begin

                                                    LcurveHoursPerday := (LCurveFinishTime - LocationRec."Start Time") / 3600000;   //Hourly target calculation purpose
                                                    if LcurveHoursPerday = 0 then
                                                        LCurveStartTimePerDay := 0T
                                                    else
                                                        LCurveStartTimePerDay := LocationRec."Start Time";

                                                    HrsPerDay := HrsPerDay - (LCurveFinishTime - LocationRec."Start Time") / 3600000;
                                                end;
                                            end;

                                            // if i = 1 then begin

                                            //     if ((LCurveFinishTime - TImeStart) / 3600000) < 0 then
                                            //         HrsPerDay := HrsPerDay - (TImeStart - LCurveFinishTime) / 3600000
                                            //     else
                                            //         HrsPerDay := HrsPerDay - (LCurveFinishTime - TImeStart) / 3600000;
                                            // end
                                            // else begin

                                            //     if ((LCurveFinishTime - LocationRec."Start Time") / 3600000) < 0 then
                                            //         HrsPerDay := HrsPerDay - (LocationRec."Start Time" - LCurveFinishTime) / 3600000
                                            //     else
                                            //         HrsPerDay := HrsPerDay - (LCurveFinishTime - LocationRec."Start Time") / 3600000;
                                            // end;

                                        end;
                                    end;

                                    if (TempQty + round((TargetPerHour * HrsPerDay) * Rate / 100, 1) < rec.Qty) then begin
                                        TempQty += round((TargetPerHour * HrsPerDay) * Rate / 100, 1);
                                        xQty := round((TargetPerHour * HrsPerDay) * Rate / 100, 1);
                                    end
                                    else begin
                                        TempQty1 := rec.Qty - TempQty;
                                        xQty := TempQty1;
                                        TempQty := TempQty + TempQty1;
                                        TempHours := TempQty1 / TargetPerHour;

                                        if (TempHours IN [0.0001 .. 0.99]) then
                                            TempHours := 1;

                                        // TempHours := round(TempHours, 1, '>');
                                        TempHours := round(TempHours, 0.01);

                                    end;
                                end;
                            end;
                        end
                        else begin
                            if (TempQty + round((TargetPerHour * HrsPerDay), 1)) < rec.Qty then begin
                                TempQty += round((TargetPerHour * HrsPerDay), 1);
                                xQty := round(TargetPerHour * HrsPerDay, 1);
                            end
                            else begin
                                TempQty1 := rec.Qty - TempQty;
                                TempQty := TempQty + TempQty1;
                                TempHours := TempQty1 / TargetPerHour;
                                xQty := TempQty1;

                                if (TempHours IN [0.0001 .. 0.99]) then
                                    TempHours := 1;

                                // TempHours := round(TempHours, 1, '>');
                                TempHours := round(TempHours, 0.01);
                            end;
                        end;

                        xQty := Round(xQty, 1);

                        //Get Max Lineno
                        MaxLineNo := 0;
                        ProdPlansDetails.Reset();
                        if ProdPlansDetails.FindLast() then
                            MaxLineNo := ProdPlansDetails."No.";

                        MaxLineNo += 1;
                        FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(rec."Resource No.", TempDate, LocationRec."Start Time");

                        //insert to ProdPlansDetails
                        ProdPlansDetails.Init();
                        ProdPlansDetails."No." := MaxLineNo;
                        ProdPlansDetails.PlanDate := TempDate;
                        ProdPlansDetails."Style No." := rec."Style No.";
                        ProdPlansDetails."Style Name" := rec."Style Name";
                        ProdPlansDetails."PO No." := rec."PO No.";
                        ProdPlansDetails."lot No." := rec."lot No.";
                        ProdPlansDetails."Line No." := rec."Line No.";
                        ProdPlansDetails."Resource No." := rec."Resource No.";
                        ProdPlansDetails.Carder := rec.Carder;
                        ProdPlansDetails.Eff := rec.Eff;
                        ProdPlansDetails.SMV := rec.SMV;

                        if Holiday = 'NO' then begin
                            if i = 1 then
                                ProdPlansDetails."Start Time" := TImeStart
                            else
                                ProdPlansDetails."Start Time" := LocationRec."Start Time";

                            if TempHours = 0 then
                                ProdPlansDetails."Finish Time" := FactoryFinishTime
                            else begin
                                if i = 1 then
                                    ProdPlansDetails."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                                else
                                    ProdPlansDetails."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                            end;
                        end;

                        ProdPlansDetails.Qty := xQty;
                        ProdPlansDetails.Target := rec.Target;

                        if Holiday = 'NO' then
                            if TempHours > 0 then
                                ProdPlansDetails.HoursPerDay := TempHours
                            else
                                ProdPlansDetails.HoursPerDay := HrsPerDay
                        else
                            ProdPlansDetails.HoursPerDay := 0;


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
                                ProdPlansDetails."Learning Curve No." := rec."Learning Curve No.";
                        end;

                        ProdPlansDetails.ProdUpd := 0;
                        ProdPlansDetails.ProdUpdQty := 0;
                        ProdPlansDetails."Created User" := UserId;
                        ProdPlansDetails."Created Date" := WorkDate();
                        ProdPlansDetails."Factory No." := rec.Factory;
                        ProdPlansDetails.Insert();

                        if LCurveFinishDate = TempDate then begin
                            ApplyLCurve := false;
                            LcurveHoursPerday := 0;
                            LCurveStartTimePerDay := 0T;
                        end;

                        TempDate := TempDate + 1;

                    until (TempQty >= rec.Qty);

                    TempDate := TempDate - 1;

                    if TempHours = 0 then
                        TempDate := TempDate - 1;

                    //modify Planning line table
                    JobPlaLineRec.Reset();
                    JobPlaLineRec.SetRange("Line No.", rec."Line No.");
                    JobPlaLineRec.FindSet();
                    JobPlaLineRec."Resource No." := rec."Resource No.";
                    JobPlaLineRec."Resource Name" := rec."Resource Name";
                    JobPlaLineRec."Start Date" := dtStart;
                    JobPlaLineRec."End Date" := TempDate;
                    JobPlaLineRec."Start Time" := TImeStart;

                    if TempHours = 0 then
                        JobPlaLineRec."Finish Time" := FactoryFinishTime
                    else begin
                        if i = 1 then
                            if (FactoryFinishTime < TImeStart + 60 * 60 * 1000 * TempHours) then
                                JobPlaLineRec."Finish Time" := FactoryFinishTime
                            else
                                JobPlaLineRec."Finish Time" := TImeStart + 60 * 60 * 1000 * TempHours
                        else
                            JobPlaLineRec."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                    end;

                    JobPlaLineRec."Created User" := UserId;
                    JobPlaLineRec."Created Date" := WorkDate();
                    JobPlaLineRec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);
                    JobPlaLineRec.FinishDateTime := CREATEDATETIME(TempDate, JobPlaLineRec."Finish Time");
                    JobPlaLineRec.Modify();

                    TempTIme := JobPlaLineRec."Finish Time";

                    ///////////////////get all allocations aftert the selected allocation 
                    TempHours := 0;

                    JobPlaLineRec.Reset();
                    JobPlaLineRec.SetRange("Resource No.", rec."Resource No.");
                    JobPlaLineRec.SetFilter("StartDateTime", '>=%1', Prev_FinishedDateTime);
                    JobPlaLineRec.SetCurrentKey(StartDateTime);
                    JobPlaLineRec.Ascending(true);
                    JobPlaLineRec.SetFilter("Line No.", '<>%1', rec."Line No.");
                    if JobPlaLineRec.FindSet() then begin

                        HrsPerDay := 0;
                        i := 0;
                        N1 := 0;
                        TempQty := 0;
                        RowCount1 := JobPlaLineRec.Count;
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
                                ArrayOfAllocations[N1] := JobPlaLineRec."Line No.";
                            until JobPlaLineRec.Next() = 0;

                            N1 := 0;
                            for N1 := 1 To RowCount1 do begin

                                HoursGap := 0;
                                JobPlaLineRec.Reset();
                                JobPlaLineRec.SetRange("Resource No.", rec."Resource No.");
                                JobPlaLineRec.SetFilter("Line No.", '=%1', ArrayOfAllocations[N1]);
                                if JobPlaLineRec.FindSet() then begin

                                    i := 0;
                                    Qty := JobPlaLineRec.Qty;
                                    LineNo := JobPlaLineRec."Line No.";

                                    if rec."Style No." = JobPlaLineRec."Style No." then begin  //Same as initial style
                                        SMV := rec.SMV;
                                        Carder := rec.Carder;
                                        Eff := rec.Eff;
                                    end
                                    else begin              //Different Style   
                                        SMV := JobPlaLineRec.SMV;
                                        Carder := JobPlaLineRec.Carder;
                                        Eff := JobPlaLineRec.Eff;
                                    end;

                                    if JobPlaLineRec."Learning Curve No." = 0 then
                                        ApplyLCurve := false
                                    else begin
                                        ApplyLCurve := true;

                                        //validate lCurve applying
                                        ProdPlansDetails.Reset();
                                        ProdPlansDetails.SetFilter(PlanDate, '%1..%2', JobPlaLineRec."Start Date" - ResourceRec."LV Days", JobPlaLineRec."Start Date" - 1);
                                        ProdPlansDetails.SetRange("Style No.", JobPlaLineRec."Style No.");
                                        ProdPlansDetails.SetFilter("Line No.", '<>%1', JobPlaLineRec."Line No.");
                                        if ProdPlansDetails.FindSet() then
                                            ApplyLCurve := false;
                                    end;

                                    ApplyLCurve1 := ApplyLCurve;
                                    dtStart := TempDate;
                                    TImeStart := TempTIme;
                                    Curr_StartDateTime := JobPlaLineRec.StartDateTime;

                                    //Calculate hourly gap between prevous and current allocation
                                    if Prev_FinishedDateTime <> 0DT then begin
                                        if DT2DATE(Prev_FinishedDateTime) = DT2DATE(Curr_StartDateTime) then
                                            HoursGap := 0 //HoursGap is  zero since dateas are same                                    
                                        else begin

                                            if (DT2DATE(Curr_StartDateTime) - DT2DATE(Prev_FinishedDateTime) + 1) > 2 then begin
                                                XX := (DT2DATE(Curr_StartDateTime) - DT2DATE(Prev_FinishedDateTime) + 1);
                                                HoursPerDay2 := 0;

                                                for X := 1 To XX do begin
                                                    HoursPerDay1 := 0;
                                                    ResCapacityEntryRec.Reset();
                                                    ResCapacityEntryRec.SETRANGE("No.", rec."Resource No.");
                                                    ResCapacityEntryRec.SETRANGE(Date, DT2DATE(Prev_FinishedDateTime) + (X - 1));
                                                    if ResCapacityEntryRec.FindSet() then begin
                                                        repeat
                                                            HoursPerDay1 += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                                        until ResCapacityEntryRec.Next() = 0;
                                                    end;

                                                    FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(rec."Resource No.", DT2DATE(Prev_FinishedDateTime) + (X - 1), LocationRec."Start Time");

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
                                            end
                                            else   //If HoursGap less than 48 hours, no Gap
                                                HoursGap := 0;
                                        end;
                                    end;

                                    //Based on Hourly Gap, calculate start Date/time of current allocation 
                                    if HoursGap > 0 then begin

                                        ddddddtttt := CREATEDATETIME(dtStart, TImeStart);
                                        FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(rec."Resource No.", dtStart, LocationRec."Start Time");

                                        if (CREATEDATETIME(dtStart, FactoryFinishTime) <= (ddddddtttt + (60 * 60 * 1000 * HoursGap))) then begin

                                            HoursGap := HoursGap - (FactoryFinishTime - TImeStart) / 3600000;
                                            TImeStart := LocationRec."Start Time";
                                            dtStart := dtStart + 1;

                                            if HoursGap > 0 then begin
                                                repeat

                                                    //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                                    repeat

                                                        HrsPerDay := 0;
                                                        WorkCenCapacityEntryRec.Reset();
                                                        WorkCenCapacityEntryRec.SETRANGE("No.", rec."Resource No.");
                                                        WorkCenCapacityEntryRec.SETRANGE(Date, dtStart);

                                                        if WorkCenCapacityEntryRec.FindSet() then begin
                                                            repeat
                                                                HrsPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                                            until WorkCenCapacityEntryRec.Next() = 0;
                                                        end
                                                        else begin
                                                            Count := 0;
                                                            dtNextMonth := CalcDate('<+1M>', dtStart);
                                                            dtSt := CalcDate('<-CM>', dtNextMonth);
                                                            dtEd := CalcDate('<+CM>', dtNextMonth);

                                                            WorkCenCapacityEntryRec.Reset();
                                                            WorkCenCapacityEntryRec.SETRANGE("No.", rec."Resource No.");
                                                            WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);

                                                            if WorkCenCapacityEntryRec.FindSet() then
                                                                Count += WorkCenCapacityEntryRec.Count;

                                                            if Count < 14 then
                                                                Error('Calender is not setup for the Line : %1', rec."Resource Name");
                                                        end;

                                                        if HrsPerDay = 0 then
                                                            dtStart := dtStart + 1;

                                                    until HrsPerDay > 0;

                                                    if (HrsPerDay > HoursGap) then begin
                                                        TImeStart := TImeStart + (60 * 60 * 1000 * HoursGap);
                                                        HoursGap := 0;
                                                    end
                                                    else begin
                                                        HoursGap := HoursGap - HrsPerDay;
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

                                    HrsPerDay := 0;
                                    //if start time greater than parameter Finish time, set start time next day morning
                                    if ((TImeStart - FactoryFinishTime) >= 0) then begin
                                        TImeStart := LocationRec."Start Time";
                                        dtStart := dtStart + 1;
                                        TempDate := dtStart;
                                    end;

                                    //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                    repeat
                                        WorkCenCapacityEntryRec.Reset();
                                        WorkCenCapacityEntryRec.SETRANGE("No.", rec."Resource No.");
                                        WorkCenCapacityEntryRec.SETRANGE(Date, dtStart);
                                        if WorkCenCapacityEntryRec.FindSet() then begin
                                            repeat
                                                HrsPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                            until WorkCenCapacityEntryRec.Next() = 0;
                                        end
                                        else begin
                                            Count := 0;
                                            dtNextMonth := CalcDate('<+1M>', dtStart);
                                            dtSt := CalcDate('<-CM>', dtNextMonth);
                                            dtEd := CalcDate('<+CM>', dtNextMonth);

                                            WorkCenCapacityEntryRec.Reset();
                                            WorkCenCapacityEntryRec.SETRANGE("No.", rec."Resource No.");
                                            WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);

                                            if WorkCenCapacityEntryRec.FindSet() then
                                                Count += WorkCenCapacityEntryRec.Count;

                                            if Count < 14 then
                                                Error('Calender is not setup for the Line : %1', rec."Resource Name");
                                        end;

                                        if HrsPerDay = 0 then
                                            dtStart := dtStart + 1;

                                    until HrsPerDay > 0;

                                    if rec."Style No." = JobPlaLineRec."Style No." then begin   //Same as initial style 
                                        // TargetPerDay := rec.Target;
                                        // TargetPerHour := round(TargetPerDay / HrsPerDay, 1);
                                    end
                                    else begin
                                        TargetPerHour := round(((60 / SMV) * Carder * Eff) / 100, 1);
                                        TargetPerDay := round(TargetPerHour * HrsPerDay, 1);
                                    end;

                                    TempQty := 0;

                                    //Delete old lines
                                    ProdPlansDetails.Reset();
                                    ProdPlansDetails.SetRange("Line No.", LineNo);
                                    ProdPlansDetails.SetFilter(ProdUpd, '=%1', 0);
                                    if ProdPlansDetails.FindSet() then
                                        ProdPlansDetails.DeleteAll();

                                    //Check learning curve                        
                                    LCurveFinishDate := TempDate;
                                    LCurveFinishTime := TImeStart;
                                    LCurveStartTime := TImeStart;

                                    if JobPlaLineRec."Learning Curve No." <> 0 then begin
                                        LearningCurveRec.Reset();
                                        LearningCurveRec.SetRange("No.", JobPlaLineRec."Learning Curve No.");
                                        if LearningCurveRec.FindSet() then begin

                                            if LearningCurveRec.Type = LearningCurveRec.Type::Hourly then begin
                                                LcurveTemp := LearningCurveRec.Day1;

                                                repeat
                                                    FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(JobPlaLineRec."Resource No.", LCurveFinishDate, LocationRec."Start Time");

                                                    if ((FactoryFinishTime - LCurveStartTime) / 3600000 <= LcurveTemp) then begin
                                                        LcurveTemp -= (FactoryFinishTime - LCurveStartTime) / 3600000;
                                                        LCurveStartTime := LocationRec."Start Time";
                                                        LCurveFinishDate += 1;

                                                        //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                                                        HrsPerDay := 0;
                                                        repeat

                                                            ResCapacityEntryRec.Reset();
                                                            ResCapacityEntryRec.SETRANGE("No.", JobPlaLineRec."Resource No.");
                                                            ResCapacityEntryRec.SETRANGE(Date, LCurveFinishDate);
                                                            if ResCapacityEntryRec.FindSet() then begin
                                                                repeat
                                                                    HrsPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                                                until ResCapacityEntryRec.Next() = 0;
                                                            end;

                                                            if HrsPerDay = 0 then begin
                                                                //Validate the day (Holiday or Weekend)
                                                                SHCalHolidayRec.Reset();
                                                                SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
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
                                                                    SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                                    SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                                                    if SHCalWorkRec.FindSet() then   //If not weekend
                                                                        Error('Calender for date : %1  Work center : %2 has not calculated', LCurveFinishDate, ResourceRec.Name);
                                                                end;
                                                            end;

                                                            if HrsPerDay = 0 then
                                                                LCurveFinishDate := LCurveFinishDate + 1;

                                                        until HrsPerDay > 0;
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
                                        ResourceRec.Reset();
                                        ResourceRec.SetRange("No.", rec."Resource No.");
                                        ResourceRec.FindSet();

                                        //Get working hours for the day
                                        HrsPerDay := 0;
                                        Rate := 0;
                                        Holiday := 'NO';
                                        TempHours := 0;

                                        WorkCenCapacityEntryRec.Reset();
                                        WorkCenCapacityEntryRec.SETRANGE("No.", rec."Resource No.");
                                        WorkCenCapacityEntryRec.SETRANGE(Date, TempDate);
                                        if WorkCenCapacityEntryRec.FindSet() then begin
                                            repeat
                                                HrsPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                                            until WorkCenCapacityEntryRec.Next() = 0;
                                        end
                                        else begin
                                            Count := 0;
                                            dtNextMonth := CalcDate('<+1M>', TempDate);
                                            dtSt := CalcDate('<-CM>', dtNextMonth);
                                            dtEd := CalcDate('<+CM>', dtNextMonth);

                                            WorkCenCapacityEntryRec.Reset();
                                            WorkCenCapacityEntryRec.SETRANGE("No.", rec."Resource No.");
                                            WorkCenCapacityEntryRec.SetFilter(Date, '%1..%2', dtSt, dtEd);

                                            if WorkCenCapacityEntryRec.FindSet() then
                                                Count += WorkCenCapacityEntryRec.Count;

                                            if Count < 14 then
                                                Error('Calender is not setup for the Line : %1', rec."Resource Name");
                                        end;

                                        if HrsPerDay = 0 then begin

                                            //Validate the day (Holiday or Weekend)
                                            SHCalHolidayRec.Reset();
                                            SHCalHolidayRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
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
                                                SHCalWorkRec.SETRANGE("Shop Calendar Code", ResourceRec."Shop Calendar Code");
                                                SHCalWorkRec.SetFilter(Day, '=%1', Day);
                                                if SHCalWorkRec.FindSet() then   //If not weekend
                                                    Error('Calender for date : %1  Work center : %2 has not calculated', TempDate, ResourceRec.Name)
                                                else
                                                    Holiday := 'Yes';
                                            end
                                            else
                                                Holiday := 'Yes';
                                        end;

                                        //No learning curve for holidays
                                        if HrsPerDay > 0 then
                                            i += 1;

                                        if (i = 1) and (HrsPerDay > 0) then begin
                                            //Calculate hours for the first day (substracti hours if delay start)
                                            HrsPerDay := HrsPerDay - (TImeStart - LocationRec."Start Time") / 3600000;
                                        end;

                                        // if JobPlaLineRec."Style Name" = 'ANDREW' then
                                        //     Message('stye');

                                        if (ApplyLCurve = true) then begin

                                            //Aplly learning curve
                                            LearningCurveRec.Reset();
                                            LearningCurveRec.SetRange("No.", JobPlaLineRec."Learning Curve No.");
                                            if LearningCurveRec.FindSet() then begin

                                                if LearningCurveRec.Type = LearningCurveRec.Type::"Efficiency Wise" then begin
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

                                                    if (TempQty + round((TargetPerHour * HrsPerDay) * Rate / 100, 1) < Qty) then begin
                                                        TempQty += round((TargetPerHour * HrsPerDay) * Rate / 100, 1);
                                                        xQty := round((TargetPerHour * HrsPerDay) * Rate / 100, 1);
                                                    end
                                                    else begin
                                                        TempQty1 := Qty - TempQty;
                                                        TempQty := TempQty + TempQty1;
                                                        TempHours := TempQty1 / TargetPerHour;
                                                        xQty := TempQty1;

                                                        if (TempHours IN [0.0001 .. 0.99]) then
                                                            TempHours := 1;

                                                        // TempHours := round(TempHours, 1, '>');
                                                        TempHours := round(TempHours, 0.01);
                                                    end;
                                                end
                                                else begin  //Hourly

                                                    Rate := 100;
                                                    LcurveHoursPerday := 0;
                                                    LCurveStartTimePerDay := 0T;

                                                    if LCurveFinishDate > TempDate then begin
                                                        LcurveHoursPerday := HrsPerDay;   //Hourly target calculation purpose

                                                        if LcurveHoursPerday = 0 then
                                                            LCurveStartTimePerDay := 0T
                                                        else begin
                                                            if i = 1 then
                                                                LCurveStartTimePerDay := LCurveStartTime
                                                            else
                                                                LCurveStartTimePerDay := LocationRec."Start Time";
                                                        end;
                                                        HrsPerDay := 0;
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

                                                                    HrsPerDay := HrsPerDay - (TImeStart - LCurveFinishTime) / 3600000;
                                                                end
                                                                else begin

                                                                    LcurveHoursPerday := (LCurveFinishTime - TImeStart) / 3600000;   //Hourly target calculation purpose
                                                                    if LcurveHoursPerday = 0 then
                                                                        LCurveStartTimePerDay := 0T
                                                                    else
                                                                        LCurveStartTimePerDay := TImeStart;

                                                                    HrsPerDay := HrsPerDay - (LCurveFinishTime - TImeStart) / 3600000;
                                                                end;
                                                            end
                                                            else begin
                                                                if ((LCurveFinishTime - LocationRec."Start Time") / 3600000) < 0 then begin

                                                                    LcurveHoursPerday := (LocationRec."Start Time" - LCurveFinishTime) / 3600000;   //Hourly target calculation purpose
                                                                    if LcurveHoursPerday = 0 then
                                                                        LCurveStartTimePerDay := 0T
                                                                    else
                                                                        LCurveStartTimePerDay := LocationRec."Start Time";

                                                                    HrsPerDay := HrsPerDay - (LocationRec."Start Time" - LCurveFinishTime) / 3600000;
                                                                end
                                                                else begin
                                                                    LcurveHoursPerday := (LCurveFinishTime - LocationRec."Start Time") / 3600000;   //Hourly target calculation purpose
                                                                    if LcurveHoursPerday = 0 then
                                                                        LCurveStartTimePerDay := 0T
                                                                    else
                                                                        LCurveStartTimePerDay := LocationRec."Start Time";

                                                                    HrsPerDay := HrsPerDay - (LCurveFinishTime - LocationRec."Start Time") / 3600000;
                                                                end;
                                                            end;
                                                        end
                                                        else begin
                                                            LCurveStartTimePerDay := 0T;
                                                            LcurveHoursPerday := 0;
                                                        end;
                                                    end;

                                                    if (TempQty + round((TargetPerHour * HrsPerDay) * Rate / 100, 1) < Qty) then begin
                                                        TempQty += round((TargetPerHour * HrsPerDay) * Rate / 100, 1);
                                                        xQty := round((TargetPerHour * HrsPerDay) * Rate / 100, 1);
                                                    end
                                                    else begin
                                                        TempQty1 := Qty - TempQty;
                                                        xQty := TempQty1;
                                                        TempQty := TempQty + TempQty1;
                                                        TempHours := TempQty1 / TargetPerHour;

                                                        if (TempHours IN [0.0001 .. 0.99]) then
                                                            TempHours := 1;

                                                        // TempHours := round(TempHours, 1, '>');
                                                        TempHours := round(TempHours, 0.01);
                                                    end;
                                                end;
                                            end;
                                        end
                                        else begin
                                            if (TempQty + (TargetPerHour * HrsPerDay)) < Qty then begin
                                                TempQty += round((TargetPerHour * HrsPerDay), 1);
                                                xQty := TargetPerHour * HrsPerDay;
                                            end
                                            else begin
                                                TempQty1 := Qty - TempQty;
                                                TempQty := TempQty + TempQty1;
                                                TempHours := TempQty1 / TargetPerHour;
                                                xQty := TempQty1;

                                                if (TempHours IN [0.0001 .. 0.99]) then
                                                    TempHours := 1;

                                                // TempHours := round(TempHours, 1, '>');
                                                TempHours := round(TempHours, 0.01);
                                            end;
                                        end;

                                        xQty := Round(xQty, 1);

                                        //Get Max Lineno
                                        MaxLineNo := 0;
                                        ProdPlansDetails.Reset();
                                        if ProdPlansDetails.FindLast() then
                                            MaxLineNo := ProdPlansDetails."No.";

                                        MaxLineNo += 1;
                                        FactoryFinishTime := NavAppCodeUnit3Rec.Get_FacFinishTime(rec."Resource No.", TempDate, LocationRec."Start Time");

                                        //insert to ProdPlansDetails
                                        ProdPlansDetails.Init();
                                        ProdPlansDetails."No." := MaxLineNo;
                                        ProdPlansDetails.PlanDate := TempDate;
                                        ProdPlansDetails."Style No." := JobPlaLineRec."Style No.";
                                        ProdPlansDetails."Style Name" := JobPlaLineRec."Style Name";
                                        ProdPlansDetails."PO No." := JobPlaLineRec."PO No.";
                                        ProdPlansDetails."Lot No." := JobPlaLineRec."Lot No.";
                                        ProdPlansDetails."Line No." := LineNo;
                                        ProdPlansDetails."Resource No." := rec."Resource No.";
                                        ProdPlansDetails.Carder := Carder;
                                        ProdPlansDetails.Eff := Eff;
                                        ProdPlansDetails.SMV := JobPlaLineRec.SMV;

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

                                        if Holiday = 'NO' then
                                            if TempHours > 0 then
                                                ProdPlansDetails.HoursPerDay := TempHours
                                            else
                                                ProdPlansDetails.HoursPerDay := HrsPerDay
                                        else
                                            ProdPlansDetails.HoursPerDay := 0;

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

                                        if LCurveFinishDate = TempDate then begin
                                            ApplyLCurve := false;
                                            LCurveStartTimePerDay := 0T;
                                            LcurveHoursPerday := 0;
                                        end;

                                        TempDate := TempDate + 1;

                                    until (TempQty >= Qty);

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

                                    if ApplyLCurve1 = false then
                                        JobPlaLine2Rec."Learning Curve No." := 0
                                    else
                                        JobPlaLine2Rec."Learning Curve No." := JobPlaLineRec."Learning Curve No.";

                                    JobPlaLine2Rec.eff := Eff;
                                    JobPlaLine2Rec.SMV := SMV;
                                    JobPlaLine2Rec.Carder := Carder;
                                    JobPlaLine2Rec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);
                                    JobPlaLine2Rec.FinishDateTime := CREATEDATETIME(TempDate, JobPlaLine2Rec."Finish Time");
                                    JobPlaLine2Rec.Qty := Qty;

                                    if rec."Style No." = JobPlaLine2Rec."Style No." then
                                        JobPlaLine2Rec.Target := TargetPerDay;

                                    Prev_FinishedDateTime := JobPlaLineRec.FinishDateTime;
                                    JobPlaLine2Rec.Modify();

                                    TempTIme := JobPlaLine2Rec."Finish Time";
                                    ApplyLCurve1 := false;

                                    //delete allocation if remaining qty is 0 or less than 0
                                    JobPlaLine2Rec.Reset();
                                    JobPlaLine2Rec.SetRange("Line No.", LineNo);
                                    if JobPlaLine2Rec.FindSet() then begin
                                        if JobPlaLine2Rec.Qty <= 0 then
                                            JobPlaLine2Rec.DeleteAll();
                                    end;
                                end;

                                StartTime2 := JobPlaLine2Rec."Start Time";
                                LineNo := JobPlaLineRec."Line No.";
                            end;
                        end;
                    end;
                    Message('Completed');
                end;
            }
        }
    }

    procedure Cal();
    var
    begin
        if rec.SMV <> 0 then begin
            // rec.Target := round(((60 / rec.SMV) * rec.Carder * rec.HoursPerDay * rec.Eff) / 100, 1, '>')
            HourlyTarget := round(((60 / rec.SMV) * rec.Carder * rec.Eff) / 100, 1);
            rec.Target := round(HourlyTarget * rec.HoursPerDay, 1);
        end
        else
            Message('SMV is zero. Cannot continue.');

        // if rec.HoursPerDay > 0 then
        //     HourlyTarget := rec.Target / rec.HoursPerDay
        // else
        //     HourlyTarget := 0;
    end;


    trigger OnAfterGetCurrRecord()
    var
        StyeMastePORec: Record "Style Master PO";
        StyeMasteRec: Record "Style Master";
        NavAppSetupRec: Record "NavApp Setup";
        UserSetupRec: Record "User Setup";
    begin

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if not UserSetupRec.FindSet() then
            Error('Cannot find user setup details')
        else begin
            if UserSetupRec.UserRole = 'PLANNING USER' then
                PlanningUser := true
            else
                PlanningUser := false;
        end;

        NavAppSetupRec.Reset();
        NavAppSetupRec.FindSet();

        rec.HoursPerDay := 10;
        // rec.Target := round(((60 / rec.SMV) * rec.Carder * rec.HoursPerDay * rec.Eff) / 100, 1, '>');
        HourlyTarget := round(((60 / rec.SMV) * rec.Carder * rec.Eff) / 100, 1);
        rec.Target := round(HourlyTarget * rec.HoursPerDay, 1);

        StyeMasteRec.Reset();
        StyeMasteRec.SetRange("No.", rec."Style No.");
        if StyeMasteRec.FindSet() then
            Buyer := StyeMasteRec."Buyer Name"
        else
            Buyer := '';

        StyeMastePORec.Reset();
        StyeMastePORec.SetRange("Style No.", rec."Style No.");
        StyeMastePORec.SetRange("PO No.", rec."PO No.");
        if StyeMastePORec.FindSet() then begin
            OrderQty := StyeMastePORec.Qty;
            BPCD := StyeMastePORec.BPCD;
            ShipDate := StyeMastePORec."Ship Date";
            rec."TGTSEWFIN Date" := ShipDate - NavAppSetupRec."Sewing Finished"
        end
        else begin
            BPCD := 0D;
            OrderQty := 0;
            ShipDate := 0D;
        end;
    end;


    var
        OrderQty: BigInteger;
        Buyer: Text[500];
        HourlyTarget: Decimal;
        BPCD: Date;
        ShipDate: Date;
        PlanningUser: Boolean;
}