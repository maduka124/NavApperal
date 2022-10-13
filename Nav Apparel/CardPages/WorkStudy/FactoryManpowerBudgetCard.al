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
        Dept_desigRec: Record Dept_Designations;
        LineNo: BigInteger;
        DeptTempCode: Code[50];
        DeptTempName: Text[50];
    begin

        if ("Factory Name" <> '') and (Date <> 0D) then begin

            ManpowBudLineRec.Reset();
            ManpowBudLineRec.SetRange("No.", "No.");
            if not ManpowBudLineRec.FindSet() then begin

                Dept_desigRec.Reset();
                Dept_desigRec.SetCurrentKey("Department Name", "Designations Name");
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
                    ManpowBudLine1Rec."Department Name" := 'Grand Total(RMG)';
                    ManpowBudLine1Rec.Type := ManpowBudLineRec.Type::GT;
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
                            ManpowBudLineRec."Department Name" := DeptTempName;
                            ManpowBudLineRec.Type := ManpowBudLineRec.Type::ST;
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
                        ManpowBudLineRec."Designations No." := Dept_desigRec."Designations No.";
                        ManpowBudLineRec."Designations Name" := Dept_desigRec."Designations Name";
                        ManpowBudLineRec.Type := ManpowBudLineRec.Type::DL;
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
                    ManpowBudLineRec."Department Name" := 'Grand Total(RMG)';
                    ManpowBudLineRec.Type := ManpowBudLineRec.Type::GT;
                    ManpowBudLineRec.Insert();

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
}