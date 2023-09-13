codeunit 51366 NavAppCodeUnit3
{
    procedure Get_FacFinishTime(LineNoPara: code[20]; DayPara: date; StartTimePara: time): time
    var
        ResCapacityEntryRec: Record "Calendar Entry";
        HoursPerDay: Decimal;
        FinishTime: time;
    begin
        HoursPerDay := 0;
        ResCapacityEntryRec.Reset();
        ResCapacityEntryRec.SETRANGE("No.", LineNoPara);
        ResCapacityEntryRec.SETRANGE(Date, DayPara);
        if ResCapacityEntryRec.FindSet() then begin
            repeat
                HoursPerDay += (ResCapacityEntryRec."Capacity (Total)") / ResCapacityEntryRec.Capacity;
            until ResCapacityEntryRec.Next() = 0;
        end;
        FinishTime := StartTimePara + (60 * 60 * 1000 * HoursPerDay);

        exit(FinishTime);
    end;


    procedure Get_POStatus(StylePara: code[20]; LOtNoPara: code[20]): Boolean
    var
        StyleMasPoRec: Record "Style Master PO";
        Status: Boolean;
    begin
        StyleMasPoRec.Reset();
        StyleMasPoRec.SETRANGE("Style No.", StylePara);
        StyleMasPoRec.SETRANGE("Lot No.", LOtNoPara);
        StyleMasPoRec.SetFilter(Status, '=%1', StyleMasPoRec.Status::Cancel);
        if StyleMasPoRec.FindSet() then
            Status := true
        else
            Status := false;

        exit(Status);
    end;


    procedure CheckforHolidays(DatePara: Date; LineNoPara: code[20]): Boolean
    var
        WorkCenterRec: Record "Work Center";
        SHCalHolidayRec: Record "Shop Calendar Holiday";
        WorkCenCapacityEntryRec: Record "Calendar Entry";
        Status: Boolean;
        HoursPerDay: Decimal;
    begin
        Status := false;
        HoursPerDay := 0;

        if (DatePara <> 0D) and (LineNoPara <> '') then begin

            WorkCenCapacityEntryRec.Reset();
            WorkCenCapacityEntryRec.SETRANGE("No.", LineNoPara);
            WorkCenCapacityEntryRec.SETRANGE(Date, DatePara);
            if WorkCenCapacityEntryRec.FindSet() then begin
                repeat
                    HoursPerDay += (WorkCenCapacityEntryRec."Capacity (Total)") / WorkCenCapacityEntryRec.Capacity;
                until WorkCenCapacityEntryRec.Next() = 0;
            end;

            if HoursPerDay = 0 then
                Status := true
            else
                Status := false;

            // WorkCenterRec.Reset();
            // WorkCenterRec.SetRange("No.", LineNoPara);
            // WorkCenterRec.FindSet();

            // //Validate the day (Holiday)
            // SHCalHolidayRec.Reset();
            // SHCalHolidayRec.SETRANGE("Shop Calendar Code", WorkCenterRec."Shop Calendar Code");
            // SHCalHolidayRec.SETRANGE(Date, DatePara);
            // if SHCalHolidayRec.FindSet() then
            //     Status := true
            // else
            //     Status := false;
        end;

        exit(Status);
    end;
}
