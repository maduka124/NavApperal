codeunit 51162 CodeUnitJobQueue
{
    procedure Proc1()
    var
        NavProdPlanRec: Record "NavApp Prod Plans Details";
        NavPlaningRec: Record "NavApp Planning Lines";
        PlanEffDashRec: Record PlanEffDashboardReportTable;
        PlanEffDash1Rec: Record PlanEffDashboardReportTable;
        StyleMasterRec: Record "Style Master";
        locationRec: Record Location;
        WorkCenterRec: Record "Work Center";
        DayForWeek: Record Date;
        TotalHours: Decimal;
        StyleHours: Decimal;
        StyleEff: Decimal;
        LineEff: Decimal;
        FacEff: Decimal;
        Y: Integer;
        M: Integer;
        TempID: Text[500];
        // StartDate: date;
        FinishDate: date;
    begin

        FinishDate := Today + 90;

        // if (StartDate = 0D) or (FinishDate = 0D) then
        //     Error('Invalid date period');

        // if (StartDate > FinishDate) then
        //     Error('Invalid date period');


        //Style Efficiency Calculation
        NavProdPlanRec.Reset();
        // NavProdPlanRec.SetRange(PlanDate, StartDate, FinishDate);
        NavProdPlanRec.SetFilter(PlanDate, '<%1', FinishDate);
        NavProdPlanRec.SetCurrentKey("Factory No.", "Resource No.", "Style No.", PlanDate);
        NavProdPlanRec.Ascending(true);

        if NavProdPlanRec.FindSet() then begin

            evaluate(Y, copystr(Format(NavProdPlanRec.PlanDate), 7, 2));
            evaluate(M, copystr(Format(NavProdPlanRec.PlanDate), 4, 2));
            Y := 2000 + Y;
            TempID := NavProdPlanRec."Factory No." + NavProdPlanRec."Resource No." + NavProdPlanRec."Style No." + format(Y) + Format(M);

            repeat

                evaluate(Y, copystr(Format(NavProdPlanRec.PlanDate), 7, 2));
                evaluate(M, copystr(Format(NavProdPlanRec.PlanDate), 4, 2));
                Y := 2000 + Y;

                if TempID = (NavProdPlanRec."Factory No." + NavProdPlanRec."Resource No." + NavProdPlanRec."Style No." + format(Y) + Format(M)) then begin

                    //Get style details
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", NavProdPlanRec."Style No.");
                    StyleMasterRec.FindSet();

                    TotalHours += NavProdPlanRec.Carder * NavProdPlanRec.HoursPerDay;
                    StyleHours += (StyleMasterRec.SMV * NavProdPlanRec.Qty) / 60;

                    if TotalHours > 0 then
                        StyleEff := (StyleHours / TotalHours) * 100
                    else
                        StyleEff := 0;

                    //Get Factory name
                    locationRec.Reset();
                    locationRec.SetRange(Code, NavProdPlanRec."Factory No.");
                    locationRec.FindSet();

                    //Get line name
                    WorkCenterRec.Reset();
                    WorkCenterRec.SetRange("No.", NavProdPlanRec."Resource No.");
                    WorkCenterRec.FindSet();

                    //Get style details
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", NavProdPlanRec."Style No.");
                    StyleMasterRec.FindSet();

                    //check duplicates                  
                    PlanEffDashRec.Reset();
                    PlanEffDashRec.SetRange("Factory No.", NavProdPlanRec."Factory No.");
                    PlanEffDashRec.SetRange("Line No.", NavProdPlanRec."Resource No.");
                    PlanEffDashRec.SetRange("Style No.", NavProdPlanRec."Style No.");
                    PlanEffDashRec.SetRange(Year, Y);
                    PlanEffDashRec.SetRange(MonthNo, M);

                    if not PlanEffDashRec.FindSet() then begin
                        PlanEffDash1Rec.Init();
                        PlanEffDash1Rec.Year := Y;
                        PlanEffDash1Rec.MonthName := FORMAT(NavProdPlanRec.PlanDate, 0, '<Month Text>');
                        PlanEffDash1Rec.MonthNo := M;
                        PlanEffDash1Rec."Factory Name" := locationRec.Name;
                        PlanEffDash1Rec."Factory No." := NavProdPlanRec."Factory No.";
                        PlanEffDash1Rec."Style No." := NavProdPlanRec."Style No.";
                        PlanEffDash1Rec."Style Name" := StyleMasterRec."Style No.";
                        PlanEffDash1Rec."Line No." := NavProdPlanRec."Resource No.";
                        PlanEffDash1Rec."Line Name" := WorkCenterRec.Name;
                        PlanEffDash1Rec."Style Eff." := StyleEff;
                        PlanEffDash1Rec."Created Date" := WorkDate();
                        PlanEffDash1Rec."Created User" := UserId;
                        PlanEffDash1Rec.Insert();
                    end
                    else begin
                        PlanEffDashRec."Style Eff." := StyleEff;
                        PlanEffDashRec.Modify();
                    end;

                    TempID := NavProdPlanRec."Factory No." + NavProdPlanRec."Resource No." + NavProdPlanRec."Style No." + format(Y) + Format(M);
                end
                else begin

                    TotalHours := 0;
                    StyleHours := 0;
                    StyleEff := 0;

                    //Get style details
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", NavProdPlanRec."Style No.");
                    StyleMasterRec.FindSet();

                    TotalHours += NavProdPlanRec.Carder * NavProdPlanRec.HoursPerDay;
                    StyleHours += (StyleMasterRec.SMV * NavProdPlanRec.Qty) / 60;

                    if TotalHours > 0 then
                        StyleEff := (StyleHours / TotalHours) * 100
                    else
                        StyleEff := 0;

                    //Get Factory name
                    locationRec.Reset();
                    locationRec.SetRange(Code, NavProdPlanRec."Factory No.");
                    locationRec.FindSet();

                    //Get line name
                    WorkCenterRec.Reset();
                    WorkCenterRec.SetRange("No.", NavProdPlanRec."Resource No.");
                    WorkCenterRec.FindSet();

                    //Get style details
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", NavProdPlanRec."Style No.");
                    StyleMasterRec.FindSet();

                    //check duplicates                  
                    PlanEffDashRec.Reset();
                    PlanEffDashRec.SetRange("Factory No.", NavProdPlanRec."Factory No.");
                    PlanEffDashRec.SetRange("Line No.", NavProdPlanRec."Resource No.");
                    PlanEffDashRec.SetRange("Style No.", NavProdPlanRec."Style No.");
                    PlanEffDashRec.SetRange(Year, Y);
                    PlanEffDashRec.SetRange(MonthNo, M);

                    if not PlanEffDashRec.FindSet() then begin
                        PlanEffDash1Rec.Init();
                        PlanEffDash1Rec.Year := Y;
                        PlanEffDash1Rec.MonthName := FORMAT(NavProdPlanRec.PlanDate, 0, '<Month Text>');
                        PlanEffDash1Rec.MonthNo := M;
                        PlanEffDash1Rec."Factory Name" := locationRec.Name;
                        PlanEffDash1Rec."Factory No." := NavProdPlanRec."Factory No.";
                        PlanEffDash1Rec."Style No." := NavProdPlanRec."Style No.";
                        PlanEffDash1Rec."Style Name" := StyleMasterRec."Style No.";
                        PlanEffDash1Rec."Line No." := NavProdPlanRec."Resource No.";
                        PlanEffDash1Rec."Line Name" := WorkCenterRec.Name;
                        PlanEffDash1Rec."Style Eff." := StyleEff;
                        PlanEffDash1Rec."Created Date" := WorkDate();
                        PlanEffDash1Rec."Created User" := UserId;
                        PlanEffDash1Rec.Insert();
                    end
                    else begin
                        PlanEffDashRec."Style Eff." := StyleEff;
                        PlanEffDashRec.Modify();
                    end;

                    TempID := NavProdPlanRec."Factory No." + NavProdPlanRec."Resource No." + NavProdPlanRec."Style No." + format(Y) + Format(M);
                end;

            until NavProdPlanRec.Next() = 0;
        end;


        //Line Efficiency Calculation
        Y := 0;
        M := 0;
        TempID := '';
        LineEff := 0;
        StyleHours := 0;
        TotalHours := 0;

        NavProdPlanRec.Reset();
        // NavProdPlanRec.SetRange(PlanDate, StartDate, FinishDate);
        NavProdPlanRec.SetFilter(PlanDate, '<%1', FinishDate);
        NavProdPlanRec.SetCurrentKey("Factory No.", "Resource No.", PlanDate);
        NavProdPlanRec.Ascending(true);

        if NavProdPlanRec.FindSet() then begin

            evaluate(Y, copystr(Format(NavProdPlanRec.PlanDate), 7, 2));
            evaluate(M, copystr(Format(NavProdPlanRec.PlanDate), 4, 2));
            Y := 2000 + Y;
            TempID := NavProdPlanRec."Factory No." + NavProdPlanRec."Resource No." + format(Y) + Format(M);

            repeat

                evaluate(Y, copystr(Format(NavProdPlanRec.PlanDate), 7, 2));
                evaluate(M, copystr(Format(NavProdPlanRec.PlanDate), 4, 2));
                Y := 2000 + Y;

                if TempID = (NavProdPlanRec."Factory No." + NavProdPlanRec."Resource No." + format(Y) + Format(M)) then begin

                    //Get style details
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", NavProdPlanRec."Style No.");
                    StyleMasterRec.FindSet();

                    TotalHours += NavProdPlanRec.Carder * NavProdPlanRec.HoursPerDay;
                    StyleHours += (StyleMasterRec.SMV * NavProdPlanRec.Qty) / 60;

                    if TotalHours > 0 then
                        LineEff := (StyleHours / TotalHours) * 100
                    else
                        LineEff := 0;

                    //Get Factory name
                    locationRec.Reset();
                    locationRec.SetRange(Code, NavProdPlanRec."Factory No.");
                    locationRec.FindSet();

                    //Get line name
                    WorkCenterRec.Reset();
                    WorkCenterRec.SetRange("No.", NavProdPlanRec."Resource No.");
                    WorkCenterRec.FindSet();

                    //Get style details
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", NavProdPlanRec."Style No.");
                    StyleMasterRec.FindSet();

                    //check duplicates                  
                    PlanEffDashRec.Reset();
                    PlanEffDashRec.SetRange("Factory No.", NavProdPlanRec."Factory No.");
                    PlanEffDashRec.SetRange("Line No.", NavProdPlanRec."Resource No.");
                    PlanEffDashRec.SetRange(Year, Y);
                    PlanEffDashRec.SetRange(MonthNo, M);

                    if not PlanEffDashRec.FindSet() then begin
                        PlanEffDash1Rec.Init();
                        PlanEffDash1Rec.Year := Y;
                        PlanEffDash1Rec.MonthName := FORMAT(NavProdPlanRec.PlanDate, 0, '<Month Text>');
                        PlanEffDash1Rec.MonthNo := M;
                        PlanEffDash1Rec."Factory Name" := locationRec.Name;
                        PlanEffDash1Rec."Factory No." := NavProdPlanRec."Factory No.";
                        PlanEffDash1Rec."Style No." := NavProdPlanRec."Style No.";
                        PlanEffDash1Rec."Style Name" := StyleMasterRec."Style No.";
                        PlanEffDash1Rec."Line No." := NavProdPlanRec."Resource No.";
                        PlanEffDash1Rec."Line Name" := WorkCenterRec.Name;
                        PlanEffDash1Rec."Line Eff." := LineEff;
                        PlanEffDash1Rec."Created Date" := WorkDate();
                        PlanEffDash1Rec."Created User" := UserId;
                        PlanEffDash1Rec.Insert();
                    end
                    else
                        PlanEffDashRec.ModifyAll("Line Eff.", LineEff);

                    TempID := NavProdPlanRec."Factory No." + NavProdPlanRec."Resource No." + format(Y) + Format(M);
                end
                else begin

                    TotalHours := 0;
                    StyleHours := 0;
                    LineEff := 0;

                    //Get style details
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", NavProdPlanRec."Style No.");
                    StyleMasterRec.FindSet();

                    TotalHours += NavProdPlanRec.Carder * NavProdPlanRec.HoursPerDay;
                    StyleHours += (StyleMasterRec.SMV * NavProdPlanRec.Qty) / 60;

                    if TotalHours > 0 then
                        LineEff := (StyleHours / TotalHours) * 100
                    else
                        LineEff := 0;

                    //Get Factory name
                    locationRec.Reset();
                    locationRec.SetRange(Code, NavProdPlanRec."Factory No.");
                    locationRec.FindSet();

                    //Get line name
                    WorkCenterRec.Reset();
                    WorkCenterRec.SetRange("No.", NavProdPlanRec."Resource No.");
                    WorkCenterRec.FindSet();

                    //Get style details
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", NavProdPlanRec."Style No.");
                    StyleMasterRec.FindSet();

                    //check duplicates                  
                    PlanEffDashRec.Reset();
                    PlanEffDashRec.SetRange("Factory No.", NavProdPlanRec."Factory No.");
                    PlanEffDashRec.SetRange("Line No.", NavProdPlanRec."Resource No.");
                    PlanEffDashRec.SetRange(Year, Y);
                    PlanEffDashRec.SetRange(MonthNo, M);

                    if not PlanEffDashRec.FindSet() then begin
                        PlanEffDash1Rec.Init();
                        PlanEffDash1Rec.Year := Y;
                        PlanEffDash1Rec.MonthName := FORMAT(NavProdPlanRec.PlanDate, 0, '<Month Text>');
                        PlanEffDash1Rec.MonthNo := M;
                        PlanEffDash1Rec."Factory Name" := locationRec.Name;
                        PlanEffDash1Rec."Factory No." := NavProdPlanRec."Factory No.";
                        PlanEffDash1Rec."Style No." := NavProdPlanRec."Style No.";
                        PlanEffDash1Rec."Style Name" := StyleMasterRec."Style No.";
                        PlanEffDash1Rec."Line No." := NavProdPlanRec."Resource No.";
                        PlanEffDash1Rec."Line Name" := WorkCenterRec.Name;
                        PlanEffDash1Rec."Line Eff." := LineEff;
                        PlanEffDash1Rec."Created Date" := WorkDate();
                        PlanEffDash1Rec."Created User" := UserId;
                        PlanEffDash1Rec.Insert();
                    end
                    else
                        PlanEffDashRec.ModifyAll("Line Eff.", LineEff);

                    TempID := NavProdPlanRec."Factory No." + NavProdPlanRec."Resource No." + format(Y) + Format(M);
                end;

            until NavProdPlanRec.Next() = 0;
        end;


        //Factory Efficiency Calculation
        Y := 0;
        M := 0;
        TempID := '';
        FacEff := 0;
        StyleHours := 0;
        TotalHours := 0;

        NavProdPlanRec.Reset();
        // NavProdPlanRec.SetRange(PlanDate, StartDate, FinishDate);
        NavProdPlanRec.SetFilter(PlanDate, '<%1', FinishDate);
        NavProdPlanRec.SetCurrentKey("Factory No.", PlanDate);
        NavProdPlanRec.Ascending(true);

        if NavProdPlanRec.FindSet() then begin

            evaluate(Y, copystr(Format(NavProdPlanRec.PlanDate), 7, 2));
            evaluate(M, copystr(Format(NavProdPlanRec.PlanDate), 4, 2));
            Y := 2000 + Y;
            TempID := NavProdPlanRec."Factory No." + format(Y) + Format(M);

            repeat

                evaluate(Y, copystr(Format(NavProdPlanRec.PlanDate), 7, 2));
                evaluate(M, copystr(Format(NavProdPlanRec.PlanDate), 4, 2));
                Y := 2000 + Y;

                if TempID = (NavProdPlanRec."Factory No." + format(Y) + Format(M)) then begin

                    //Get style details
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", NavProdPlanRec."Style No.");
                    StyleMasterRec.FindSet();

                    TotalHours += NavProdPlanRec.Carder * NavProdPlanRec.HoursPerDay;
                    StyleHours += (StyleMasterRec.SMV * NavProdPlanRec.Qty) / 60;

                    if TotalHours > 0 then
                        FacEff := (StyleHours / TotalHours) * 100
                    else
                        FacEff := 0;

                    //Get Factory name
                    locationRec.Reset();
                    locationRec.SetRange(Code, NavProdPlanRec."Factory No.");
                    locationRec.FindSet();

                    //Get line name
                    WorkCenterRec.Reset();
                    WorkCenterRec.SetRange("No.", NavProdPlanRec."Resource No.");
                    WorkCenterRec.FindSet();

                    //Get style details
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", NavProdPlanRec."Style No.");
                    StyleMasterRec.FindSet();

                    //check duplicates                  
                    PlanEffDashRec.Reset();
                    PlanEffDashRec.SetRange("Factory No.", NavProdPlanRec."Factory No.");
                    PlanEffDashRec.SetRange(Year, Y);
                    PlanEffDashRec.SetRange(MonthNo, M);

                    if not PlanEffDashRec.FindSet() then begin
                        PlanEffDash1Rec.Init();
                        PlanEffDash1Rec.Year := Y;
                        PlanEffDash1Rec.MonthName := FORMAT(NavProdPlanRec.PlanDate, 0, '<Month Text>');
                        PlanEffDash1Rec.MonthNo := M;
                        PlanEffDash1Rec."Factory Name" := locationRec.Name;
                        PlanEffDash1Rec."Factory No." := NavProdPlanRec."Factory No.";
                        PlanEffDash1Rec."Style No." := NavProdPlanRec."Style No.";
                        PlanEffDash1Rec."Style Name" := StyleMasterRec."Style No.";
                        PlanEffDash1Rec."Line No." := NavProdPlanRec."Resource No.";
                        PlanEffDash1Rec."Line Name" := WorkCenterRec.Name;
                        PlanEffDash1Rec."Factory Eff." := FacEff;
                        PlanEffDash1Rec."Created Date" := WorkDate();
                        PlanEffDash1Rec."Created User" := UserId;
                        PlanEffDash1Rec.Insert();
                    end
                    else
                        PlanEffDashRec.ModifyAll("Factory Eff.", FacEff);

                    TempID := NavProdPlanRec."Factory No." + format(Y) + Format(M);
                end
                else begin

                    TotalHours := 0;
                    StyleHours := 0;
                    FacEff := 0;

                    //Get style details
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", NavProdPlanRec."Style No.");
                    StyleMasterRec.FindSet();

                    TotalHours += NavProdPlanRec.Carder * NavProdPlanRec.HoursPerDay;
                    StyleHours += (StyleMasterRec.SMV * NavProdPlanRec.Qty) / 60;

                    if TotalHours > 0 then
                        FacEff := (StyleHours / TotalHours) * 100
                    else
                        FacEff := 0;

                    //Get Factory name
                    locationRec.Reset();
                    locationRec.SetRange(Code, NavProdPlanRec."Factory No.");
                    locationRec.FindSet();

                    //Get line name
                    WorkCenterRec.Reset();
                    WorkCenterRec.SetRange("No.", NavProdPlanRec."Resource No.");
                    WorkCenterRec.FindSet();

                    //Get style details
                    StyleMasterRec.Reset();
                    StyleMasterRec.SetRange("No.", NavProdPlanRec."Style No.");
                    StyleMasterRec.FindSet();

                    //check duplicates                  
                    PlanEffDashRec.Reset();
                    PlanEffDashRec.SetRange("Factory No.", NavProdPlanRec."Factory No.");
                    PlanEffDashRec.SetRange(Year, Y);
                    PlanEffDashRec.SetRange(MonthNo, M);

                    if not PlanEffDashRec.FindSet() then begin
                        PlanEffDash1Rec.Init();
                        PlanEffDash1Rec.Year := Y;
                        PlanEffDash1Rec.MonthName := FORMAT(NavProdPlanRec.PlanDate, 0, '<Month Text>');
                        PlanEffDash1Rec.MonthNo := M;
                        PlanEffDash1Rec."Factory Name" := locationRec.Name;
                        PlanEffDash1Rec."Factory No." := NavProdPlanRec."Factory No.";
                        PlanEffDash1Rec."Style No." := NavProdPlanRec."Style No.";
                        PlanEffDash1Rec."Style Name" := StyleMasterRec."Style No.";
                        PlanEffDash1Rec."Line No." := NavProdPlanRec."Resource No.";
                        PlanEffDash1Rec."Line Name" := WorkCenterRec.Name;
                        PlanEffDash1Rec."Factory Eff." := FacEff;
                        PlanEffDash1Rec."Created Date" := WorkDate();
                        PlanEffDash1Rec."Created User" := UserId;
                        PlanEffDash1Rec.Insert();
                    end
                    else
                        PlanEffDashRec.ModifyAll("Factory Eff.", FacEff);

                    TempID := NavProdPlanRec."Factory No." + format(Y) + Format(M);
                end;

            until NavProdPlanRec.Next() = 0;
        end;

    end;

    trigger OnRun()
    var
    begin
        Proc1();
    end;

}
