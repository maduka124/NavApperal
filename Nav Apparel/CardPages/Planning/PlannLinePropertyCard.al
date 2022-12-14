page 50343 "Planning Line Property Card"
{
    PageType = Card;
    Caption = 'Planning Line Property';
    SourceTable = "NavApp Planning Lines";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(Properties)
            {
                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                    Editable = false;
                }

                field("Lot No."; "Lot No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Lot No';
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'PO No';
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(SMV; SMV)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(HoursPerDay; HoursPerDay)
                {
                    ApplicationArea = All;
                    Caption = 'Hours Per Day';
                    Editable = false;

                    trigger OnValidate()
                    var

                    begin
                        Cal();
                    end;
                }

                field(Carder; Carder)
                {
                    ApplicationArea = All;
                    Caption = 'Man/Machine Req.';

                    trigger OnValidate()
                    var

                    begin
                        Cal();
                    end;
                }

                field(Eff; Eff)
                {
                    ApplicationArea = All;
                    Caption = 'Plan Efficiency (%)';

                    trigger OnValidate()
                    var

                    begin
                        Cal();
                    end;
                }

                field("Learning Curve No."; "Learning Curve No.")
                {
                    ApplicationArea = All;
                    Caption = 'Learning Curve';
                }

                field(Target; Target)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if (Carder = 0) or (HoursPerDay = 0) then begin
                            Message('Carder or HoursPerDay is zero. Cannot continue.');
                        end
                        else
                            Eff := (Target * 100 * SMV) / (60 * Carder * HoursPerDay);
                    end;
                }

                field("TGTSEWFIN Date"; "TGTSEWFIN Date")
                {
                    ApplicationArea = All;
                    Caption = 'Req. Saw. Finish Date';
                    Editable = false;
                }
            }

            part("Property Picture FactBox  Plan"; "Property Picture FactBox Plan")
            {
                ApplicationArea = All;
                SubPageLink = "Line No." = FIELD("Line No.");
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
                    NavAppSetupRec: Record "NavApp Setup";
                    LearningCurveRec: Record "Learning Curve";
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

                begin

                    NavAppSetupRec.Reset();
                    NavAppSetupRec.FindSet();
                    HrsPerDay := 0;
                    dtStart := WorkDate();
                    TImeStart := NavAppSetupRec."Start Time";

                    //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                    repeat

                        ResCapacityEntryRec.Reset();
                        ResCapacityEntryRec.SETRANGE("No.", "Resource No.");
                        ResCapacityEntryRec.SETRANGE(Date, dtStart);

                        if ResCapacityEntryRec.FindSet() then begin
                            repeat
                                HrsPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                            until ResCapacityEntryRec.Next() = 0;
                        end;

                        if HrsPerDay = 0 then
                            dtStart := dtStart + 1;

                    until HrsPerDay > 0;


                    //Get all allocations after the current date                                   
                    JobPlaLineRec.Reset();
                    JobPlaLineRec.SetRange("Resource No.", "Resource No.");
                    JobPlaLineRec.SetFilter("StartDateTime", '>=%1', CreateDateTime(dtStart, TImeStart));
                    JobPlaLineRec.SetCurrentKey(StartDateTime);
                    JobPlaLineRec.Ascending(true);

                    if JobPlaLineRec.FindSet() then begin

                        dtStart := JobPlaLineRec."Start Date";
                        TImeStart := JobPlaLineRec."Start Time";

                        repeat

                            HrsPerDay := 0;
                            TempQty := 0;

                            //Get working hours for the start date. If start date is a holiday, shift start date to next date.
                            repeat

                                ResCapacityEntryRec.Reset();
                                ResCapacityEntryRec.SETRANGE("No.", "Resource No.");
                                ResCapacityEntryRec.SETRANGE(Date, dtStart);

                                if ResCapacityEntryRec.FindSet() then begin
                                    repeat
                                        HrsPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                    until ResCapacityEntryRec.Next() = 0;
                                end;

                                if HrsPerDay = 0 then
                                    dtStart := dtStart + 1;

                            until HrsPerDay > 0;


                            if JobPlaLineRec."Style No." = "Style No." then
                                TargetPerDay := round(((60 / SMV) * Carder * HrsPerDay * Eff) / 100, 1)
                            else
                                TargetPerDay := round(((60 / JobPlaLineRec.SMV) * JobPlaLineRec.Carder * HrsPerDay * JobPlaLineRec.Eff) / 100, 1);


                            TargetPerHour := round(TargetPerDay / HrsPerDay, 1);
                            TempDate := dtStart;

                            //if production updated, learning curve shoube incremented
                            if JobPlaLineRec.ProdUpdDays > 0 then
                                i := JobPlaLineRec.ProdUpdDays + 1
                            else
                                i := 0;


                            repeat

                                //Get working hours for the day
                                HrsPerDay := 0;
                                Rate := 0;

                                repeat

                                    ResCapacityEntryRec.Reset();
                                    ResCapacityEntryRec.SETRANGE("No.", "Resource No.");
                                    ResCapacityEntryRec.SETRANGE(Date, TempDate);

                                    if ResCapacityEntryRec.FindSet() then begin
                                        repeat
                                            HrsPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
                                        until ResCapacityEntryRec.Next() = 0;
                                    end;

                                    if HrsPerDay = 0 then
                                        TempDate := TempDate + 1;

                                until HrsPerDay > 0;

                                //No learning curve for holidays
                                if HrsPerDay > 0 then
                                    i += 1;

                                if (i = 1) then begin
                                    //Calculate hours for the first day (substracti hours if delay start)
                                    HrsPerDay := HrsPerDay - (TImeStart - NavAppSetupRec."Start Time") / 3600000;
                                end;

                                if "Learning Curve No." <> 0 then begin

                                    //Aplly learning curve
                                    LearningCurveRec.Reset();
                                    LearningCurveRec.SetRange("No.", "Learning Curve No.");

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

                                    if (TempQty + round((TargetPerHour * HoursPerDay) * Rate / 100, 1) < JobPlaLineRec.Qty) then begin
                                        TempQty += round((TargetPerHour * HoursPerDay) * Rate / 100, 1);
                                    end
                                    else begin
                                        TempQty1 := JobPlaLineRec.Qty - TempQty;
                                        TempQty := TempQty + TempQty1;
                                        TempHours := TempQty1 / TargetPerHour;

                                        if (TempHours IN [0.1 .. 0.99]) then
                                            TempHours := 1;

                                        TempHours := round(TempHours, 1);

                                    end;
                                end
                                else begin

                                    if (TempQty + (TargetPerHour * HrsPerDay) < JobPlaLineRec.Qty) then
                                        TempQty := TempQty + (TargetPerHour * HrsPerDay)
                                    else begin
                                        TempQty1 := JobPlaLineRec.Qty - TempQty;
                                        TempQty := TempQty + TempQty1;
                                        TempHours := TempQty1 / TargetPerHour;

                                        if (TempHours IN [0.1 .. 0.99]) then
                                            TempHours := 1;

                                        TempHours := round(TempHours, 1);
                                    end;

                                end;
                                TempDate := TempDate + 1;

                            until (TempQty >= JobPlaLineRec.Qty);

                            TempDate := TempDate - 1;

                            if TempHours = 0 then
                                TempDate := TempDate - 1;

                            if JobPlaLineRec."Style No." = "Style No." then begin

                                //Modify to the Planning line table                                
                                JobPlaLineRec.Eff := Eff;
                                JobPlaLineRec.Carder := Carder;
                                JobPlaLineRec."Learning Curve No." := "Learning Curve No.";
                                JobPlaLineRec.Target := Target;
                                JobPlaLineRec."Start Date" := dtStart;
                                JobPlaLineRec."End Date" := TempDate;
                                JobPlaLineRec."Start Time" := TImeStart;
                                JobPlaLineRec."Finish Time" := NavAppSetupRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                JobPlaLineRec."Created User" := UserId;
                                //JobPlaLineRec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);
                                JobPlaLineRec.FinishDateTime := CREATEDATETIME(TempDate, NavAppSetupRec."Start Time" + 60 * 60 * 1000 * TempHours);
                                JobPlaLineRec.Modify();

                            end
                            else begin

                                //Modify to the Planning line table                              
                                JobPlaLineRec.Target := Target;
                                JobPlaLineRec."Start Date" := dtStart;
                                JobPlaLineRec."End Date" := TempDate;
                                JobPlaLineRec."Start Time" := TImeStart;
                                JobPlaLineRec."Finish Time" := NavAppSetupRec."Start Time" + 60 * 60 * 1000 * TempHours;
                                JobPlaLineRec."Created User" := UserId;
                                //JobPlaLineRec.StartDateTime := CREATEDATETIME(dtStart, TImeStart);
                                JobPlaLineRec.FinishDateTime := CREATEDATETIME(TempDate, NavAppSetupRec."Start Time" + 60 * 60 * 1000 * TempHours);
                                JobPlaLineRec.Modify();

                            end;


                            dtStart := TempDate;
                            TImeStart := NavAppSetupRec."Start Time" + 60 * 60 * 1000 * TempHours;

                        until JobPlaLineRec.Next() = 0;

                        //Update StartDateTime of all records greater than Todays date
                        JobPlaLineRec.Reset();
                        JobPlaLineRec.SetRange("Resource No.", "Resource No.");
                        JobPlaLineRec.SetFilter("Start Date", '>=%1', Today());
                        JobPlaLineRec.FindSet();

                        repeat
                            JobPlaLineRec.StartDateTime := CREATEDATETIME(JobPlaLineRec."Start Date", JobPlaLineRec."Start Time");
                            JobPlaLineRec.Modify();
                        until JobPlaLineRec.Next() = 0;

                    end;
                end;
            }
        }
    }

    procedure Cal();
    var
    begin

        if SMV <> 0 then begin
            Target := round(((60 / SMV) * Carder * HoursPerDay * Eff) / 100, 1);
        end
        else
            Message('SMV is zero. Cannot continue.');

    end;

}