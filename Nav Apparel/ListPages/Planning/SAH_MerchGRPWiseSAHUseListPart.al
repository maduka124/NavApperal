page 50874 SAH_MerchGRPWiseSAHUseListPart
{
    PageType = ListPart;
    SourceTable = SAH_MerchGRPWiseSAHUsed;
    SourceTableView = sorting(No) order(ascending);
    Caption = ' ';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            group(" ")
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

            repeater(General)
            {
                field("Group Name"; rec."Group Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Group Id"; rec."Group Id")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Allocated Lines"; rec."Allocated Lines")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Allocated SAH"; rec."Allocated SAH")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field("Used SAH"; rec."Used SAH")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field("Difference Hrs"; rec."Difference Hrs")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field("Avg SMV"; rec."Avg SMV")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                    DecimalPlaces = 0;
                }

                field("Capacity Pcs"; rec."Capacity Pcs")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;

                }

                field("Booked Pcs"; rec."Booked Pcs")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExprTxt;
                }

                field("Difference Pcs"; rec."Difference Pcs")
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
            action("Generate Data")
            {
                ApplicationArea = All;
                Image = CreateYear;

                trigger OnAction();
                var
                begin
                    Generate();
                end;
            }
        }
    }

    procedure Generate()
    var
        MerchanGroupTableRec: Record MerchandizingGroupTable;
        SAH_MerchGRPWiseSAHUsedRec: Record SAH_MerchGRPWiseSAHUsed;
        CapacityAlloRec: Record SAH_CapacityAllocation;
        MerchGRPWiseAlloRec: Record SAH_MerchGRPWiseAllocation;
        MerchGRPWiseBalRec: Record SAH_MerchGRPWiseBalance;
        MerchGRPWiseAvgSMVRec: Record SAH_MerchGRPWiseAvgSMV;
        MaxNo: BigInteger;
        AlloLines: Integer;
        AlloSAH: Decimal;
        SAHUsed: Decimal;
        AvgSMV: Decimal;
        DefPsc: BigInteger;
        BookPsc: BigInteger;
    begin

        if YearNo <= 0 then
            Error('Invalid Year.');

        if MonthName = '' then
            Error('Invalid Month.');


        //Delete old records for the user
        SAH_MerchGRPWiseSAHUsedRec.Reset();
        //SAH_MerchGRPWiseSAHUsedRec.SetRange("User ID", UserId);
        SAH_MerchGRPWiseSAHUsedRec.SetRange(Year, YearNo);
        if SAH_MerchGRPWiseSAHUsedRec.FindSet() then
            SAH_MerchGRPWiseSAHUsedRec.DeleteAll();

        //Delete old records year = 0
        SAH_MerchGRPWiseSAHUsedRec.Reset();
        SAH_MerchGRPWiseSAHUsedRec.SetRange(Year, 0);
        if SAH_MerchGRPWiseSAHUsedRec.FindSet() then
            SAH_MerchGRPWiseSAHUsedRec.DeleteAll();

        // SAH_MerchGRPWiseSAHUsedRec.Reset();
        // SAH_MerchGRPWiseSAHUsedRec.FindSet();
        // if SAH_MerchGRPWiseSAHUsedRec.FindSet() then
        //     // SAH_MerchGRPWiseSAHUsedRec.DeleteAll();

        //Get max no
        SAH_MerchGRPWiseSAHUsedRec.Reset();
        if SAH_MerchGRPWiseSAHUsedRec.FindLast() then
            MaxNo := SAH_MerchGRPWiseSAHUsedRec.No;

        Var1 := 0;
        Var2 := 0;
        Var3 := 0;
        Var4 := 0;
        Var5 := 0;
        Var6 := 0;
        Var7 := 0;
        var8 := 0;



        //Insert all group heads
        MerchanGroupTableRec.Reset();
        if MerchanGroupTableRec.FindSet() then begin
            repeat

                MaxNo += 1;

                //Get Allocated lines
                AlloLines := 0;
                AvgSMV := 0;
                CapacityAlloRec.Reset();
                CapacityAlloRec.SetRange(Year, YearNo);
                case MonthNo of
                    1:
                        CapacityAlloRec.Setfilter(JAN, '=%1', MerchanGroupTableRec."Group Id");
                    2:
                        CapacityAlloRec.Setfilter(FEB, '=%1', MerchanGroupTableRec."Group Id");
                    3:
                        CapacityAlloRec.Setfilter(MAR, '=%1', MerchanGroupTableRec."Group Id");
                    4:
                        CapacityAlloRec.Setfilter(APR, '=%1', MerchanGroupTableRec."Group Id");
                    5:
                        CapacityAlloRec.Setfilter(MAY, '=%1', MerchanGroupTableRec."Group Id");
                    6:
                        CapacityAlloRec.Setfilter(JUN, '=%1', MerchanGroupTableRec."Group Id");
                    7:
                        CapacityAlloRec.Setfilter(JUL, '=%1', MerchanGroupTableRec."Group Id");
                    8:
                        CapacityAlloRec.Setfilter(AUG, '=%1', MerchanGroupTableRec."Group Id");
                    9:
                        CapacityAlloRec.Setfilter(SEP, '=%1', MerchanGroupTableRec."Group Id");
                    10:
                        CapacityAlloRec.Setfilter(OCT, '=%1', MerchanGroupTableRec."Group Id");
                    11:
                        CapacityAlloRec.Setfilter(NOV, '=%1', MerchanGroupTableRec."Group Id");
                    12:
                        CapacityAlloRec.Setfilter(DEC, '=%1', MerchanGroupTableRec."Group Id");
                end;
                if CapacityAlloRec.FindSet() then
                    AlloLines := CapacityAlloRec.Count;


                //Get Allocated SAH
                MerchGRPWiseAlloRec.Reset();
                MerchGRPWiseAlloRec.SetRange(Year, YearNo);
                MerchGRPWiseAlloRec.SetRange("Group Id", MerchanGroupTableRec."Group Id");
                if MerchGRPWiseAlloRec.FindSet() then begin
                    case MonthNo of
                        1:
                            AlloSAH := MerchGRPWiseAlloRec.JAN;
                        2:
                            AlloSAH := MerchGRPWiseAlloRec.FEB;
                        3:
                            AlloSAH := MerchGRPWiseAlloRec.MAR;
                        4:
                            AlloSAH := MerchGRPWiseAlloRec.APR;
                        5:
                            AlloSAH := MerchGRPWiseAlloRec.MAY;
                        6:
                            AlloSAH := MerchGRPWiseAlloRec.JUN;
                        7:
                            AlloSAH := MerchGRPWiseAlloRec.JUL;
                        8:
                            AlloSAH := MerchGRPWiseAlloRec.AUG;
                        9:
                            AlloSAH := MerchGRPWiseAlloRec.SEP;
                        10:
                            AlloSAH := MerchGRPWiseAlloRec.OCT;
                        11:
                            AlloSAH := MerchGRPWiseAlloRec.NOV;
                        12:
                            AlloSAH := MerchGRPWiseAlloRec.DEC;
                    end;
                end;


                //Get Used SAH
                MerchGRPWiseBalRec.Reset();
                MerchGRPWiseBalRec.SetRange(Year, YearNo);
                MerchGRPWiseBalRec.SetRange("Group Id", MerchanGroupTableRec."Group Id");
                if MerchGRPWiseBalRec.FindSet() then begin
                    case MonthNo of
                        1:
                            SAHUsed := MerchGRPWiseBalRec.JAN_Utilized;
                        2:
                            SAHUsed := MerchGRPWiseBalRec.FEB_Utilized;
                        3:
                            SAHUsed := MerchGRPWiseBalRec.MAR_Utilized;
                        4:
                            SAHUsed := MerchGRPWiseBalRec.APR_Utilized;
                        5:
                            SAHUsed := MerchGRPWiseBalRec.MAY_Utilized;
                        6:
                            SAHUsed := MerchGRPWiseBalRec.JUN_Utilized;
                        7:
                            SAHUsed := MerchGRPWiseBalRec.JUL_Utilized;
                        8:
                            SAHUsed := MerchGRPWiseBalRec.AUG_Utilized;
                        9:
                            SAHUsed := MerchGRPWiseBalRec.SEP_Utilized;
                        10:
                            SAHUsed := MerchGRPWiseBalRec.OCT_Utilized;
                        11:
                            SAHUsed := MerchGRPWiseBalRec.NOV_Utilized;
                        12:
                            SAHUsed := MerchGRPWiseBalRec.DEC_Utilized;
                    end;
                end;


                //Get Avg SMV
                MerchGRPWiseAvgSMVRec.Reset();
                MerchGRPWiseAvgSMVRec.SetRange(Year, YearNo);
                MerchGRPWiseAvgSMVRec.SetRange("Group Id", MerchanGroupTableRec."Group Id");
                if MerchGRPWiseAvgSMVRec.FindSet() then begin
                    case MonthNo of
                        1:
                            AvgSMV := MerchGRPWiseAvgSMVRec.JAN;
                        2:
                            AvgSMV := MerchGRPWiseAvgSMVRec.FEB;
                        3:
                            AvgSMV := MerchGRPWiseAvgSMVRec.MAR;
                        4:
                            AvgSMV := MerchGRPWiseAvgSMVRec.APR;
                        5:
                            AvgSMV := MerchGRPWiseAvgSMVRec.MAY;
                        6:
                            AvgSMV := MerchGRPWiseAvgSMVRec.JUN;
                        7:
                            AvgSMV := MerchGRPWiseAvgSMVRec.JUL;
                        8:
                            AvgSMV := MerchGRPWiseAvgSMVRec.AUG;
                        9:
                            AvgSMV := MerchGRPWiseAvgSMVRec.SEP;
                        10:
                            AvgSMV := MerchGRPWiseAvgSMVRec.OCT;
                        11:
                            AvgSMV := MerchGRPWiseAvgSMVRec.NOV;
                        12:
                            AvgSMV := MerchGRPWiseAvgSMVRec.DEC;
                    end;
                end;

                SAH_MerchGRPWiseSAHUsedRec.Init();
                SAH_MerchGRPWiseSAHUsedRec.No := MaxNo;
                SAH_MerchGRPWiseSAHUsedRec.Year := YearNo;
                SAH_MerchGRPWiseSAHUsedRec."Month Name" := MonthName;
                SAH_MerchGRPWiseSAHUsedRec."Month No" := MonthNo;
                SAH_MerchGRPWiseSAHUsedRec."Group Id" := MerchanGroupTableRec."Group Id";
                SAH_MerchGRPWiseSAHUsedRec."Group Head" := MerchanGroupTableRec."Group Head";
                SAH_MerchGRPWiseSAHUsedRec."Group Name" := MerchanGroupTableRec."Group Name";
                SAH_MerchGRPWiseSAHUsedRec."Allocated Lines" := AlloLines;
                SAH_MerchGRPWiseSAHUsedRec."Allocated SAH" := AlloSAH;
                SAH_MerchGRPWiseSAHUsedRec."Used SAH" := SAHUsed;
                SAH_MerchGRPWiseSAHUsedRec."Difference Hrs" := SAHUsed - AlloSAH;

                if AvgSMV <> 0 then begin
                    SAH_MerchGRPWiseSAHUsedRec."Capacity Pcs" := round((AlloSAH * 60) / AvgSMV, 1);
                    SAH_MerchGRPWiseSAHUsedRec."Booked Pcs" := round((SAHUsed * 60) / AvgSMV, 1);
                    SAH_MerchGRPWiseSAHUsedRec."Difference Pcs" := round(((SAHUsed * 60) / AvgSMV) - ((AlloSAH * 60) / AvgSMV), 1);
                end
                else begin
                    SAH_MerchGRPWiseSAHUsedRec."Capacity Pcs" := 0;
                    SAH_MerchGRPWiseSAHUsedRec."Booked Pcs" := 0;
                    SAH_MerchGRPWiseSAHUsedRec."Difference Pcs" := 0;
                end;

                BookPsc := SAH_MerchGRPWiseSAHUsedRec."Booked Pcs";
                DefPsc := SAH_MerchGRPWiseSAHUsedRec."Difference Pcs";
                SAH_MerchGRPWiseSAHUsedRec."Avg SMV" := AvgSMV;
                SAH_MerchGRPWiseSAHUsedRec."User ID" := UserId;
                SAH_MerchGRPWiseSAHUsedRec."Created User" := UserId;
                SAH_MerchGRPWiseSAHUsedRec."Created Date" := WorkDate();
                SAH_MerchGRPWiseSAHUsedRec.Insert();



                Var1 := Var1 + AlloLines;
                Var2 := Var2 + round(AlloSAH, 1);
                Var3 := Var3 + round(SAHUsed, 1);
                Var4 := Var4 + round(SAHUsed, 1) - round(AlloSAH, 1);
                Var5 := Var5 + round(AvgSMV, 1);
                Var6 := Var6 + SAH_MerchGRPWiseSAHUsedRec."Capacity Pcs";
                Var7 := Var7 + SAH_MerchGRPWiseSAHUsedRec."Booked Pcs";
                var8 := var8 + DefPsc;

            // SAH_MerchGRPWiseSAHUsedRec.Reset();
            // SAH_MerchGRPWiseSAHUsedRec.SetRange(Year, Rec.Year);
            // SAH_MerchGRPWiseSAHUsedRec.SetFilter("Group Name", '%1', 'Total');

            // if SAH_MerchGRPWiseSAHUsedRec.FindSet() then begin
            //     SAH_MerchGRPWiseSAHUsedRec."Allocated Lines" := SAH_MerchGRPWiseSAHUsedRec."Allocated Lines" + AlloLines;
            //     SAH_MerchGRPWiseSAHUsedRec."Allocated SAH" := SAH_MerchGRPWiseSAHUsedRec."Allocated SAH" + AlloSAH;
            //     SAH_MerchGRPWiseSAHUsedRec."Used SAH" := SAH_MerchGRPWiseSAHUsedRec."Used SAH" + SAHUsed;
            //     SAH_MerchGRPWiseSAHUsedRec."Difference Hrs" := SAH_MerchGRPWiseSAHUsedRec."Difference Hrs" + (SAHUsed - AlloSAH);
            //     SAH_MerchGRPWiseSAHUsedRec."Avg SMV" := SAH_MerchGRPWiseSAHUsedRec."Avg SMV" + AvgSMV;
            //     SAH_MerchGRPWiseSAHUsedRec."Capacity Pcs" := SAH_MerchGRPWiseSAHUsedRec."Capacity Pcs" + SAH_MerchGRPWiseSAHUsedRec."Capacity Pcs";
            //     SAH_MerchGRPWiseSAHUsedRec."Booked Pcs" := SAH_MerchGRPWiseSAHUsedRec."Booked Pcs" + SAH_MerchGRPWiseSAHUsedRec."Booked Pcs";
            //     SAH_MerchGRPWiseSAHUsedRec."Difference Pcs" := SAH_MerchGRPWiseSAHUsedRec."Difference Pcs" + DefPsc;
            //     SAH_MerchGRPWiseSAHUsedRec.Modify();

            // end;


            until MerchanGroupTableRec.Next() = 0;

            //Grand total insert 
            MaxNo += 1;
            SAH_MerchGRPWiseSAHUsedRec.Init();
            SAH_MerchGRPWiseSAHUsedRec.No := MaxNo;
            SAH_MerchGRPWiseSAHUsedRec.Year := YearNo;
            SAH_MerchGRPWiseSAHUsedRec.Type := 'T';
            SAH_MerchGRPWiseSAHUsedRec."Group Name" := 'Total';
            SAH_MerchGRPWiseSAHUsedRec."Month Name" := MonthName;
            SAH_MerchGRPWiseSAHUsedRec."Allocated Lines" := Var1;
            SAH_MerchGRPWiseSAHUsedRec."Allocated SAH" := Var2;
            SAH_MerchGRPWiseSAHUsedRec."Used SAH" := Var3;
            SAH_MerchGRPWiseSAHUsedRec."Difference Hrs" := Var4;
            SAH_MerchGRPWiseSAHUsedRec."Avg SMV" := Var5;
            SAH_MerchGRPWiseSAHUsedRec."Capacity Pcs" := Var6;
            SAH_MerchGRPWiseSAHUsedRec."Booked Pcs" := Var7;
            SAH_MerchGRPWiseSAHUsedRec."Difference Pcs" := var8;
            SAH_MerchGRPWiseSAHUsedRec."User ID" := UserId;
            SAH_MerchGRPWiseSAHUsedRec."Created User" := UserId;
            SAH_MerchGRPWiseSAHUsedRec."Created Date" := WorkDate();
            SAH_MerchGRPWiseSAHUsedRec.Insert();
        end;

        Message('Completed');
    end;

    var
        YearNo: Integer;
        MonthNo: Integer;
        MonthName: Text[20];
        Var1: BigInteger;
        Var2: Decimal;
        Var3: Decimal;
        Var4: Decimal;
        Var5: Decimal;
        Var6: BigInteger;
        Var7: BigInteger;
        var8: BigInteger;


    trigger OnAfterGetRecord()
    var
    begin
        StyleExprTxt := ChangeColor.ChangeColorBooking7(Rec);
    end;

    var
        StyleExprTxt: Text[50];
        ChangeColor: Codeunit NavAppCodeUnit;


}