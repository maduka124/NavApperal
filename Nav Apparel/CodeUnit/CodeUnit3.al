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

}
