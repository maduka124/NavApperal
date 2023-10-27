page 51434 WashTypeAndFactWisecard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Washin Factory And Type Wise Analyse';

    layout
    {
        area(Content)
        {
            group("Wash Type Wise Analyse")
            {
                part(Washtypeanalys; Washtypeanalys)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }

            group("Washing Factory Wise Analyse")
            {
                field(WashFactory; WashFactory)
                {
                    ApplicationArea = All;
                    Caption = 'Washing Factory';
                    TableRelation = Location.Code where("Plant Type Name" = filter('WASHING UNIT'));

                    trigger OnValidate()
                    var
                        WashingMasterRec: Record WashingMaster;
                        WashtypeWiseanalysisRec: Record WashFactoryWiseanalysisTbl;
                        WashtypeWiseanalysis2Rec: Record WashFactoryWiseanalysisTbl;
                        MonthNo: Integer;
                        LocationName: Text;
                        locationRec: Record Location;
                        LineNo: BigInteger;
                    begin

                        LineNo := 0;

                        WashtypeWiseanalysisRec.Reset();
                        if WashtypeWiseanalysisRec.FindSet() then
                            WashtypeWiseanalysisRec.DeleteAll(true);

                        WashingMasterRec.Reset();
                        WashingMasterRec.SetRange("Washing Plant Code", WashFactory);

                        if WashingMasterRec.FindSet() then begin
                            repeat

                                MonthNo := Date2DMY(WashingMasterRec."Shipment Date", 2);

                                WashtypeWiseanalysisRec.Reset();
                                WashtypeWiseanalysisRec.SetRange("Wash Type", WashingMasterRec."Wash Type");

                                if not WashtypeWiseanalysisRec.FindSet() then begin

                                    WashtypeWiseanalysisRec.Init();
                                    LineNo += 1;
                                    WashtypeWiseanalysisRec."Wash Type" := WashingMasterRec."Wash Type";
                                    WashtypeWiseanalysisRec."Line No" := LineNo;
                                    WashtypeWiseanalysis2Rec."Record Type" := 'T';

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
                                        WashtypeWiseanalysisRec.Dec := WashtypeWiseanalysisRec.Nov + WashingMasterRec."Color Qty";

                                    WashtypeWiseanalysisRec.Total := WashtypeWiseanalysisRec.Total + WashingMasterRec."Color Qty";
                                    WashtypeWiseanalysisRec.Modify(true);

                                end;

                                WashtypeWiseanalysis2Rec.Reset();
                                WashtypeWiseanalysis2Rec.SetFilter("Record Type", '=%1', 'T');

                                if not WashtypeWiseanalysis2Rec.FindSet() then begin

                                    WashtypeWiseanalysis2Rec.Init();
                                    WashtypeWiseanalysis2Rec."Line No" := 9999;
                                    WashtypeWiseanalysis2Rec."Wash Type" := 'Total';
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
                }
            }

            group("  ")
            {
                part(WashFacWiseanalyis; WashFacWiseanalyis)
                {
                    ApplicationArea = all;
                    Caption = ' ';
                }
            }
        }
    }

    var
        WashFactory: Text[100];
}