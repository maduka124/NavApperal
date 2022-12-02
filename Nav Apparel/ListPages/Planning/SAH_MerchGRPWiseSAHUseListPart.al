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
                field("Group Name"; "Group Name")
                {
                    ApplicationArea = All;
                }

                field("Allocated Lines"; "Allocated Lines")
                {
                    ApplicationArea = All;
                }

                field("Allocated SAH"; "Allocated SAH")
                {
                    ApplicationArea = All;
                }

                field("Used SAH"; "Used SAH")
                {
                    ApplicationArea = All;
                }

                field("Difference Hrs"; "Difference Hrs")
                {
                    ApplicationArea = All;
                }

                field("Avg SMV"; "Avg SMV")
                {
                    ApplicationArea = All;
                }

                field("Capacity Pcs"; "Capacity Pcs")
                {
                    ApplicationArea = All;
                }

                field("Booked Pcs"; "Booked Pcs")
                {
                    ApplicationArea = All;
                }

                field("Difference Pcs"; "Difference Pcs")
                {
                    ApplicationArea = All;
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
    begin

        if YearNo <= 0 then
            Error('Invalid Year.');

        if MonthName = '' then
            Error('Invalid Month.');


        //Delete old records for the user
        SAH_MerchGRPWiseSAHUsedRec.Reset();
        SAH_MerchGRPWiseSAHUsedRec.SetRange("User ID", UserId);
        if SAH_MerchGRPWiseSAHUsedRec.FindSet() then
            SAH_MerchGRPWiseSAHUsedRec.DeleteAll();

        //Get max no
        SAH_MerchGRPWiseSAHUsedRec.Reset();
        if SAH_MerchGRPWiseSAHUsedRec.FindLast() then
            MaxNo := SAH_MerchGRPWiseSAHUsedRec.No;


        //Insert all group heads
        MerchanGroupTableRec.Reset();
        if MerchanGroupTableRec.FindSet() then begin
            repeat

                MaxNo += 1;

                //Get Allocated lines
                AlloLines := 0;
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

                SAH_MerchGRPWiseSAHUsedRec."Avg SMV" := AvgSMV;
                SAH_MerchGRPWiseSAHUsedRec."User ID" := UserId;
                SAH_MerchGRPWiseSAHUsedRec."Created User" := UserId;
                SAH_MerchGRPWiseSAHUsedRec."Created Date" := WorkDate();
                SAH_MerchGRPWiseSAHUsedRec.Insert();

            until MerchanGroupTableRec.Next() = 0;
        end;

        Message('Completed');
    end;

    var
        YearNo: Integer;
        MonthNo: Integer;
        MonthName: Text[20];

}