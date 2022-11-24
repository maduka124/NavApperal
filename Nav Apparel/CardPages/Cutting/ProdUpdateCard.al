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
        ProdOutHeaderRec: Record ProductionOutHeader;
        StyleMasterPORec: Record "Style Master PO";
        LocationRec: Record Location;

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
        dtSt: Date;
        dtEd: Date;
        Count: Integer;
    begin

        //Get Start and Finish Time
        LocationRec.Reset();
        LocationRec.SetRange(code, FactoryNo);
        LocationRec.FindSet();

        //Get all work center line details
        WorkCenterRec.Reset();
        WorkCenterRec.SetFilter("Planning Line", '=%1', true);
        if WorkCenterRec.FindSet() then begin

            repeat

                ProdOutHeaderRec.Reset();
                ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
                ProdOutHeaderRec.SetFilter("Prod Date", '=%1', ProdDate);
                ProdOutHeaderRec.SetRange("Resource No.", WorkCenterRec."No.");
                if ProdOutHeaderRec.FindSet() then
                    repeat
                        if ProdOutHeaderRec."Prod Updated" = 1 then
                            Error('Production already updated for : %1 and Line : %2', ProdDate, WorkCenterRec.Name);
                    until ProdOutHeaderRec.Next() = 0;


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

                //Get existing all planning lines for the work center line
                JobPlaLineRec.Reset();
                JobPlaLineRec.SetCurrentKey("Start Date");
                JobPlaLineRec.Ascending(true);
                JobPlaLineRec.SetRange("Resource No.", WorkCenterNo);
                JobPlaLineRec.SetFilter("Start Date", '=%1', ProdDate);

                if JobPlaLineRec.FindSet() then begin

                    if JobPlaLineRec.Carder <> 0 then
                        Carder := JobPlaLineRec.Carder;

                    if JobPlaLineRec.Eff <> 0 then
                        Eff := JobPlaLineRec.Eff;

                    SMV := JobPlaLineRec.SMV;
                    LineNo := JobPlaLineRec."Line No.";

                    TargetPerDay := round(((60 / SMV) * Carder * HoursPerDay * Eff) / 100, 1);
                    TargetPerHour := round(TargetPerDay / HoursPerDay, 1);
                    TempDate := dtStart;

                    //Get sewing out qty for the prod date
                    ProdOutHeaderRec.Reset();
                    ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Saw);
                    ProdOutHeaderRec.SetFilter("Prod Date", '=%1', ProdDate);
                    ProdOutHeaderRec.SetRange("Resource No.", WorkCenterNo);

                    if ProdOutHeaderRec.FindSet() then begin

                        OutputQty := ProdOutHeaderRec."Output Qty";

                        //Update production status for the selected date
                        ProdPlansDetails.Reset();
                        ProdPlansDetails.SetRange("Line No.", LineNo);
                        ProdPlansDetails.SetRange("Resource No.", WorkCenterNo);
                        ProdPlansDetails.SetRange(PlanDate, ProdDate);
                        ProdPlansDetails.FindSet();
                        ProdPlansDetails.ProdUpd := 1;
                        ProdPlansDetails.ProdUpdQty := OutputQty;
                        ProdPlansDetails.Modify();


                        //Delete Old lines which are not updated as production completed
                        ProdPlansDetails.Reset();
                        ProdPlansDetails.SetRange("Line No.", LineNo);
                        ProdPlansDetails.SetFilter(ProdUpd, '<>%1', 1);
                        ProdPlansDetails.DeleteAll();

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

                            if i = 1 then
                                ProdPlansDetails."Start Time" := TImeStart
                            else
                                ProdPlansDetails."Start Time" := LocationRec."Start Time";

                            if TempHours = 0 then
                                ProdPlansDetails."Finish Time" := LocationRec."Finish Time"
                            else
                                ProdPlansDetails."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;

                            ProdPlansDetails.Qty := xQty;
                            ProdPlansDetails.Target := TargetPerDay;
                            ProdPlansDetails.HoursPerDay := HoursPerDay;
                            ProdPlansDetails.ProdUpd := 0;
                            ProdPlansDetails.ProdUpdQty := 0;
                            ProdPlansDetails."Created User" := UserId;
                            ProdPlansDetails."Created Date" := WorkDate();
                            ProdPlansDetails."Factory No." := JobPlaLineRec.Factory;
                            ProdPlansDetails.Insert();

                            TempDate := TempDate + 1;

                        until (TempQty >= (JobPlaLineRec.Qty - OutputQty));

                        TempDate := TempDate - 1;

                        if TempHours = 0 then
                            TempDate := TempDate - 1;

                        //modify Planning line                                 
                        JobPlaLineRec."Start Date" := dtStart;
                        JobPlaLineRec."End Date" := TempDate;
                        JobPlaLineRec."Start Time" := TImeStart;

                        if TempHours = 0 then
                            JobPlaLineRec."Finish Time" := LocationRec."Finish Time"
                        else
                            JobPlaLineRec."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;

                        JobPlaLineRec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);
                        JobPlaLineRec.FinishDateTime := CREATEDATETIME(TempDate, LocationRec."Start Time" + 60 * 60 * 1000 * TempHours);
                        JobPlaLineRec.ProdUpdDays := JobPlaLineRec.ProdUpdDays + 1;
                        JobPlaLineRec.Qty := JobPlaLineRec.Qty - OutputQty;
                        JobPlaLineRec.Modify();
                        //IsInserted := true;


                        //Update StyleMsterPO table
                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", JobPlaLineRec."Style No.");
                        StyleMasterPORec.SetRange("lot No.", JobPlaLineRec."lot No.");
                        StyleMasterPORec.FindSet();
                        StyleMasterPORec.PlannedQty := StyleMasterPORec.PlannedQty - OutputQty;
                        StyleMasterPORec.OutputQty := StyleMasterPORec.OutputQty + OutputQty;
                        StyleMasterPORec.Modify();


                        //delete allocation if remaining qty is 0 or less than 0
                        JobPlaLineRec.Reset();
                        JobPlaLineRec.SetRange("Line No.", LineNo);

                        if JobPlaLineRec.FindSet() then begin
                            if JobPlaLineRec.Qty <= 0 then
                                JobPlaLineRec.DeleteAll();
                        end;


                        //Check whether new allocation conflicts other allocation                     
                        JobPlaLineRec.Reset();
                        JobPlaLineRec.SetRange("Resource No.", WorkCenterNo);
                        JobPlaLineRec.SetRange("StartDateTime", CreateDateTime(dtStart, TImeStart), CreateDateTime(TempDate, LocationRec."Start Time" + 60 * 60 * 1000 * TempHours));
                        JobPlaLineRec.SetCurrentKey(StartDateTime);
                        JobPlaLineRec.SetAscending(StartDateTime, false);
                        JobPlaLineRec.SetFilter("Line No.", '<>%1', LineNo);

                        if JobPlaLineRec.FindSet() then begin

                            Found := false;
                            HoursPerDay := 0;
                            i := 0;
                            TempQty := 0;
                            dtStart := TempDate;
                            TImeStart := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                            LineNo := JobPlaLineRec."Line No.";
                            Qty := JobPlaLineRec.Qty;


                            //repeat for all the items, until no items 
                            repeat

                                HoursPerDay := 0;
                                //if start time greater than parameter Finish time, set start time next day morning
                                if ((TImeStart - LocationRec."Finish Time") >= 0) then begin
                                    TImeStart := LocationRec."Start Time";
                                    dtStart := dtStart + 1;
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

                                TempQty := 0;

                                //Delete old lines
                                ProdPlansDetails.Reset();
                                ProdPlansDetails.SetRange("Line No.", LineNo);
                                ProdPlansDetails.DeleteAll();

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

                                        if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < Qty) then begin
                                            TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                            xQty := round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                        end
                                        else begin
                                            TempQty1 := Qty - TempQty;
                                            TempQty := TempQty + TempQty1;
                                            TempHours := TempQty1 / TargetPerHour;
                                            xQty := TempQty1;

                                            if (TempHours IN [0.0001 .. 0.99]) then
                                                TempHours := 1;

                                            TempHours := round(TempHours, 1);

                                        end;
                                    end
                                    else begin

                                        if (TempQty + (TargetPerHour * HoursPerDay)) < Qty then begin
                                            TempQty += (TargetPerHour * HoursPerDay);
                                            xQty := TargetPerHour * HoursPerDay;
                                        end
                                        else begin
                                            TempQty1 := Qty - TempQty;
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
                                    if i = 1 then
                                        ProdPlansDetails."Start Time" := TImeStart
                                    else
                                        ProdPlansDetails."Start Time" := LocationRec."Start Time";

                                    if TempHours = 0 then
                                        ProdPlansDetails."Finish Time" := LocationRec."Finish Time"
                                    else
                                        ProdPlansDetails."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                    ProdPlansDetails.Qty := xQty;
                                    ProdPlansDetails.Target := TargetPerDay;
                                    ProdPlansDetails.HoursPerDay := HoursPerDay;
                                    ProdPlansDetails.ProdUpd := 0;
                                    ProdPlansDetails.ProdUpdQty := 0;
                                    ProdPlansDetails."Created User" := UserId;
                                    ProdPlansDetails."Created Date" := WorkDate();
                                    ProdPlansDetails."Factory No." := JobPlaLineRec.Factory;
                                    ProdPlansDetails.Insert();


                                    TempDate := TempDate + 1;

                                until (TempQty >= Qty);

                                TempDate := TempDate - 1;

                                if TempHours = 0 then
                                    TempDate := TempDate - 1;


                                //modift the line
                                JobPlaLineRec.Reset();
                                JobPlaLineRec.SetRange("Line No.", LineNo);
                                JobPlaLineRec."Start Date" := dtStart;
                                JobPlaLineRec."End Date" := TempDate;
                                JobPlaLineRec."Start Time" := TImeStart;
                                if TempHours = 0 then
                                    JobPlaLineRec."Finish Time" := LocationRec."Finish Time"
                                else
                                    JobPlaLineRec."Finish Time" := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                JobPlaLineRec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);
                                JobPlaLineRec.FinishDateTime := CREATEDATETIME(TempDate, LocationRec."Start Time" + 60 * 60 * 1000 * TempHours);
                                JobPlaLineRec.Modify();


                                //Check whether new allocation conflicts other allocation                     
                                JobPlaLineRec.Reset();
                                JobPlaLineRec.SetRange("Resource No.", WorkCenterNo);
                                JobPlaLineRec.SetRange("StartDateTime", CreateDateTime(dtStart, TImeStart), CreateDateTime(TempDate, LocationRec."Start Time" + 60 * 60 * 1000 * TempHours));
                                JobPlaLineRec.SetCurrentKey(StartDateTime);
                                JobPlaLineRec.SetAscending(StartDateTime, false);
                                JobPlaLineRec.SetFilter("Line No.", '<>%1', LineNo);

                                if JobPlaLineRec.FindSet() then begin
                                    Found := true;
                                    dtStart := TempDate;
                                    TImeStart := LocationRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                    LineNo := JobPlaLineRec."Line No.";
                                    Qty := JobPlaLineRec.Qty;
                                end
                                else
                                    Found := false;

                            until (not Found);

                        end;

                        ProdOutHeaderRec."Prod Updated" := 1;
                        ProdOutHeaderRec.Modify();
                        status := 1;
                    end;
                end;

            until WorkCenterRec.Next() = 0;

            if status = 1 then
                Message('Production updated')
            else
                Message('Production not updated')
        end
        else
            Error('Cannot find work center details.');
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