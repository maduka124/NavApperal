report 51340 CapacityByPcsGroupWiseReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Month Wise Merchant Group Booking Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/CapacityByPcsGroupWiseReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(BuyerWiseOrderBookinGRWiseBook; BuyerWiseOrderBookinGRWiseBook)
        {
            DataItemTableView = sorting("Group Name") order(ascending);

            column(YearVar; YearVar)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Group_Name; "Group Name")
            { }
            column(GroupHead; "Group Head")
            { }
            column(JAN; JAN)
            { }
            column(FEB; FEB)
            { }
            column(MAR; MAR)
            { }
            column(APR; APR)
            { }
            column(MAY; MAY)
            { }
            column(JUN; JUN)
            { }
            column(JUL; JUL)
            { }
            column(AUG; AUG)
            { }
            column(SEP; SEP)
            { }
            column(OCT; OCT)
            { }
            column(NOV; NOV)
            { }
            column(DEC; DEC)
            { }
            column(Total; Total)
            { }
            column(JAN_FOB; JAN_FOB)
            { }
            column(FEB_FOB; FEB_FOB)
            { }
            column(MAR_FOB; MAR_FOB)
            { }
            column(APR_FOB; APR_FOB)
            { }
            column(MAY_FOB; MAY_FOB)
            { }
            column(JUN_FOB; JUN_FOB)
            { }
            column(JUL_FOB; JUL_FOB)
            { }
            column(AUG_FOB; AUG_FOB)
            { }
            column(SEP_FOB; SEP_FOB)
            { }
            column(OCT_FOB; OCT_FOB)
            { }
            column(NOV_FOB; NOV_FOB)
            { }
            column(DEC_FOB; DEC_FOB)
            { }
            column(Total_FOB; Total_FOB)
            { }
            column(Created_User; UserId)
            { }


            trigger OnPreDataItem()
            begin
                SetRange(Year, YearVar);
                SetFilter("Group Name", '<>%1', 'Total');
            end;

            trigger OnAfterGetRecord()
            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filter)
                {
                    field(YearVar; YearVar)
                    {
                        ApplicationArea = All;
                        Caption = 'Year';
                        TableRelation = YearTable.Year;

                        trigger OnValidate()
                        var
                        begin
                            if YearVar < 2023 then
                                Error('Invalid date.');
                        end;
                    }
                }
            }
        }
    }

    trigger OnInitReport()
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

        YearVar := Y;
    end;


    trigger OnPreReport()
    var
        CodeUnit2Rec: Codeunit NavAppCodeUnit2;
    begin
        if YearVar >= 2023 then
            CodeUnit2Rec.CapacityByPcsReports(YearVar, 4)
        else
            Error('Invalid date.');
    end;


    var
        YearVar: Integer;
        comRec: Record "Company Information";
}