page 50815 "Factory Manpower Budget Card"
{
    PageType = Card;
    SourceTable = FactoryManpowerBudgetHeader;
    Caption = 'Factory Manpower Budget Vs Actual';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Factory Name"; "Factory Name")
                {
                    ShowMandatory = true;
                    ApplicationArea = All;
                    Caption = 'Factory';

                    trigger OnValidate()
                    var
                        Locationrec: Record Location;
                    begin
                        Locationrec.Reset();
                        Locationrec.SetRange(Name, "Factory Name");
                        if Locationrec.FindSet() then
                            "Factory Code" := Locationrec.Code;

                        GenerateLines();
                    end;
                }

                field(Date; Date)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                    begin
                        GenerateLines();
                    end;
                }
            }

            group("Attendance Details")
            {
                part("FactoryManpowerBudgetListPart"; "FactoryManpowerBudgetListPart")
                {
                    ApplicationArea = All;
                    SubPageLink = "No." = FIELD("No."), "Factory Code" = field("Factory Code"), "Factory Name" = field("Factory Name"), Date = field(Date);
                    Caption = ' ';
                }
            }
        }
    }

    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."ManBudget Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    procedure GenerateLines()
    var
        ManpowBudheadRec: Record FactoryManpowerBudgetHeader;
        ManpowBudLineRec: Record FactoryManpowerBudgetLine;
        ManpowBudLine1Rec: Record FactoryManpowerBudgetLine;
        Dept_desigRec: Record Dept_Categories;
        ManpowBudSummaryRec: Record ManpowBudSummary;
        LineNo: BigInteger;
        LineNo1: BigInteger;
        Total1: BigInteger;
        Total2: BigInteger;
        DeptTempCode: Code[20];
        DeptTempName: Text[50];
        GrandTotal1: BigInteger;
        GrandTotal2: BigInteger;
    begin

        if ("Factory Name" <> '') and (Date <> 0D) then begin

            ManpowBudLineRec.Reset();
            ManpowBudLineRec.SetRange("No.", "No.");
            if not ManpowBudLineRec.FindSet() then begin

                Dept_desigRec.Reset();
                Dept_desigRec.SetCurrentKey(No);
                Dept_desigRec.Ascending(true);
                if Dept_desigRec.FindSet() then begin

                    //Insert Grand total line
                    LineNo += 1;
                    ManpowBudLine1Rec.Init();
                    ManpowBudLine1Rec."No." := "No.";
                    ManpowBudLine1Rec."Factory Code" := "Factory Code";
                    ManpowBudLine1Rec."Factory Name" := "Factory Name";
                    ManpowBudLine1Rec.Date := Date;
                    ManpowBudLine1Rec.LineNo := LineNo;
                    ManpowBudLine1Rec."Department Code" := '';
                    ManpowBudLine1Rec."Department Name" := 'Grand Total (RMG)';
                    ManpowBudLine1Rec.Type := ManpowBudLineRec.Type::GT;
                    ManpowBudLine1Rec."Show In Report" := true;
                    ManpowBudLine1Rec.Insert();

                    DeptTempCode := Dept_desigRec."Department No.";
                    DeptTempName := Dept_desigRec."Department Name";
                    repeat
                        if DeptTempCode <> Dept_desigRec."Department No." then begin
                            //Insert sub total line (Department total)
                            LineNo += 1;
                            ManpowBudLineRec.Init();
                            ManpowBudLineRec."No." := "No.";
                            ManpowBudLineRec."Factory Code" := "Factory Code";
                            ManpowBudLineRec."Factory Name" := "Factory Name";
                            ManpowBudLineRec.Date := Date;
                            ManpowBudLineRec.LineNo := LineNo;
                            ManpowBudLineRec."Department Code" := DeptTempCode;
                            ManpowBudLineRec."Department Name" := DeptTempName + ' (Sub Total)';
                            ManpowBudLineRec.Type := ManpowBudLineRec.Type::ST;
                            ManpowBudLineRec."Show In Report" := true;
                            ManpowBudLineRec.Insert();
                        end;

                        LineNo += 1;
                        ManpowBudLineRec.Init();
                        ManpowBudLineRec."No." := "No.";
                        ManpowBudLineRec."Factory Code" := "Factory Code";
                        ManpowBudLineRec."Factory Name" := "Factory Name";
                        ManpowBudLineRec.Date := Date;
                        ManpowBudLineRec.LineNo := LineNo;
                        ManpowBudLineRec."Department Code" := Dept_desigRec."Department No.";
                        ManpowBudLineRec."Department Name" := Dept_desigRec."Department Name";
                        ManpowBudLineRec."Category No." := Dept_desigRec."Category No.";
                        ManpowBudLineRec."Category Name" := Dept_desigRec."Category Name";
                        ManpowBudLineRec.Type := ManpowBudLineRec.Type::DL;
                        ManpowBudLineRec."Act Budget" := Dept_desigRec."Act Budget";
                        ManpowBudLineRec."Final Budget with Absenteesm" := Dept_desigRec."Final Budget with Absenteesm";
                        ManpowBudLineRec."Show In Report" := Dept_desigRec."Show In Report";
                        ManpowBudLineRec.Insert();

                        DeptTempCode := Dept_desigRec."Department No.";
                        DeptTempName := Dept_desigRec."Department Name";
                    until Dept_desigRec.Next() = 0;


                    //Insert sub total line of last Department
                    LineNo += 1;
                    ManpowBudLineRec.Init();
                    ManpowBudLineRec."No." := "No.";
                    ManpowBudLineRec."Factory Code" := "Factory Code";
                    ManpowBudLineRec."Factory Name" := "Factory Name";
                    ManpowBudLineRec.Date := Date;
                    ManpowBudLineRec.LineNo := LineNo;
                    ManpowBudLineRec."Department Code" := DeptTempCode;
                    ManpowBudLineRec."Department Name" := DeptTempName;
                    ManpowBudLineRec.Type := ManpowBudLineRec.Type::ST;
                    ManpowBudLineRec."Show In Report" := true;
                    ManpowBudLineRec.Insert();


                    //Insert Grand total line
                    LineNo += 1;
                    ManpowBudLineRec.Init();
                    ManpowBudLineRec."No." := "No.";
                    ManpowBudLineRec."Factory Code" := "Factory Code";
                    ManpowBudLineRec."Factory Name" := "Factory Name";
                    ManpowBudLineRec.Date := Date;
                    ManpowBudLineRec.LineNo := LineNo;
                    ManpowBudLineRec."Department Code" := '';
                    ManpowBudLineRec."Department Name" := 'Grand Total (RMG)';
                    ManpowBudLineRec.Type := ManpowBudLineRec.Type::GT;
                    ManpowBudLineRec."Show In Report" := true;
                    ManpowBudLineRec.Insert();

                end;
            end;

            Cal();

            //Write to summary table
            Total1 := 0;
            Total2 := 0;
            ManpowBudSummaryRec.Reset();
            ManpowBudSummaryRec.SetRange("Created User", UserId);
            if ManpowBudSummaryRec.FindSet() then
                ManpowBudSummaryRec.DeleteAll();

            ManpowBudLineRec.Reset();
            ManpowBudLineRec.SetRange("No.", "No.");
            if ManpowBudLineRec.FindSet() then begin
                repeat

                    if ManpowBudLineRec."Department Name" = 'Sewing Direct Manpower (Machine Operator) (Sub Total)' then begin
                        LineNo1 += 1;
                        ManpowBudSummaryRec.Init();
                        ManpowBudSummaryRec."No." := ManpowBudLineRec."No.";
                        ManpowBudSummaryRec."Category Name" := 'Sewing Machines';
                        ManpowBudSummaryRec."Factory Name" := ManpowBudLineRec."Factory Name";
                        ManpowBudSummaryRec.Date := ManpowBudLineRec.Date;
                        ManpowBudSummaryRec.LineNo := LineNo1;
                        ManpowBudSummaryRec."Act Budget" := ManpowBudLineRec."Act Budget";
                        ManpowBudSummaryRec."Final Budget with Absenteesm" := ManpowBudLineRec."Final Budget with Absenteesm";
                        ManpowBudSummaryRec."Created User" := UserId;
                        ManpowBudSummaryRec."Created Date" := ManpowBudLineRec."Created Date";
                        ManpowBudSummaryRec.Insert();
                        Total1 += ManpowBudLineRec."Act Budget";
                        Total2 += ManpowBudLineRec."Final Budget with Absenteesm";
                    end;

                    if ManpowBudLineRec."Category Name" = 'Sample Operators' then begin
                        LineNo1 += 1;
                        ManpowBudSummaryRec.Init();
                        ManpowBudSummaryRec."No." := ManpowBudLineRec."No.";
                        ManpowBudSummaryRec."Category Name" := 'Sample MC';
                        ManpowBudSummaryRec."Factory Name" := ManpowBudLineRec."Factory Name";
                        ManpowBudSummaryRec.Date := ManpowBudLineRec.Date;
                        ManpowBudSummaryRec.LineNo := LineNo1;
                        ManpowBudSummaryRec."Act Budget" := ManpowBudLineRec."Act Budget";
                        ManpowBudSummaryRec."Final Budget with Absenteesm" := ManpowBudLineRec."Final Budget with Absenteesm";
                        ManpowBudSummaryRec."Created User" := UserId;
                        ManpowBudSummaryRec."Created Date" := ManpowBudLineRec."Created Date";
                        ManpowBudSummaryRec.Insert();
                        Total1 += ManpowBudLineRec."Act Budget";
                        Total2 += ManpowBudLineRec."Final Budget with Absenteesm";
                    end;

                    if ManpowBudLineRec."Category Name" = 'Pilot Run Operators' then begin
                        LineNo1 += 1;
                        ManpowBudSummaryRec.Init();
                        ManpowBudSummaryRec."No." := ManpowBudLineRec."No.";
                        ManpowBudSummaryRec."Category Name" := 'Pilot MC';
                        ManpowBudSummaryRec."Factory Name" := ManpowBudLineRec."Factory Name";
                        ManpowBudSummaryRec.Date := ManpowBudLineRec.Date;
                        ManpowBudSummaryRec.LineNo := LineNo1;
                        ManpowBudSummaryRec."Act Budget" := ManpowBudLineRec."Act Budget";
                        ManpowBudSummaryRec."Final Budget with Absenteesm" := ManpowBudLineRec."Final Budget with Absenteesm";
                        ManpowBudSummaryRec."Created User" := UserId;
                        ManpowBudSummaryRec."Created Date" := ManpowBudLineRec."Created Date";
                        ManpowBudSummaryRec.Insert();
                        Total1 += ManpowBudLineRec."Act Budget";
                        Total2 += ManpowBudLineRec."Final Budget with Absenteesm";
                    end;

                    if ManpowBudLineRec."Category Name" = 'Fin Machine Operator (14 lines)' then begin
                        LineNo1 += 1;
                        ManpowBudSummaryRec.Init();
                        ManpowBudSummaryRec."No." := ManpowBudLineRec."No.";
                        ManpowBudSummaryRec."Category Name" := 'Finishing MC';
                        ManpowBudSummaryRec."Factory Name" := ManpowBudLineRec."Factory Name";
                        ManpowBudSummaryRec.Date := ManpowBudLineRec.Date;
                        ManpowBudSummaryRec.LineNo := LineNo1;
                        ManpowBudSummaryRec."Act Budget" := ManpowBudLineRec."Act Budget";
                        ManpowBudSummaryRec."Final Budget with Absenteesm" := ManpowBudLineRec."Final Budget with Absenteesm";
                        ManpowBudSummaryRec."Created User" := UserId;
                        ManpowBudSummaryRec."Created Date" := ManpowBudLineRec."Created Date";
                        ManpowBudSummaryRec.Insert();
                        Total1 += ManpowBudLineRec."Act Budget";
                        Total2 += ManpowBudLineRec."Final Budget with Absenteesm";
                    end;

                    if ManpowBudLineRec."Department Name" = 'Grand Total (RMG)' then begin
                        GrandTotal1 := ManpowBudLineRec."Act Budget";
                        GrandTotal2 := ManpowBudLineRec."Final Budget with Absenteesm";
                    end;

                until ManpowBudLineRec.Next() = 0;

                LineNo1 += 1;
                ManpowBudSummaryRec.Init();
                ManpowBudSummaryRec."No." := ManpowBudLineRec."No.";
                ManpowBudSummaryRec."Category Name" := 'Total MC';
                ManpowBudSummaryRec."Factory Name" := ManpowBudLineRec."Factory Name";
                ManpowBudSummaryRec.Date := ManpowBudLineRec.Date;
                ManpowBudSummaryRec.LineNo := LineNo1;
                ManpowBudSummaryRec."Act Budget" := Total1;
                ManpowBudSummaryRec."Final Budget with Absenteesm" := Total2;
                ManpowBudSummaryRec."Created User" := UserId;
                ManpowBudSummaryRec."Created Date" := ManpowBudLineRec."Created Date";
                ManpowBudSummaryRec.Insert();

                LineNo1 += 1;
                ManpowBudSummaryRec.Init();
                ManpowBudSummaryRec."No." := ManpowBudLineRec."No.";
                ManpowBudSummaryRec."Category Name" := 'Total Manpower';
                ManpowBudSummaryRec."Factory Name" := "Factory Name";
                ManpowBudSummaryRec.Date := Date;
                ManpowBudSummaryRec.LineNo := LineNo1;
                ManpowBudSummaryRec."Act Budget" := GrandTotal1;
                ManpowBudSummaryRec."Final Budget with Absenteesm" := GrandTotal2;
                ManpowBudSummaryRec."Created User" := UserId;
                ManpowBudSummaryRec."Created Date" := ManpowBudLineRec."Created Date";
                ManpowBudSummaryRec.Insert();

                if (Total1 <> 0) and (Total2 <> 0) then begin
                    LineNo1 += 1;
                    ManpowBudSummaryRec.Init();
                    ManpowBudSummaryRec."No." := ManpowBudLineRec."No.";
                    ManpowBudSummaryRec."Category Name" := 'MMR';
                    ManpowBudSummaryRec."Factory Name" := "Factory Name";
                    ManpowBudSummaryRec.Date := Date;
                    ManpowBudSummaryRec.LineNo := LineNo1;
                    ManpowBudSummaryRec."Act Budget" := GrandTotal1 / Total1;
                    ManpowBudSummaryRec."Final Budget with Absenteesm" := GrandTotal2 / Total2;
                    ManpowBudSummaryRec."Created User" := UserId;
                    ManpowBudSummaryRec."Created Date" := ManpowBudLineRec."Created Date";
                    ManpowBudSummaryRec.Insert();
                end;
            end;

        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        ManpowBudLineRec: Record FactoryManpowerBudgetLine;
    begin
        ManpowBudLineRec.Reset();
        ManpowBudLineRec.SetRange("No.", "No.");
        if ManpowBudLineRec.FindSet() then begin
            ManpowBudLineRec.DeleteAll();
        end;
    end;


    procedure Cal()
    var
        ManpowBudLineRec: Record FactoryManpowerBudgetLine;
        DeptRec: Record Department;
        total: BigInteger;
    begin

        DeptRec.Reset();
        DeptRec.SetFilter("Show in Manpower Budget", '=%1', true);
        if DeptRec.FindSet() then begin

            repeat
                total := 0;
                //get total of the department
                ManpowBudLineRec.Reset();
                ManpowBudLineRec.SetRange("No.", "No.");
                ManpowBudLineRec.SetRange("Department Code", DeptRec."No.");
                ManpowBudLineRec.SetFilter(Type, '=%1', 0);

                if ManpowBudLineRec.FindSet() then begin
                    repeat
                        total += ManpowBudLineRec."Act Budget";
                    until ManpowBudLineRec.Next() = 0;
                end;

                //Update sub total of the department
                ManpowBudLineRec.Reset();
                ManpowBudLineRec.SetRange("No.", "No.");
                ManpowBudLineRec.SetRange("Department Code", DeptRec."No.");
                ManpowBudLineRec.SetFilter(Type, '=%1', 1);

                if ManpowBudLineRec.FindSet() then begin
                    ManpowBudLineRec."Act Budget" := total;
                    ManpowBudLineRec.Modify();
                end;
                total := 0;

                //get total of the "Final Budget with Absenteesm"
                ManpowBudLineRec.Reset();
                ManpowBudLineRec.SetRange("No.", "No.");
                ManpowBudLineRec.SetRange("Department Code", DeptRec."No.");
                ManpowBudLineRec.SetFilter(Type, '=%1', 0);

                if ManpowBudLineRec.FindSet() then begin
                    repeat
                        total += ManpowBudLineRec."Final Budget with Absenteesm";
                    until ManpowBudLineRec.Next() = 0;
                end;

                //Update sub total of the "Final Budget with Absenteesm"
                ManpowBudLineRec.Reset();
                ManpowBudLineRec.SetRange("No.", "No.");
                ManpowBudLineRec.SetRange("Department Code", DeptRec."No.");
                ManpowBudLineRec.SetFilter(Type, '=%1', 1);

                if ManpowBudLineRec.FindSet() then begin
                    ManpowBudLineRec."Final Budget with Absenteesm" := total;
                    ManpowBudLineRec.Modify();
                end;

            until DeptRec.Next() = 0;

            Cal_GrandTotal();
        end;

    end;

    procedure Cal_GrandTotal()
    var
        ManpowBudLineRec: Record FactoryManpowerBudgetLine;
        TotalActual: BigInteger;
        TotalBudgetFinalAbs: BigInteger;
        TotalCurrEnroll: BigInteger;
        TotalAbsent: BigInteger;
        Totalleave: BigInteger;
        TotalNetPresent: BigInteger;
        TotalExcess: BigInteger;
    begin
        //Get sub totals
        ManpowBudLineRec.Reset();
        ManpowBudLineRec.SetRange("No.", "No.");
        ManpowBudLineRec.SetFilter(Type, '=%1', 1);

        if ManpowBudLineRec.FindSet() then begin
            repeat
                TotalActual += ManpowBudLineRec."Act Budget";
                TotalBudgetFinalAbs += ManpowBudLineRec."Final Budget with Absenteesm";
                TotalCurrEnroll += ManpowBudLineRec."Current onrall";
                TotalAbsent += ManpowBudLineRec.Absent;
                Totalleave += ManpowBudLineRec.Leave;
                TotalNetPresent += ManpowBudLineRec."Net Present";
                TotalExcess += ManpowBudLineRec."Excess/Short";
            until ManpowBudLineRec.Next() = 0;
        end;

        //Update grand total
        ManpowBudLineRec.Reset();
        ManpowBudLineRec.SetRange("No.", "No.");
        ManpowBudLineRec.SetFilter(Type, '=%1', 2);

        if ManpowBudLineRec.FindSet() then begin
            repeat
                ManpowBudLineRec."Act Budget" := TotalActual;
                ManpowBudLineRec."Final Budget with Absenteesm" := TotalBudgetFinalAbs;
                ManpowBudLineRec."Current onrall" := TotalCurrEnroll;
                ManpowBudLineRec.Absent := TotalAbsent;
                ManpowBudLineRec.Leave := Totalleave;
                ManpowBudLineRec."Net Present" := TotalNetPresent;
                ManpowBudLineRec."Excess/Short" := TotalExcess;
                ManpowBudLineRec.Modify();
            until ManpowBudLineRec.Next() = 0;
        end;

    end;
}