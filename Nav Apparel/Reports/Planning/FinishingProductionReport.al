report 51387 FinishingProductionReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Hourly Finishing Production Report';
    RDLCLayout = 'Report_Layouts/Planning/FinishingSubReport.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Hourly Production Lines"; "Hourly Production Lines")
        {
            DataItemTableView = where(Type = filter('Finishing'), Item = filter('PASS PCS'));
            column(Hour_1F; "Hour 01")
            { }
            column(Hour_2F; "Hour 02")
            { }
            column(Hour_3F; "Hour 03")
            { }
            column(Hour_4F; "Hour 04")
            { }
            column(Hour_5F; "Hour 05")
            { }
            column(Hour_6F; "Hour 06")
            { }
            column(Hour_7F; "Hour 07")
            { }
            column(Hour_8F; "Hour 08")
            { }
            column(Hour_9F; "Hour 09")
            { }
            column(Hour_10F; "Hour 10")
            { }
            column(Line_No_1F; "Work Center No.")
            { }
            column(ItemF; Item)
            { }
            column(Factory_No_1F; "Factory No.")
            { }
            column(StyleNameFinishing; StyleName)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(FactoryName; FactoryName)
            { }
            column(PlanDate; "Prod Date")
            { }
            column(WFHTot; WFHTot)
            { }
            column(WIPFin; WIPFin)
            { }
            column(FactoryHour1TotFin; FactoryHour1TotFin)
            { }
            column(FactoryHour2TotFin; FactoryHour2TotFin)
            { }
            column(FactoryHour3TotFin; FactoryHour3TotFin)
            { }
            column(FactoryHour4TotFin; FactoryHour4TotFin)
            { }
            column(FactoryHour5TotFin; FactoryHour5TotFin)
            { }
            column(FactoryHour6TotFin; FactoryHour6TotFin)
            { }
            column(FactoryHour7TotFin; FactoryHour7TotFin)
            { }
            column(FactoryHour8TotFin; FactoryHour8TotFin)
            { }
            column(FactoryHour9TotFin; FactoryHour9TotFin)
            { }
            column(FactoryHour10TotFin; FactoryHour10TotFin)
            { }
            column(FactoryTotalAchiveHoursFin; FactoryTotalAchiveHoursFin)
            { }

            trigger OnAfterGetRecord()
            var
                LocationRec: Record Location;
                HoProLiRec: Record "Hourly Production Lines";
                StyleRec: Record "Style Master";
                StylePoRec: Record "Style Master PO";
                HoProLineRec: Record "Hourly Production Lines";
                WFH1: Integer;
                WFH2: Integer;
                WFH3: Integer;
                WFH4: Integer;
                WFH5: Integer;
                WFH6: Integer;
                WFH7: Integer;
                WFH8: Integer;
                WFH9: Integer;
                WFH10: Integer;
                Yesterday: Date;
            begin
                LocationRec.reset();
                LocationRec.SetRange(Code, "Factory No.");
                if LocationRec.FindFirst() then begin
                    FactoryName := LocationRec.Name;
                end;

                comRec.Get;
                comRec.CalcFields(Picture);

                Yesterday := Today - 1;

                StyleRec.Reset();
                StyleRec.SetRange("No.", "Style No.");
                if StyleRec.FindFirst() then begin
                    StyleName := StyleRec."Style No.";
                end;
                //Factory Achieve


                HoProLiRec.Reset();
                HoProLiRec.SetRange("Style No.", "Style No.");
                HoProLiRec.SetRange("Factory No.", "Factory No.");
                HoProLiRec.SetRange(Type, HoProLiRec.Type::Finishing);
                HoProLiRec.SetFilter(Item, '=%1', 'PASS PCS');
                if HoProLiRec.FindSet() then begin
                    HoProLiRec.CalcSums("Hour 01");
                    WFH1 := HoProLiRec."Hour 01";

                    HoProLiRec.CalcSums("Hour 02");
                    WFH2 := HoProLiRec."Hour 02";

                    HoProLiRec.CalcSums("Hour 03");
                    WFH3 := HoProLiRec."Hour 03";

                    HoProLiRec.CalcSums("Hour 04");
                    WFH4 := HoProLiRec."Hour 04";

                    HoProLiRec.CalcSums("Hour 05");
                    WFH5 := HoProLiRec."Hour 05";

                    HoProLiRec.CalcSums("Hour 06");
                    WFH6 := HoProLiRec."Hour 06";

                    HoProLiRec.CalcSums("Hour 07");
                    WFH7 := HoProLiRec."Hour 07";

                    HoProLiRec.CalcSums("Hour 08");
                    WFH8 := HoProLiRec."Hour 08";

                    HoProLiRec.CalcSums("Hour 09");
                    WFH9 := HoProLiRec."Hour 09";

                    HoProLiRec.CalcSums("Hour 10");
                    WFH10 := HoProLiRec."Hour 10";

                    WFHTot := WFH1 + WFH2 + WFH3 + WFH4 + WFH5 + WFH6 + WFH7 + WFH8 + WFH9 + WFH10;
                end;

                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Style No.");
                if StylePoRec.FindSet() then begin
                    StylePoRec.CalcSums("Sawing Out Qty");
                    WIPFin := StylePoRec."Sawing Out Qty";
                end;
                // WIPFin := WSHTot - WFHTot;



                HoProLiRec.Reset();
                HoProLiRec.SetRange("Prod Date", "Prod Date");
                HoProLiRec.SetRange(Type, HoProLiRec.Type::Finishing);
                HoProLiRec.SetFilter(Item, '=%1', 'PASS PCS');
                if HoProLiRec.FindSet() then begin

                    HoProLiRec.CalcSums("Hour 01");
                    FactoryHour1TotFin := HoProLiRec."Hour 01";

                    HoProLiRec.CalcSums("Hour 02");
                    FactoryHour2TotFin := HoProLiRec."Hour 02";

                    HoProLiRec.CalcSums("Hour 03");
                    FactoryHour3TotFin := HoProLiRec."Hour 03";

                    HoProLiRec.CalcSums("Hour 04");
                    FactoryHour4TotFin := HoProLiRec."Hour 04";

                    HoProLiRec.CalcSums("Hour 05");
                    FactoryHour5TotFin := HoProLiRec."Hour 05";

                    HoProLiRec.CalcSums("Hour 06");
                    FactoryHour6TotFin := HoProLiRec."Hour 06";

                    HoProLiRec.CalcSums("Hour 07");
                    FactoryHour7TotFin := HoProLiRec."Hour 07";

                    HoProLiRec.CalcSums("Hour 08");
                    FactoryHour8TotFin := HoProLiRec."Hour 08";

                    HoProLiRec.CalcSums("Hour 09");
                    FactoryHour9TotFin := HoProLiRec."Hour 09";

                    HoProLiRec.CalcSums("Hour 10");
                    FactoryHour10TotFin := HoProLiRec."Hour 10";

                    FactoryTotalAchiveHoursFin := FactoryHour1TotFin + FactoryHour2TotFin + FactoryHour3TotFin + FactoryHour4TotFin + FactoryHour5TotFin + FactoryHour6TotFin + FactoryHour7TotFin + FactoryHour8TotFin + FactoryHour9TotFin + FactoryHour10TotFin;
                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetRange("Factory No.", FactortFilter);
                SetRange("Prod Date", FilterDate);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Filter By';

                    field(FactortFilter; FactortFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';

                        trigger OnLookup(var texts: text): Boolean
                        var
                            LocationRec: Record Location;
                            UserRec: Record "User Setup";
                        begin
                            UserRec.Reset();
                            UserRec.Get(UserId);

                            LocationRec.Reset();
                            if UserRec.UserRole <> 'CHAIRMAN USER' then
                                LocationRec.SetRange(Code, UserRec."Factory Code");

                            LocationRec.SetFilter("Sewing Unit", '=%1', true);
                            if LocationRec.FindSet() then begin
                                if Page.RunModal(15, LocationRec) = Action::LookupOK then begin
                                    FactortFilter := LocationRec.Code;
                                end;
                            end;
                        end;
                    }

                    field(FilterDate; FilterDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Production Date';
                    }
                }
            }
        }
    }

    trigger OnInitReport()
    var
    begin
        FilterDate := WorkDate();
    end;

    var
        FactoryTotalAchiveHoursFin: Integer;
        FactoryHour1TotFin: Integer;
        FactoryHour2TotFin: Integer;
        FactoryHour3TotFin: Integer;
        FactoryHour4TotFin: Integer;
        FactoryHour5TotFin: Integer;
        FactoryHour6TotFin: Integer;
        FactoryHour7TotFin: Integer;
        FactoryHour8TotFin: Integer;
        FactoryHour9TotFin: Integer;
        FactoryHour10TotFin: Integer;
        FactoryCodeTotal: Code[20];
        comRec: Record "Company Information";
        FactoryName: Text[100];
        WFHTot: Integer;
        WIPFin: BigInteger;
        StyleName: Text[100];
        FactortFilter: Code[20];
        FilterDate: Date;
}