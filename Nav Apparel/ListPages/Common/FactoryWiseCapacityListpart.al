page 51344 FactoryWiseCapacityListpart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FactoryWiseCapacity;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(Filter)
            {
                field(YearNo; YearNo)
                {
                    ApplicationArea = all;
                    TableRelation = YearTable.Year;
                    Caption = 'Year';
                }

                field(MonthName; MonthName)
                {
                    ApplicationArea = all;
                    TableRelation = MonthTable."Month Name";
                    Caption = 'Month';

                    trigger OnValidate()
                    var
                        MonthRec: Record MonthTable;
                    begin
                        MonthRec.Reset();
                        MonthRec.SetRange("Month Name", MonthName);
                        MonthRec.FindSet();
                        MonthNo := MonthRec."Month No";
                    end;
                }
            }

            repeater(GroupName)
            {
                Editable = false;

                field(Factory; rec.Factory)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Month; rec.Month)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Capacity Pcs"; rec."Capacity Pcs")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Planned Pcs"; rec."Planned Pcs")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Achieved Pcs"; rec."Achieved Pcs")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Diff."; rec."Diff.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Avg SMV"; rec."Avg SMV")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Plan Eff."; rec."Plan Eff.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Refresh Factory Capacity Data")
            {
                ApplicationArea = All;
                Image = RefreshRegister;

                trigger OnAction();
                var
                    LocationRec: Record Location;
                    WorkCenterRec: Record "Work Center";
                    FactoryWiseCapacityRec: Record FactoryWiseCapacity;
                    StartDate1: Date;
                    FinishDate1: Date;
                begin
                    if YearNo < 2023 then
                        Error('Year is invalid.');

                    if MonthName = '' then
                        Error('Month is invalid.');

                    //Delete old data
                    FactoryWiseCapacityRec.Reset();
                    if FactoryWiseCapacityRec.FindSet() then
                        FactoryWiseCapacityRec.DeleteAll();

                    FacMax := 0;
                    Capacity_Pcs1Tot := 0;
                    Planned_Pcs1Tot := 0;
                    Achieved_Pcs1Tot := 0;
                    Avg_SMV1Tot := 0;
                    Avg_SMVTemp1Tot := 0;
                    Plan_Eff1Tot := 0;
                    Available_Mnts1Tot := 0;
                    Avg_Plan_Mnts1Tot := 0;

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
                                    GetDataFac(MonthNo, MonthName, WorkCenterRec."No.", LocationRec.Code);
                                until WorkCenterRec.Next() = 0;
                            end;

                            //Factory wise insert
                            if Available_Mnts1 > 0 then
                                Plan_Eff1 := (Avg_Plan_Mnts1 / Available_Mnts1) * 100;

                            FacMax += 1;
                            FactoryWiseCapacityRec.Init();
                            FactoryWiseCapacityRec."No." := FacMax;
                            FactoryWiseCapacityRec.Factory := LocationRec.Code;
                            FactoryWiseCapacityRec.Year := YearNo;
                            FactoryWiseCapacityRec.Month := MonthName;
                            FactoryWiseCapacityRec."Month No" := MonthNo;
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
                        FactoryWiseCapacityRec.Year := YearNo;
                        FactoryWiseCapacityRec.Month := MonthName;
                        FactoryWiseCapacityRec."Month No" := MonthNo;
                        FactoryWiseCapacityRec."Capacity Pcs" := Capacity_Pcs1Tot;
                        FactoryWiseCapacityRec."Achieved Pcs" := Achieved_Pcs1Tot;
                        FactoryWiseCapacityRec."Planned Pcs" := Planned_Pcs1Tot;
                        FactoryWiseCapacityRec."Diff." := Achieved_Pcs1Tot - Planned_Pcs1Tot;
                        FactoryWiseCapacityRec."Avg SMV" := Avg_SMV1Tot;
                        FactoryWiseCapacityRec."Plan Eff." := Plan_Eff1Tot;
                        FactoryWiseCapacityRec."Record Type" := 'S';
                        FactoryWiseCapacityRec.Insert();
                    end;
                    Message('Completed');
                end;
            }
        }
    }


    procedure GetDataFac(MonPara: Integer; NamePara: text[20]; LineNoPara: code[20]; FactoryPara: code[20])
    var
        FactoryWiseCapacityRec: Record FactoryWiseCapacity;
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
        StartDate := DMY2DATE(1, MonPara, YearNo);
        case MonPara of
            1:
                FinishDate := DMY2DATE(31, MonPara, YearNo);
            2:
                begin
                    if YearNo mod 4 = 0 then
                        FinishDate := DMY2DATE(29, MonPara, YearNo)
                    else
                        FinishDate := DMY2DATE(28, MonPara, YearNo);
                end;
            3:
                FinishDate := DMY2DATE(31, MonPara, YearNo);
            4:
                FinishDate := DMY2DATE(30, MonPara, YearNo);
            5:
                FinishDate := DMY2DATE(31, MonPara, YearNo);
            6:
                FinishDate := DMY2DATE(30, MonPara, YearNo);
            7:
                FinishDate := DMY2DATE(31, MonPara, YearNo);
            8:
                FinishDate := DMY2DATE(31, MonPara, YearNo);
            9:
                FinishDate := DMY2DATE(30, MonPara, YearNo);
            10:
                FinishDate := DMY2DATE(31, MonPara, YearNo);
            11:
                FinishDate := DMY2DATE(30, MonPara, YearNo);
            12:
                FinishDate := DMY2DATE(31, MonPara, YearNo);
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

        Capacity_Pcs1 += Round(((WorkCenterRec.Carder * NoofDays * HoursPerDay * NavAppSetuprec."Capacity Book Eff") / 100 * 60) / NavAppSetuprec."Capacity Book SMV", 1);
        Capacity_Pcs1Tot += Round(((WorkCenterRec.Carder * NoofDays * HoursPerDay * NavAppSetuprec."Capacity Book Eff") / 100 * 60) / NavAppSetuprec."Capacity Book SMV", 1);

        //////Cal planned pcs       
        NavAppProdRec.Reset();
        NavAppProdRec.SetRange("Factory No.", FactoryPara);
        NavAppProdRec.SetRange("Resource No.", LineNoPara);
        NavAppProdRec.SetRange(PlanDate, StartDate, FinishDate);
        if NavAppProdRec.FindSet() then begin
            repeat
                Planned_Pcs1 += round(NavAppProdRec.Qty, 1);
                Planned_Pcs1Tot += round(NavAppProdRec.Qty, 1);
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
                Achieved_Pcs1 += NavAppProdRec.ProdUpdQty;
                Achieved_Pcs1Tot += NavAppProdRec.ProdUpdQty;
            until NavAppProdRec.Next() = 0;
        end;

        //////Cal Diff pcs   
        Diff_Pcs1 := Achieved_Pcs1 - Planned_Pcs1;

        //////Cal Avg_SMV and Avg_Plan_Mnts      
        NavAppProdRec.Reset();
        NavAppProdRec.SetRange("Factory No.", FactoryPara);
        NavAppProdRec.SetRange("Resource No.", LineNoPara);
        NavAppProdRec.SetRange(PlanDate, StartDate, FinishDate);
        if NavAppProdRec.FindSet() then begin
            repeat
                Avg_SMVTemp1 += NavAppProdRec.Qty * NavAppProdRec.SMV;
                Avg_SMVTemp1Tot += NavAppProdRec.Qty * NavAppProdRec.SMV;
                Avg_Plan_Mnts1 += NavAppProdRec.Qty * NavAppProdRec.SMV;
                Avg_Plan_Mnts1Tot += NavAppProdRec.Qty * NavAppProdRec.SMV;
            until NavAppProdRec.Next() = 0;

            if Planned_Pcs1 > 0 then
                Avg_SMV1 := Avg_SMVTemp1 / Planned_Pcs1;

            if Planned_Pcs1Tot > 0 then
                Avg_SMV1Tot := Avg_SMVTemp1Tot / Planned_Pcs1Tot;
        end;

        Available_Mnts1 += WorkCenterRec.Carder * NoofDays * HoursPerDay * 60;
        Available_Mnts1Tot += WorkCenterRec.Carder * NoofDays * HoursPerDay * 60;
    end;


    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorFactoryWiseCap(rec)
    end;


    trigger OnOpenPage()
    var
        Y: Integer;
        FactoryWiseCapacityRec: Record FactoryWiseCapacity;
    begin
        evaluate(Y, copystr(Format(Today()), 7, 2));
        Y := 2000 + Y;
        YearNo := Y;
        MonthName := 'January';
        MonthNo := 1;

        //Delete old data
        FactoryWiseCapacityRec.Reset();
        if FactoryWiseCapacityRec.FindSet() then
            FactoryWiseCapacityRec.DeleteAll();
    end;


    VAR
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
        MonthNo: Integer;
        MonthName: Text[20];
        YearNo: Integer;
        FacMax: BigInteger;
        Capacity_Pcs1: BigInteger;
        Planned_Pcs1: BigInteger;
        Achieved_Pcs1: BigInteger;
        Diff_Pcs1: BigInteger;
        Avg_SMV1: Decimal;
        Avg_SMVTemp1: Decimal;
        Plan_Eff1: Decimal;
        Avg_Plan_Mnts1: Decimal;
        Available_Mnts1: Decimal;
        Capacity_Pcs1Tot: BigInteger;
        Planned_Pcs1Tot: BigInteger;
        Achieved_Pcs1Tot: BigInteger;
        Avg_SMV1Tot: Decimal;
        Plan_Eff1Tot: Decimal;
        Avg_SMVTemp1Tot: Decimal;
        Available_Mnts1Tot: Decimal;
        Avg_Plan_Mnts1Tot: Decimal;
}