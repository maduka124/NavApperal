page 50816 FactoryManpowerBudgetListPart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = FactoryManpowerBudgetLine;
    SourceTableView = sorting(LineNo);
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                }

                field("Designations Name"; "Designations Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = false;
                }

                field("Act Budget"; "Act Budget")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                        ManpowBudLineRec: Record FactoryManpowerBudgetLine;
                        total: BigInteger;
                    begin
                        CurrPage.Update();
                        "Final Budget with Absenteesm" := round("Act Budget" * 1.05, 1);
                        CurrPage.Update();

                        //get total of the department
                        ManpowBudLineRec.Reset();
                        ManpowBudLineRec.SetRange("No.", "No.");
                        ManpowBudLineRec.SetRange("Department Code", "Department Code");
                        ManpowBudLineRec.SetFilter(Type, '=%1', 0);

                        if ManpowBudLineRec.FindSet() then begin
                            repeat
                                total += ManpowBudLineRec."Act Budget";
                            until ManpowBudLineRec.Next() = 0;
                        end;

                        //Update sub total of the department
                        ManpowBudLineRec.Reset();
                        ManpowBudLineRec.SetRange("No.", "No.");
                        ManpowBudLineRec.SetRange("Department Code", "Department Code");
                        ManpowBudLineRec.SetFilter(Type, '=%1', 1);

                        if ManpowBudLineRec.FindSet() then begin
                            ManpowBudLineRec."Act Budget" := total;
                            ManpowBudLineRec.Modify();
                        end;
                        total := 0;

                        //get total of the "Final Budget with Absenteesm"
                        ManpowBudLineRec.Reset();
                        ManpowBudLineRec.SetRange("No.", "No.");
                        ManpowBudLineRec.SetRange("Department Code", "Department Code");
                        ManpowBudLineRec.SetFilter(Type, '=%1', 0);

                        if ManpowBudLineRec.FindSet() then begin
                            repeat
                                total += ManpowBudLineRec."Final Budget with Absenteesm";
                            until ManpowBudLineRec.Next() = 0;
                        end;

                        //Update sub total of the "Final Budget with Absenteesm"
                        ManpowBudLineRec.Reset();
                        ManpowBudLineRec.SetRange("No.", "No.");
                        ManpowBudLineRec.SetRange("Department Code", "Department Code");
                        ManpowBudLineRec.SetFilter(Type, '=%1', 1);

                        if ManpowBudLineRec.FindSet() then begin
                            ManpowBudLineRec."Final Budget with Absenteesm" := total;
                            ManpowBudLineRec.Modify();
                        end;

                        CurrPage.Update();
                        Cal_GrandTotal();

                    end;
                }

                field("Final Budget with Absenteesm"; "Final Budget with Absenteesm")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Current onrall"; "Current onrall")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                        ManpowBudLineRec: Record FactoryManpowerBudgetLine;
                        total: BigInteger;
                    begin
                        CurrPage.Update();
                        "Excess/Short" := "Current onrall" - "Final Budget with Absenteesm";
                        Cal();

                        //get total of the department
                        ManpowBudLineRec.Reset();
                        ManpowBudLineRec.SetRange("No.", "No.");
                        ManpowBudLineRec.SetRange("Department Code", "Department Code");
                        ManpowBudLineRec.SetFilter(Type, '=%1', 0);

                        if ManpowBudLineRec.FindSet() then begin
                            repeat
                                total += ManpowBudLineRec."Current onrall";
                            until ManpowBudLineRec.Next() = 0;
                        end;

                        //Update sub total of the department
                        ManpowBudLineRec.Reset();
                        ManpowBudLineRec.SetRange("No.", "No.");
                        ManpowBudLineRec.SetRange("Department Code", "Department Code");
                        ManpowBudLineRec.SetFilter(Type, '=%1', 1);

                        if ManpowBudLineRec.FindSet() then begin
                            ManpowBudLineRec."Current onrall" := total;
                            ManpowBudLineRec.Modify();
                        end;

                        CurrPage.Update();
                        Cal_GrandTotal();

                    end;
                }

                field(Absent; Absent)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                        ManpowBudLineRec: Record FactoryManpowerBudgetLine;
                        total: BigInteger;
                    begin
                        CurrPage.Update();
                        Cal();

                        //get total of the department
                        ManpowBudLineRec.Reset();
                        ManpowBudLineRec.SetRange("No.", "No.");
                        ManpowBudLineRec.SetRange("Department Code", "Department Code");
                        ManpowBudLineRec.SetFilter(Type, '=%1', 0);

                        if ManpowBudLineRec.FindSet() then begin
                            repeat
                                total += ManpowBudLineRec."Absent";
                            until ManpowBudLineRec.Next() = 0;
                        end;

                        //Update sub total of the department
                        ManpowBudLineRec.Reset();
                        ManpowBudLineRec.SetRange("No.", "No.");
                        ManpowBudLineRec.SetRange("Department Code", "Department Code");
                        ManpowBudLineRec.SetFilter(Type, '=%1', 1);

                        if ManpowBudLineRec.FindSet() then begin
                            ManpowBudLineRec."Absent" := total;
                            ManpowBudLineRec.Modify();
                        end;

                        CurrPage.Update();
                        Cal_GrandTotal();
                    end;
                }

                field(Leave; Leave)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;

                    trigger OnValidate()
                    var
                        ManpowBudLineRec: Record FactoryManpowerBudgetLine;
                        total: BigInteger;
                    begin
                        CurrPage.Update();
                        Cal();

                        //get total of the department
                        ManpowBudLineRec.Reset();
                        ManpowBudLineRec.SetRange("No.", "No.");
                        ManpowBudLineRec.SetRange("Department Code", "Department Code");
                        ManpowBudLineRec.SetFilter(Type, '=%1', 0);

                        if ManpowBudLineRec.FindSet() then begin
                            repeat
                                total += ManpowBudLineRec."Leave";
                            until ManpowBudLineRec.Next() = 0;
                        end;

                        //Update sub total of the department
                        ManpowBudLineRec.Reset();
                        ManpowBudLineRec.SetRange("No.", "No.");
                        ManpowBudLineRec.SetRange("Department Code", "Department Code");
                        ManpowBudLineRec.SetFilter(Type, '=%1', 1);

                        if ManpowBudLineRec.FindSet() then begin
                            ManpowBudLineRec."Leave" := total;
                            ManpowBudLineRec.Modify();
                        end;

                        CurrPage.Update();
                        Cal_GrandTotal();
                    end;
                }

                field("Net Present"; "Net Present")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field("Excess/Short"; "Excess/Short")
                {
                    ApplicationArea = All;
                    Editable = false;
                    StyleExpr = StyleExprTxt;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    Editable = SetEdit1;
                }
            }
        }
    }

    procedure Cal()
    var
        ManpowBudLineRec: Record FactoryManpowerBudgetLine;
        totalNet: BigInteger;
        totalExcess: BigInteger;
    begin
        "Net Present" := "Current onrall" - Absent - Leave;
        CurrPage.Update();

        //get total of the department
        ManpowBudLineRec.Reset();
        ManpowBudLineRec.SetRange("No.", "No.");
        ManpowBudLineRec.SetRange("Department Code", "Department Code");
        ManpowBudLineRec.SetFilter(Type, '=%1', 0);

        if ManpowBudLineRec.FindSet() then begin
            repeat
                totalNet += ManpowBudLineRec."Net Present";
                totalExcess += ManpowBudLineRec."Excess/Short";
            until ManpowBudLineRec.Next() = 0;
        end;

        //Update sub total of the department
        ManpowBudLineRec.Reset();
        ManpowBudLineRec.SetRange("No.", "No.");
        ManpowBudLineRec.SetRange("Department Code", "Department Code");
        ManpowBudLineRec.SetFilter(Type, '=%1', 1);

        if ManpowBudLineRec.FindSet() then begin
            ManpowBudLineRec."Net Present" := totalNet;
            ManpowBudLineRec."Excess/Short" := totalExcess;
            ManpowBudLineRec.Modify();
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


    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
        SetEdit1: Boolean;


    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorManpoerBudget(Rec);

        if (Type = 1) or (Type = 2) then begin
            Clear(SetEdit1);
            SetEdit1 := false;
        end
        ELSE begin
            Clear(SetEdit1);
            SetEdit1 := true;
        end;
    end;


    trigger OnAfterGetCurrRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorManpoerBudget(Rec);

        if (Type = 1) or (Type = 2) then begin
            Clear(SetEdit1);
            SetEdit1 := false;
        end
        ELSE begin
            Clear(SetEdit1);
            SetEdit1 := true;
        end;
    end;
}