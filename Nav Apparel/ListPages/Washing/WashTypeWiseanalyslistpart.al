page 51433 Washtypeanalys
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = WashtypeWiseanalysis;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    SourceTableView = sorting("line No") order(ascending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = all;
                    Caption = 'Seq No';
                    Visible = false;
                }

                field(WashType; Rec.WashType)
                {
                    ApplicationArea = All;
                    Caption = 'Wash Type';
                    StyleExpr = StyleExprTxt;
                }

                field(Jan; Rec.Jan)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Feb; Rec.Feb)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Mar; Rec.Mar)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Apr; Rec.Apr)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(May; Rec.May)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Jun; Rec.Jun)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Jul; Rec.Jul)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Aug; Rec.Aug)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Sep; Rec.Sep)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Oct; Rec.Oct)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
                field(Nov; Rec.Nov)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Dec; Rec.Dec)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        WashingMasterRec: Record WashingMaster;
        WashtypeWiseanalysisRec: Record WashtypeWiseanalysis;
        WashtypeWiseanalysis2Rec: Record WashtypeWiseanalysis;
        MonthNo: Integer;
        LineNo: BigInteger;
    begin

        LineNo := 0;

        WashtypeWiseanalysisRec.Reset();
        if WashtypeWiseanalysisRec.FindSet() then
            WashtypeWiseanalysisRec.DeleteAll(true);

        WashingMasterRec.Reset();

        if WashingMasterRec.FindSet() then begin
            repeat

                MonthNo := Date2DMY(WashingMasterRec."Shipment Date", 2);

                WashtypeWiseanalysisRec.Reset();
                WashtypeWiseanalysisRec.SetRange(WashType, WashingMasterRec."Wash Type");

                if not WashtypeWiseanalysisRec.FindSet() then begin

                    WashtypeWiseanalysisRec.Init();
                    LineNo += 1;
                    WashtypeWiseanalysisRec.WashType := WashingMasterRec."Wash Type";
                    WashtypeWiseanalysisRec."Line No" := LineNo;
                    WashtypeWiseanalysisRec."Record Type" := 'R';

                    if MonthNo = 1 then
                        WashtypeWiseanalysisRec.Jan := WashingMasterRec."Color Qty";
                    if MonthNo = 2 then
                        WashtypeWiseanalysisRec.Feb := WashingMasterRec."Color Qty";
                    if MonthNo = 3 then
                        WashtypeWiseanalysisRec.Mar := WashingMasterRec."Color Qty";
                    if MonthNo = 4 then
                        WashtypeWiseanalysisRec.Apr := WashingMasterRec."Color Qty";
                    if MonthNo = 5 then
                        WashtypeWiseanalysisRec.May := WashingMasterRec."Color Qty";
                    if MonthNo = 6 then
                        WashtypeWiseanalysisRec.Jun := WashingMasterRec."Color Qty";
                    if MonthNo = 7 then
                        WashtypeWiseanalysisRec.Jul := WashingMasterRec."Color Qty";
                    if MonthNo = 8 then
                        WashtypeWiseanalysisRec.Aug := WashingMasterRec."Color Qty";
                    if MonthNo = 9 then
                        WashtypeWiseanalysisRec.Sep := WashingMasterRec."Color Qty";
                    if MonthNo = 10 then
                        WashtypeWiseanalysisRec.Oct := WashingMasterRec."Color Qty";
                    if MonthNo = 11 then
                        WashtypeWiseanalysisRec.Nov := WashingMasterRec."Color Qty";
                    if MonthNo = 12 then
                        WashtypeWiseanalysisRec.Dec := WashingMasterRec."Color Qty";

                    WashtypeWiseanalysisRec.Total := WashtypeWiseanalysisRec.Total + WashingMasterRec."Color Qty";
                    WashtypeWiseanalysisRec.Insert();

                end
                else begin
                    if MonthNo = 1 then
                        WashtypeWiseanalysisRec.Jan := WashtypeWiseanalysisRec.Jan + WashingMasterRec."Color Qty";
                    if MonthNo = 2 then
                        WashtypeWiseanalysisRec.Feb := WashtypeWiseanalysisRec.Feb + WashingMasterRec."Color Qty";
                    if MonthNo = 3 then
                        WashtypeWiseanalysisRec.Mar := WashtypeWiseanalysisRec.Mar + WashingMasterRec."Color Qty";
                    if MonthNo = 4 then
                        WashtypeWiseanalysisRec.Apr := WashtypeWiseanalysisRec.Apr + WashingMasterRec."Color Qty";
                    if MonthNo = 5 then
                        WashtypeWiseanalysisRec.May := WashtypeWiseanalysisRec.May + WashingMasterRec."Color Qty";
                    if MonthNo = 6 then
                        WashtypeWiseanalysisRec.Jun := WashtypeWiseanalysisRec.Jun + WashingMasterRec."Color Qty";
                    if MonthNo = 7 then
                        WashtypeWiseanalysisRec.Jul := WashtypeWiseanalysisRec.Jul + WashingMasterRec."Color Qty";
                    if MonthNo = 8 then
                        WashtypeWiseanalysisRec.Aug := WashtypeWiseanalysisRec.Aug + WashingMasterRec."Color Qty";
                    if MonthNo = 9 then
                        WashtypeWiseanalysisRec.Sep := WashtypeWiseanalysisRec.Sep + WashingMasterRec."Color Qty";
                    if MonthNo = 10 then
                        WashtypeWiseanalysisRec.Oct := WashtypeWiseanalysisRec.Oct + WashingMasterRec."Color Qty";
                    if MonthNo = 11 then
                        WashtypeWiseanalysisRec.Nov := WashtypeWiseanalysisRec.Nov + WashingMasterRec."Color Qty";
                    if MonthNo = 12 then
                        WashtypeWiseanalysisRec.Dec := WashtypeWiseanalysisRec.Dec + WashingMasterRec."Color Qty";

                    WashtypeWiseanalysisRec.Total := WashtypeWiseanalysisRec.Total + WashingMasterRec."Color Qty";
                    WashtypeWiseanalysisRec.Modify(true);
                end;

                //Total Row Wise

                WashtypeWiseanalysis2Rec.Reset();
                WashtypeWiseanalysis2Rec.SetFilter("Record Type", '=%1', 'T');

                if not WashtypeWiseanalysis2Rec.FindSet() then begin

                    WashtypeWiseanalysis2Rec.Init();
                    WashtypeWiseanalysis2Rec."Line No" := 9999;
                    WashtypeWiseanalysis2Rec.WashType := 'Total';
                    WashtypeWiseanalysis2Rec."Record Type" := 'T';


                    if MonthNo = 1 then
                        WashtypeWiseanalysis2Rec.Jan := WashingMasterRec."Color Qty";
                    if MonthNo = 2 then
                        WashtypeWiseanalysis2Rec.Feb := WashingMasterRec."Color Qty";
                    if MonthNo = 3 then
                        WashtypeWiseanalysis2Rec.Mar := WashingMasterRec."Color Qty";
                    if MonthNo = 4 then
                        WashtypeWiseanalysis2Rec.Apr := WashingMasterRec."Color Qty";
                    if MonthNo = 5 then
                        WashtypeWiseanalysis2Rec.May := WashingMasterRec."Color Qty";
                    if MonthNo = 6 then
                        WashtypeWiseanalysis2Rec.Jun := WashingMasterRec."Color Qty";
                    if MonthNo = 7 then
                        WashtypeWiseanalysis2Rec.Jul := WashingMasterRec."Color Qty";
                    if MonthNo = 8 then
                        WashtypeWiseanalysis2Rec.Aug := WashingMasterRec."Color Qty";
                    if MonthNo = 9 then
                        WashtypeWiseanalysis2Rec.Sep := WashingMasterRec."Color Qty";
                    if MonthNo = 10 then
                        WashtypeWiseanalysis2Rec.Oct := WashingMasterRec."Color Qty";
                    if MonthNo = 11 then
                        WashtypeWiseanalysis2Rec.Nov := WashingMasterRec."Color Qty";
                    if MonthNo = 12 then
                        WashtypeWiseanalysis2Rec.Dec := WashingMasterRec."Color Qty";

                    WashtypeWiseanalysis2Rec.Total := WashingMasterRec."Color Qty";

                    WashtypeWiseanalysis2Rec.Insert();

                end
                else begin

                    if MonthNo = 1 then
                        WashtypeWiseanalysis2Rec.Jan := WashtypeWiseanalysis2Rec.Jan + WashingMasterRec."Color Qty";
                    if MonthNo = 2 then
                        WashtypeWiseanalysis2Rec.Feb := WashtypeWiseanalysis2Rec.Feb + WashingMasterRec."Color Qty";
                    if MonthNo = 3 then
                        WashtypeWiseanalysis2Rec.Mar := WashtypeWiseanalysis2Rec.Mar + WashingMasterRec."Color Qty";
                    if MonthNo = 4 then
                        WashtypeWiseanalysis2Rec.Apr := WashtypeWiseanalysis2Rec.Apr + WashingMasterRec."Color Qty";
                    if MonthNo = 5 then
                        WashtypeWiseanalysis2Rec.May := WashtypeWiseanalysis2Rec.May + WashingMasterRec."Color Qty";
                    if MonthNo = 6 then
                        WashtypeWiseanalysis2Rec.Jun := WashtypeWiseanalysis2Rec.Jun + WashingMasterRec."Color Qty";
                    if MonthNo = 7 then
                        WashtypeWiseanalysis2Rec.Jul := WashtypeWiseanalysis2Rec.Jul + WashingMasterRec."Color Qty";
                    if MonthNo = 8 then
                        WashtypeWiseanalysis2Rec.Aug := WashtypeWiseanalysis2Rec.Aug + WashingMasterRec."Color Qty";
                    if MonthNo = 9 then
                        WashtypeWiseanalysis2Rec.Sep := WashtypeWiseanalysis2Rec.Sep + WashingMasterRec."Color Qty";
                    if MonthNo = 10 then
                        WashtypeWiseanalysis2Rec.Oct := WashtypeWiseanalysis2Rec.Oct + WashingMasterRec."Color Qty";
                    if MonthNo = 11 then
                        WashtypeWiseanalysis2Rec.Nov := WashtypeWiseanalysis2Rec.Nov + WashingMasterRec."Color Qty";
                    if MonthNo = 12 then
                        WashtypeWiseanalysis2Rec.Dec := WashtypeWiseanalysis2Rec.Dec + WashingMasterRec."Color Qty";

                    WashtypeWiseanalysis2Rec.Total := WashtypeWiseanalysis2Rec.Total + WashingMasterRec."Color Qty";

                    WashtypeWiseanalysis2Rec.Modify()

                end;

            until WashingMasterRec.Next() = 0;
        end;
    end;

    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorWashinAnlyse1(Rec);
    end;


    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;
}