page 51346 LineWiseCapacityListpart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LineWiseCapacity;
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

                field("Resource Name"; rec."Resource Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Caption = 'Line';
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
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Refresh Line Capacity Data")
            {
                ApplicationArea = All;
                Image = RefreshRegister;

                trigger OnAction();
                var
                    LocationRec: Record Location;
                    WorkCenterRec: Record "Work Center";
                    LineWiseCapacityRec: Record LineWiseCapacity;
                    StartDate1: Date;
                    FinishDate1: Date;
                begin
                    if YearNo < 2023 then
                        Error('Year is invalid.');

                    if MonthName = '' then
                        Error('Month is invalid.');

                    //Delete old data               
                    LineWiseCapacityRec.Reset();
                    if LineWiseCapacityRec.FindSet() then
                        LineWiseCapacityRec.DeleteAll();

                    Capacity_Pcs1Tot := 0;
                    Planned_Pcs1Tot := 0;
                    Achieved_Pcs1Tot := 0;
                    LineMax := 0;

                    //Get all factories
                    LocationRec.Reset();
                    LocationRec.SetFilter("Sewing Unit", '=%1', true);
                    if LocationRec.FindSet() then begin
                        repeat

                            WorkCenterRec.Reset();
                            WorkCenterRec.SetRange("Factory No.", LocationRec.Code);
                            WorkCenterRec.SetFilter("Planning Line", '=%1', true);
                            if WorkCenterRec.FindSet() then begin
                                repeat
                                    Capacity_Pcs2 := 0;
                                    Planned_Pcs2 := 0;
                                    Achieved_Pcs2 := 0;
                                    Diff_Pcs2 := 0;

                                    GetDataLine(MonthNo, MonthName, WorkCenterRec."No.", LocationRec.Code);

                                    LineMax += 1;
                                    LineWiseCapacityRec.Init();
                                    LineWiseCapacityRec."No." := LineMax;
                                    LineWiseCapacityRec.Factory := LocationRec.Code;
                                    LineWiseCapacityRec."Resource No." := WorkCenterRec."No.";
                                    LineWiseCapacityRec."Resource Name" := WorkCenterRec.Name;
                                    LineWiseCapacityRec.Year := YearNo;
                                    LineWiseCapacityRec.Month := MonthName;
                                    LineWiseCapacityRec."Month No" := MonthNo;
                                    LineWiseCapacityRec."Capacity Pcs" := Capacity_Pcs2;
                                    LineWiseCapacityRec."Achieved Pcs" := Achieved_Pcs2;
                                    LineWiseCapacityRec."Diff." := Diff_Pcs2;
                                    LineWiseCapacityRec."Planned Pcs" := Planned_Pcs2;
                                    LineWiseCapacityRec."Record Type" := 'R';
                                    LineWiseCapacityRec.Insert();
                                until WorkCenterRec.Next() = 0;
                            end;
                        until LocationRec.Next() = 0;

                        LineMax += 1;
                        LineWiseCapacityRec.Init();
                        LineWiseCapacityRec."No." := LineMax;
                        LineWiseCapacityRec.Factory := 'Total';
                        LineWiseCapacityRec."Resource No." := '';
                        LineWiseCapacityRec."Resource Name" := '';
                        LineWiseCapacityRec.Year := YearNo;
                        LineWiseCapacityRec.Month := MonthName;
                        LineWiseCapacityRec."Month No" := MonthNo;
                        LineWiseCapacityRec."Capacity Pcs" := Capacity_Pcs1Tot;
                        LineWiseCapacityRec."Achieved Pcs" := Achieved_Pcs1Tot;
                        LineWiseCapacityRec."Planned Pcs" := Planned_Pcs1Tot;
                        LineWiseCapacityRec."Diff." := Achieved_Pcs1Tot - Planned_Pcs1Tot;
                        LineWiseCapacityRec."Record Type" := 'S';
                        LineWiseCapacityRec.Insert();
                    end;
                    Message('Completed');
                end;
            }
        }
    }


    procedure GetDataLine(MonPara: Integer; NamePara: text[20]; LineNoPara: code[20]; FactoryPara: code[20])
    var
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

        // if LineNoPara = 'AFL-01' then
        //     Message('AFL-01');

        Capacity_Pcs1Tot += Round(((WorkCenterRec.Carder * NoofDays * HoursPerDay * NavAppSetuprec."Capacity Book Eff") / 100 * 60) / NavAppSetuprec."Capacity Book SMV", 1);
        Capacity_Pcs2 := Round(((WorkCenterRec.Carder * NoofDays * HoursPerDay * NavAppSetuprec."Capacity Book Eff") / 100 * 60) / NavAppSetuprec."Capacity Book SMV", 1);

        //////Cal planned pcs       
        NavAppProdRec.Reset();
        NavAppProdRec.SetRange("Factory No.", FactoryPara);
        NavAppProdRec.SetRange("Resource No.", LineNoPara);
        NavAppProdRec.SetRange(PlanDate, StartDate, FinishDate);
        if NavAppProdRec.FindSet() then begin
            repeat
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
                Achieved_Pcs1Tot += NavAppProdRec.ProdUpdQty;
                Achieved_Pcs2 += NavAppProdRec.ProdUpdQty;
            until NavAppProdRec.Next() = 0;
        end;

        //////Cal Diff pcs      
        Diff_Pcs2 := Achieved_Pcs2 - Planned_Pcs2;
    end;


    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorLineWiseCap(rec)
    end;


    trigger OnOpenPage()
    var
        Y: Integer;
        LineWiseCapacityRec: Record LineWiseCapacity;
    begin
        evaluate(Y, copystr(Format(Today()), 7, 2));
        Y := 2000 + Y;
        YearNo := Y;
        MonthName := 'January';
        MonthNo := 1;

        LineWiseCapacityRec.Reset();
        if LineWiseCapacityRec.FindSet() then
            LineWiseCapacityRec.DeleteAll();
    end;

    VAR
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
        MonthNo: Integer;
        MonthName: Text[20];
        YearNo: Integer;
        Capacity_Pcs2: BigInteger;
        Planned_Pcs2: BigInteger;
        Achieved_Pcs2: BigInteger;
        Diff_Pcs2: BigInteger;
        LineMax: BigInteger;
        Capacity_Pcs1Tot: BigInteger;
        Planned_Pcs1Tot: BigInteger;
        Achieved_Pcs1Tot: BigInteger;
}