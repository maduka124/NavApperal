page 51349 CapacityDashboardCard
{
    PageType = Card;
    SourceTable = CapacityDashboardHeader;
    Caption = 'Capacity Dashboard (Group/Factory Wise/Line Wise)';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            group("Filter By")
            {
                field(No; rec.No)
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field(Year; rec.Year)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;
                    end;
                }

                field("Month Name"; rec."Month Name")
                {
                    ApplicationArea = all;
                    Caption = 'Month';
                }

                // field(Factory; rec.Factory)
                // {
                //     ApplicationArea = all;
                // }
            }

            group("Group Capacity")
            {
                part(GroupWiseCapacityListpart; GroupWiseCapacityListpart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = Year = field(Year);
                }
            }

            group("Factory Capacity")
            {
                part(FactoryWiseCapacityListpart; FactoryWiseCapacityListpart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = Year = field(Year), Month = field("Month Name");
                }
            }

            group("Line Capacity")
            {
                part(LineWiseCapacityListpart; LineWiseCapacityListpart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = Year = field(Year), Month = field("Month Name");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Refresh Data")
            {
                ApplicationArea = All;
                Image = RefreshRegister;

                trigger OnAction();
                var
                    LocationRec: Record Location;
                    WorkCenterRec: Record "Work Center";
                    LineWiseCapacityRec: Record LineWiseCapacity;
                    GroupWiseCapacityRec: Record GroupWiseCapacity;
                    FactoryWiseCapacityRec: Record FactoryWiseCapacity;
                    SalesShipmentHeaderRec: Record "Sales Shipment Header";
                    SalesShipmentLineRec: Record "Sales Shipment Line";
                    Mon: Integer;
                    Name: Text[20];
                    StartDate1: Date;
                    FinishDate1: Date;
                begin
                    if rec.Year >= 2023 then begin

                        //Delete old data
                        FactoryWiseCapacityRec.Reset();
                        if FactoryWiseCapacityRec.FindSet() then
                            FactoryWiseCapacityRec.DeleteAll();

                        GroupWiseCapacityRec.Reset();
                        if GroupWiseCapacityRec.FindSet() then
                            GroupWiseCapacityRec.DeleteAll();

                        LineWiseCapacityRec.Reset();
                        if LineWiseCapacityRec.FindSet() then
                            LineWiseCapacityRec.DeleteAll();

                        ////////////////////////////////////
                        GroupMax := 0;
                        FacMax := 0;
                        LineMax := 0;

                        for Mon := 1 to 12 do begin
                            case Mon of
                                1:
                                    Name := 'January';
                                2:
                                    Name := 'February';
                                3:
                                    Name := 'March';
                                4:
                                    Name := 'April';
                                5:
                                    Name := 'May';
                                6:
                                    Name := 'June';
                                7:
                                    Name := 'July';
                                8:
                                    Name := 'August';
                                9:
                                    Name := 'September';
                                10:
                                    Name := 'October';
                                11:
                                    Name := 'November';
                                12:
                                    Name := 'December';
                            end;

                            Capacity_Pcs := 0;
                            Planned_Pcs := 0;
                            Achieved_Pcs := 0;
                            Avg_Prod_Mnts := 0;
                            Avg_SMV := 0;
                            Finishing_Pcs := 0;
                            Available_Mnts := 0;
                            Avg_Plan_Mnts := 0;
                            Ship_Pcs := 0;
                            Ship_Value := 0;
                            Capacity_Pcs1Tot := 0;
                            Planned_Pcs1Tot := 0;
                            Achieved_Pcs1Tot := 0;
                            Avg_SMV1Tot := 0;
                            Avg_SMVTemp1Tot := 0;
                            Plan_Eff1Tot := 0;
                            Available_Mnts1Tot := 0;
                            Avg_Plan_Mnts1Tot := 0;
                            GroupMax += 1;

                            //////Cal ship Pcs (group level only)
                            StartDate1 := DMY2DATE(1, Mon, rec.Year);
                            case Mon of
                                1:
                                    FinishDate1 := DMY2DATE(31, Mon, rec.Year);
                                2:
                                    begin
                                        if rec.Year mod 4 = 0 then
                                            FinishDate1 := DMY2DATE(29, Mon, rec.Year)
                                        else
                                            FinishDate1 := DMY2DATE(28, Mon, rec.Year);
                                    end;
                                3:
                                    FinishDate1 := DMY2DATE(31, Mon, rec.Year);
                                4:
                                    FinishDate1 := DMY2DATE(30, Mon, rec.Year);
                                5:
                                    FinishDate1 := DMY2DATE(31, Mon, rec.Year);
                                6:
                                    FinishDate1 := DMY2DATE(30, Mon, rec.Year);
                                7:
                                    FinishDate1 := DMY2DATE(31, Mon, rec.Year);
                                8:
                                    FinishDate1 := DMY2DATE(31, Mon, rec.Year);
                                9:
                                    FinishDate1 := DMY2DATE(30, Mon, rec.Year);
                                10:
                                    FinishDate1 := DMY2DATE(31, Mon, rec.Year);
                                11:
                                    FinishDate1 := DMY2DATE(30, Mon, rec.Year);
                                12:
                                    FinishDate1 := DMY2DATE(31, Mon, rec.Year);
                            end;

                            SalesShipmentHeaderRec.Reset();
                            SalesShipmentHeaderRec.SetRange("posting Date", StartDate1, FinishDate1);
                            if SalesShipmentHeaderRec.FindSet() then begin
                                repeat
                                    SalesShipmentLineRec.Reset();
                                    SalesShipmentLineRec.SetRange("Document No.", SalesShipmentHeaderRec."No.");
                                    SalesShipmentLineRec.SetRange(Type, SalesShipmentLineRec.Type::Item);
                                    if SalesShipmentLineRec.FindSet() then begin
                                        repeat
                                            Ship_Pcs := SalesShipmentLineRec.Quantity;
                                            Ship_Value := SalesShipmentLineRec.Quantity * SalesShipmentLineRec."Unit Price";
                                            Ship_PcsTot += SalesShipmentLineRec.Quantity;
                                            Ship_ValueTot += SalesShipmentLineRec.Quantity * SalesShipmentLineRec."Unit Price";
                                        until SalesShipmentLineRec.Next() = 0;
                                    end;
                                until SalesShipmentHeaderRec.Next() = 0;
                            end;

                            //Get all factories
                            LocationRec.Reset();
                            LocationRec.SetFilter("Sewing Unit", '=%1', true);
                            if LocationRec.FindSet() then begin
                                repeat
                                    Capacity_Pcs1 := 0;
                                    Planned_Pcs1 := 0;
                                    Achieved_Pcs1 := 0;
                                    Diff_Pcs1 := 0;
                                    Avg_SMV1 := 0;
                                    Avg_SMVTemp1 := 0;
                                    Plan_Eff1 := 0;
                                    Available_Mnts1 := 0;
                                    Avg_Plan_Mnts1 := 0;

                                    WorkCenterRec.Reset();
                                    WorkCenterRec.SetRange("Factory No.", LocationRec.Code);
                                    WorkCenterRec.SetFilter("Planning Line", '=%1', true);
                                    if WorkCenterRec.FindSet() then begin
                                        repeat
                                            Capacity_Pcs2 := 0;
                                            Planned_Pcs2 := 0;
                                            Achieved_Pcs2 := 0;
                                            Diff_Pcs2 := 0;

                                            GetData(Mon, Name, WorkCenterRec."No.", LocationRec.Code);

                                            LineMax += 1;
                                            LineWiseCapacityRec.Init();
                                            LineWiseCapacityRec."No." := LineMax;
                                            LineWiseCapacityRec.Factory := LocationRec.Code;
                                            LineWiseCapacityRec."Resource No." := WorkCenterRec."No.";
                                            LineWiseCapacityRec."Resource Name" := WorkCenterRec.Name;
                                            LineWiseCapacityRec.Year := rec.Year;
                                            LineWiseCapacityRec.Month := Name;
                                            LineWiseCapacityRec."Month No" := Mon;
                                            LineWiseCapacityRec."Capacity Pcs" := Capacity_Pcs2;
                                            LineWiseCapacityRec."Achieved Pcs" := Achieved_Pcs2;
                                            LineWiseCapacityRec."Diff." := Diff_Pcs2;
                                            LineWiseCapacityRec."Planned Pcs" := Planned_Pcs2;
                                            LineWiseCapacityRec."Record Type" := 'R';
                                            LineWiseCapacityRec.Insert();
                                        until WorkCenterRec.Next() = 0;
                                    end;

                                    //Factory wise insert
                                    if Available_Mnts1 > 0 then
                                        Plan_Eff1 := (Avg_Plan_Mnts1 / Available_Mnts1) * 100;

                                    FacMax += 1;
                                    FactoryWiseCapacityRec.Init();
                                    FactoryWiseCapacityRec."No." := FacMax;
                                    FactoryWiseCapacityRec.Factory := LocationRec.Code;
                                    FactoryWiseCapacityRec.Year := rec.Year;
                                    FactoryWiseCapacityRec.Month := Name;
                                    FactoryWiseCapacityRec."Month No" := Mon;
                                    FactoryWiseCapacityRec."Capacity Pcs" := Capacity_Pcs1;
                                    FactoryWiseCapacityRec."Achieved Pcs" := Achieved_Pcs1;
                                    FactoryWiseCapacityRec."Diff." := Diff_Pcs1;
                                    FactoryWiseCapacityRec."Planned Pcs" := Planned_Pcs1;
                                    FactoryWiseCapacityRec."Avg SMV" := Avg_SMV1;
                                    FactoryWiseCapacityRec."Plan Eff." := Plan_Eff1;
                                    FactoryWiseCapacityRec."Record Type" := 'R';
                                    FactoryWiseCapacityRec.Insert();
                                until LocationRec.Next() = 0;

                                //Factory/month wise total insert
                                if Available_Mnts1Tot > 0 then
                                    Plan_Eff1Tot := (Avg_Plan_Mnts1Tot / Available_Mnts1Tot) * 100;

                                FacMax += 1;
                                FactoryWiseCapacityRec.Init();
                                FactoryWiseCapacityRec."No." := FacMax;
                                FactoryWiseCapacityRec.Factory := 'Total';
                                FactoryWiseCapacityRec.Year := rec.Year;
                                FactoryWiseCapacityRec.Month := Name;
                                FactoryWiseCapacityRec."Month No" := Mon;
                                FactoryWiseCapacityRec."Capacity Pcs" := Capacity_Pcs1Tot;
                                FactoryWiseCapacityRec."Achieved Pcs" := Achieved_Pcs1Tot;
                                FactoryWiseCapacityRec."Planned Pcs" := Planned_Pcs1Tot;
                                FactoryWiseCapacityRec."Diff." := Achieved_Pcs1Tot - Planned_Pcs1Tot;
                                FactoryWiseCapacityRec."Avg SMV" := Avg_SMV1Tot;
                                FactoryWiseCapacityRec."Plan Eff." := Plan_Eff1Tot;
                                FactoryWiseCapacityRec."Record Type" := 'S';
                                FactoryWiseCapacityRec.Insert();

                                LineMax += 1;
                                LineWiseCapacityRec.Init();
                                LineWiseCapacityRec."No." := LineMax;
                                LineWiseCapacityRec.Factory := 'Total';
                                LineWiseCapacityRec."Resource No." := '';
                                LineWiseCapacityRec."Resource Name" := '';
                                LineWiseCapacityRec.Year := rec.Year;
                                LineWiseCapacityRec.Month := Name;
                                LineWiseCapacityRec."Month No" := Mon;
                                LineWiseCapacityRec."Capacity Pcs" := Capacity_Pcs1Tot;
                                LineWiseCapacityRec."Achieved Pcs" := Achieved_Pcs1Tot;
                                LineWiseCapacityRec."Planned Pcs" := Planned_Pcs1Tot;
                                LineWiseCapacityRec."Diff." := Achieved_Pcs1Tot - Planned_Pcs1Tot;
                                LineWiseCapacityRec."Record Type" := 'R';
                                LineWiseCapacityRec.Insert();
                            end;

                            if Available_Mnts > 0 then
                                Plan_Eff := (Avg_Plan_Mnts / Available_Mnts) * 100;

                            //Group wise insert
                            GroupMax += 1;
                            GroupWiseCapacityRec.Init();
                            GroupWiseCapacityRec."No." := GroupMax;
                            GroupWiseCapacityRec.Year := rec.Year;
                            GroupWiseCapacityRec.Month := Name;
                            GroupWiseCapacityRec."Month No" := Mon;
                            GroupWiseCapacityRec."Capacity Pcs" := Capacity_Pcs;
                            GroupWiseCapacityRec."Achieved Pcs" := Achieved_Pcs;
                            GroupWiseCapacityRec."Diff." := Diff_Pcs;
                            GroupWiseCapacityRec."Planned Pcs" := Planned_Pcs;
                            GroupWiseCapacityRec."Avg SMV" := Avg_SMV;
                            GroupWiseCapacityRec.Finishing := Finishing_Pcs;
                            GroupWiseCapacityRec."Ship Qty" := Ship_Pcs;
                            GroupWiseCapacityRec."Ship Value" := Ship_Value;
                            GroupWiseCapacityRec."Avg Plan Mnts" := Avg_Plan_Mnts;
                            GroupWiseCapacityRec."Avg Prod. Mnts" := Avg_Prod_Mnts;
                            GroupWiseCapacityRec."Plan Hit" := Plan_Hit;
                            GroupWiseCapacityRec."Plan Eff." := Plan_Eff;
                            GroupWiseCapacityRec."Actual Eff." := Act_Eff;
                            GroupWiseCapacityRec."Record Type" := 'R';
                            GroupWiseCapacityRec.Insert();
                        end;

                        if Avg_Plan_MntsTot > 0 then
                            Plan_HitTot := (Avg_Prod_MntsTot / Avg_Plan_MntsTot) * 100;

                        if Available_MntsTot > 0 then
                            Plan_EffTot := (Avg_Plan_MntsTot / Available_MntsTot) * 100;

                        if Available_MntsTot > 0 then
                            Act_EffTot := (Avg_Prod_MntsTot / Available_MntsTot) * 100;

                        //Group wise total insert
                        GroupMax += 1;
                        GroupWiseCapacityRec.Init();
                        GroupWiseCapacityRec."No." := GroupMax;
                        GroupWiseCapacityRec.Year := rec.Year;
                        GroupWiseCapacityRec.Month := 'Total';
                        GroupWiseCapacityRec."Month No" := 0;
                        GroupWiseCapacityRec."Capacity Pcs" := Capacity_PcsTot;
                        GroupWiseCapacityRec."Achieved Pcs" := Achieved_PcsTot;
                        GroupWiseCapacityRec."Diff." := Diff_PcsTot;
                        GroupWiseCapacityRec."Planned Pcs" := Planned_PcsTot;
                        GroupWiseCapacityRec."Avg SMV" := Avg_SMVTot;
                        GroupWiseCapacityRec.Finishing := Finishing_PcsTot;
                        GroupWiseCapacityRec."Ship Qty" := Ship_PcsTot;
                        GroupWiseCapacityRec."Ship Value" := Ship_ValueTot;
                        GroupWiseCapacityRec."Avg Plan Mnts" := Avg_Plan_MntsTot;
                        GroupWiseCapacityRec."Avg Prod. Mnts" := Avg_Prod_MntsTot;
                        GroupWiseCapacityRec."Plan Hit" := Plan_HitTot;
                        GroupWiseCapacityRec."Plan Eff." := Plan_EffTot;
                        GroupWiseCapacityRec."Actual Eff." := Act_EffTot;
                        GroupWiseCapacityRec."Record Type" := 'S';
                        GroupWiseCapacityRec.Insert();

                        Message('Completed');
                    end
                    else
                        Error('Year is invalid.');
                end;
            }
        }
    }



    trigger OnOpenPage()
    var
        YearRec: Record YearTable;
        Monthrec: Record MonthTable;
        Y: Integer;
        Name: text[20];
        i: Integer;
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


        Monthrec.Reset();
        if not Monthrec.FindSet() then begin
            for i := 1 to 12 do begin
                case i of
                    1:
                        Name := 'January';
                    2:
                        Name := 'February';
                    3:
                        Name := 'March';
                    4:
                        Name := 'April';
                    5:
                        Name := 'May';
                    6:
                        Name := 'June';
                    7:
                        Name := 'July';
                    8:
                        Name := 'August';
                    9:
                        Name := 'September';
                    10:
                        Name := 'October';
                    11:
                        Name := 'November';
                    12:
                        Name := 'December';
                end;

                Monthrec.Init();
                Monthrec."Month No" := i;
                Monthrec."Month Name" := Name;
                Monthrec.Insert();

            end;
        end;

        rec.Year := Y;
    end;


    procedure GetData(MonPara: Integer; NamePara: text[20]; LineNoPara: code[20]; FactoryPara: code[20])
    var
        GroupWiseCapacityRec: Record GroupWiseCapacity;
        FactoryWiseCapacityRec: Record FactoryWiseCapacity;
        LineWiseCapacityRec: Record LineWiseCapacity;
        LocationRec: Record Location;
        WorkCenterRec: Record "Work Center";
        NavAppProdRec: Record "NavApp Prod Plans Details";
        NavAppSetuprec: Record "NavApp Setup";
        CalenderRec: Record "Calendar Entry";
        ProdOutHeaderRec: Record ProductionOutHeader;
        StartDate: Date;
        FinishDate: Date;
        NoofDays: Integer;
        HoursPerDay: Decimal;
    begin
        NavAppSetuprec.Reset();
        NavAppSetuprec.FindSet();

        WorkCenterRec.Reset();
        WorkCenterRec.SetRange("No.", LineNoPara);
        WorkCenterRec.FindSet();

        LocationRec.Reset();
        LocationRec.SetFilter(Code, FactoryPara);
        LocationRec.FindSet();

        //////Cal Capacity_Pcs
        HoursPerDay := (LocationRec."Finish Time" - LocationRec."Start Time") / 3600000;
        StartDate := DMY2DATE(1, MonPara, rec.Year);
        case MonPara of
            1:
                FinishDate := DMY2DATE(31, MonPara, rec.Year);
            2:
                begin
                    if rec.Year mod 4 = 0 then
                        FinishDate := DMY2DATE(29, MonPara, rec.Year)
                    else
                        FinishDate := DMY2DATE(28, MonPara, rec.Year);
                end;
            3:
                FinishDate := DMY2DATE(31, MonPara, rec.Year);
            4:
                FinishDate := DMY2DATE(30, MonPara, rec.Year);
            5:
                FinishDate := DMY2DATE(31, MonPara, rec.Year);
            6:
                FinishDate := DMY2DATE(30, MonPara, rec.Year);
            7:
                FinishDate := DMY2DATE(31, MonPara, rec.Year);
            8:
                FinishDate := DMY2DATE(31, MonPara, rec.Year);
            9:
                FinishDate := DMY2DATE(30, MonPara, rec.Year);
            10:
                FinishDate := DMY2DATE(31, MonPara, rec.Year);
            11:
                FinishDate := DMY2DATE(30, MonPara, rec.Year);
            12:
                FinishDate := DMY2DATE(31, MonPara, rec.Year);
        end;

        //Get no of working days
        NoofDays := 0;
        CalenderRec.Reset();
        CalenderRec.SETRANGE("Work Center No.", LineNoPara);
        CalenderRec.SETRANGE(Date, StartDate, FinishDate);
        if CalenderRec.FindSet() then begin
            repeat
                if CalenderRec."Capacity (Total)" > 0 then
                    NoofDays += 1;
            until CalenderRec.Next() = 0;
        end;

        Capacity_Pcs += Round(((WorkCenterRec.Carder * NoofDays * HoursPerDay * NavAppSetuprec."Capacity Book Eff") / 100 * 60) / NavAppSetuprec."Capacity Book SMV", 1);
        Capacity_PcsTot += Round(((WorkCenterRec.Carder * NoofDays * HoursPerDay * NavAppSetuprec."Capacity Book Eff") / 100 * 60) / NavAppSetuprec."Capacity Book SMV", 1);

        Capacity_Pcs1 += Round(((WorkCenterRec.Carder * NoofDays * HoursPerDay * NavAppSetuprec."Capacity Book Eff") / 100 * 60) / NavAppSetuprec."Capacity Book SMV", 1);
        Capacity_Pcs1Tot += Round(((WorkCenterRec.Carder * NoofDays * HoursPerDay * NavAppSetuprec."Capacity Book Eff") / 100 * 60) / NavAppSetuprec."Capacity Book SMV", 1);

        Capacity_Pcs2 := Round(((WorkCenterRec.Carder * NoofDays * HoursPerDay * NavAppSetuprec."Capacity Book Eff") / 100 * 60) / NavAppSetuprec."Capacity Book SMV", 1);

        //////Cal planned pcs       
        NavAppProdRec.Reset();
        NavAppProdRec.SetRange("Factory No.", FactoryPara);
        NavAppProdRec.SetRange("Resource No.", LineNoPara);
        NavAppProdRec.SetRange(PlanDate, StartDate, FinishDate);
        if NavAppProdRec.FindSet() then begin
            repeat
                Planned_Pcs += round(NavAppProdRec.Qty, 1);
                Planned_PcsTot += round(NavAppProdRec.Qty, 1);
                Planned_Pcs1 += round(NavAppProdRec.Qty, 1);
                Planned_Pcs1Tot += round(NavAppProdRec.Qty, 1);
                Planned_Pcs2 += round(NavAppProdRec.Qty, 1);
            until NavAppProdRec.Next() = 0;
        end;

        //////Cal Achieved pcs     
        NavAppProdRec.Reset();
        NavAppProdRec.SetRange("Factory No.", FactoryPara);
        NavAppProdRec.SetRange("Resource No.", LineNoPara);
        NavAppProdRec.SetRange(PlanDate, StartDate, FinishDate);
        NavAppProdRec.SetFilter(ProdUpd, '=%1', 1);
        if NavAppProdRec.FindSet() then begin
            repeat
                Achieved_Pcs += NavAppProdRec.ProdUpdQty;
                Achieved_PcsTot += NavAppProdRec.ProdUpdQty;
                Achieved_Pcs1 += NavAppProdRec.ProdUpdQty;
                Achieved_Pcs1Tot += NavAppProdRec.ProdUpdQty;
                Achieved_Pcs2 += NavAppProdRec.ProdUpdQty;
                Avg_Prod_Mnts += NavAppProdRec.ProdUpdQty * NavAppProdRec.SMV;
                Avg_Prod_MntsTot += NavAppProdRec.ProdUpdQty * NavAppProdRec.SMV;
            until NavAppProdRec.Next() = 0;
        end;

        //////Cal Diff pcs
        Diff_Pcs := Achieved_Pcs - Planned_Pcs;
        Diff_PcsTot := Achieved_PcsTot - Planned_PcsTot;
        Diff_Pcs1 := Achieved_Pcs1 - Planned_Pcs1;
        Diff_Pcs2 := Achieved_Pcs2 - Planned_Pcs2;

        //////Cal Avg_SMV and Avg_Plan_Mnts      
        NavAppProdRec.Reset();
        NavAppProdRec.SetRange("Factory No.", FactoryPara);
        NavAppProdRec.SetRange("Resource No.", LineNoPara);
        NavAppProdRec.SetRange(PlanDate, StartDate, FinishDate);
        if NavAppProdRec.FindSet() then begin
            repeat
                Avg_SMVTemp += NavAppProdRec.Qty * NavAppProdRec.SMV;
                Avg_SMVTempTot += NavAppProdRec.Qty * NavAppProdRec.SMV;
                Avg_SMVTemp1 += NavAppProdRec.Qty * NavAppProdRec.SMV;
                Avg_SMVTemp1Tot += NavAppProdRec.Qty * NavAppProdRec.SMV;
                Avg_Plan_Mnts += NavAppProdRec.Qty * NavAppProdRec.SMV;
                Avg_Plan_MntsTot += NavAppProdRec.Qty * NavAppProdRec.SMV;
                Avg_Plan_Mnts1 += NavAppProdRec.Qty * NavAppProdRec.SMV;
                Avg_Plan_Mnts1Tot += NavAppProdRec.Qty * NavAppProdRec.SMV;
            until NavAppProdRec.Next() = 0;

            if Planned_Pcs > 0 then
                Avg_SMV := Avg_SMVTemp / Planned_Pcs;

            if Planned_PcsTot > 0 then
                Avg_SMVTot := Avg_SMVTempTot / Planned_PcsTot;

            if Planned_Pcs1 > 0 then
                Avg_SMV1 := Avg_SMVTemp1 / Planned_Pcs1;

            if Planned_Pcs1Tot > 0 then
                Avg_SMV1Tot := Avg_SMVTemp1Tot / Planned_Pcs1Tot;
        end;

        //////Cal Finishing Pcs       
        ProdOutHeaderRec.Reset();
        ProdOutHeaderRec.SetRange(Type, ProdOutHeaderRec.Type::Fin);
        ProdOutHeaderRec.SetRange("Factory Code", FactoryPara);
        ProdOutHeaderRec.SetRange("Prod Date", StartDate, FinishDate);
        ProdOutHeaderRec.SetRange("Resource No.", LineNoPara);
        if ProdOutHeaderRec.FindSet() then begin
            repeat
                Finishing_Pcs += ProdOutHeaderRec."Output Qty";
                Finishing_PcsTot += ProdOutHeaderRec."Output Qty";
            until ProdOutHeaderRec.Next() = 0;
        end;

        //////Cal Plan_Hit
        if Avg_Plan_Mnts > 0 then
            Plan_Hit := (Avg_Prod_Mnts / Avg_Plan_Mnts) * 100;

        //////Cal Plan_Eff
        Available_Mnts += WorkCenterRec.Carder * NoofDays * HoursPerDay * 60;
        Available_MntsTot += WorkCenterRec.Carder * NoofDays * HoursPerDay * 60;
        Available_Mnts1 += WorkCenterRec.Carder * NoofDays * HoursPerDay * 60;
        Available_Mnts1Tot += WorkCenterRec.Carder * NoofDays * HoursPerDay * 60;

        //////Cal Act_Eff
        if Available_Mnts > 0 then
            Act_Eff := (Avg_Prod_Mnts / Available_Mnts) * 100;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        GroupWiseCapacityRec: Record GroupWiseCapacity;
        LineWiseCapacityRec: Record LineWiseCapacity;
        FactoryWiseCapacityRec: Record FactoryWiseCapacity;
    begin
        GroupWiseCapacityRec.Reset();
        GroupWiseCapacityRec.SetRange(Year, rec.Year);
        if GroupWiseCapacityRec.FindSet() then
            GroupWiseCapacityRec.DeleteAll();

        LineWiseCapacityRec.Reset();
        LineWiseCapacityRec.SetRange(Year, rec.Year);
        if LineWiseCapacityRec.FindSet() then
            LineWiseCapacityRec.DeleteAll();

        FactoryWiseCapacityRec.Reset();
        FactoryWiseCapacityRec.SetRange(Year, rec.Year);
        if FactoryWiseCapacityRec.FindSet() then
            FactoryWiseCapacityRec.DeleteAll();
    end;


    var
        LineMax: BigInteger;
        FacMax: BigInteger;
        GroupMax: BigInteger;
        Capacity_Pcs: BigInteger;
        Planned_Pcs: BigInteger;
        Achieved_Pcs: BigInteger;
        Diff_Pcs: BigInteger;
        Avg_SMV: Decimal;
        Avg_SMVTemp: Decimal;
        Finishing_Pcs: BigInteger;
        Ship_Pcs: BigInteger;
        Ship_Value: Decimal;
        Avg_Plan_Mnts: Decimal;
        Avg_Prod_Mnts: Decimal;
        Plan_Hit: Decimal;
        Plan_Eff: Decimal;
        Act_Eff: Decimal;
        Available_Mnts: Decimal;
        Capacity_PcsTot: BigInteger;
        Planned_PcsTot: BigInteger;
        Achieved_PcsTot: BigInteger;
        Diff_PcsTot: BigInteger;
        Avg_SMVTot: Decimal;
        Avg_SMVTempTot: Decimal;
        Finishing_PcsTot: BigInteger;
        Ship_PcsTot: BigInteger;
        Ship_ValueTot: Decimal;
        Avg_Plan_MntsTot: Decimal;
        Avg_Prod_MntsTot: Decimal;
        Plan_HitTot: Decimal;
        Plan_EffTot: Decimal;
        Act_EffTot: Decimal;
        Available_MntsTot: Decimal;

        Capacity_Pcs1: BigInteger;
        Planned_Pcs1: BigInteger;
        Achieved_Pcs1: BigInteger;
        Diff_Pcs1: BigInteger;
        Avg_SMV1: Decimal;
        Avg_SMVTemp1: Decimal;
        Plan_Eff1: Decimal;
        Avg_Plan_Mnts1: Decimal;
        Available_Mnts1: Decimal;
        Capacity_Pcs2: BigInteger;
        Planned_Pcs2: BigInteger;
        Achieved_Pcs2: BigInteger;
        Diff_Pcs2: BigInteger;
        Capacity_Pcs1Tot: BigInteger;
        Planned_Pcs1Tot: BigInteger;
        Achieved_Pcs1Tot: BigInteger;
        Avg_SMV1Tot: Decimal;
        Plan_Eff1Tot: Decimal;
        Avg_SMVTemp1Tot: Decimal;
        Available_Mnts1Tot: Decimal;
        Avg_Plan_Mnts1Tot: Decimal;
}