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

}
