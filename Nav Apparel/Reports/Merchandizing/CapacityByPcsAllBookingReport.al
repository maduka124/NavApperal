report 51337 CapacityByPcsAllBookingReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Month Wise Order Booking Report';
    RDLCLayout = 'Report_Layouts/Merchandizing/CapacityByPcsAllBookingReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem(BuyerWiseOdrBookingAllBook; BuyerWiseOdrBookingAllBook)
        {
            DataItemTableView = sorting("No.", "Buyer Name") order(descending);

            column(YearVar; YearVar)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(Brand_Name; "Brand Name")
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
            column(Created_User; UserId)
            { }


            trigger OnPreDataItem()
            begin
                SetRange(Year, YearVar);
                SetFilter("Buyer Name", '<>%1', 'Total');
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
    end;


    trigger OnPreReport()
    var
        CodeUnit2Rec: Codeunit NavAppCodeUnit2;
    begin
        if YearVar >= 2023 then
            CodeUnit2Rec.CapacityByPcsReports(YearVar, 1)
        else
            Error('Invalid date.');
    end;


    var
        YearVar: Integer;
        comRec: Record "Company Information";
}