report 50646 DayWiseSewingTarget
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Day Wise Sewing Target Report';

    RDLCLayout = 'Report_Layouts/Planning/DayWiseSewingTarget.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
        {

            DataItemTableView = sorting("No.");
            column(Factory_Name; FactoryName)
            { }
            column(Buyer_Name; BuyerName)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Order_Qty; OrderQty)
            { }

            column(Line_No_; "Line No.")
            { }
            column(Style_Name; "Style Name")
            { }
            column(Style_No_; "Style No.")
            { }
            column(Month; Month)
            { }
            column(one; one)
            { }
            column(two; two)
            { }
            column(three; three)
            { }
            column(four; four)
            { }
            column(five; five)
            { }
            column(six; six)
            { }
            column(seven; seven)
            { }
            column(eight; eight)
            { }
            column(nine; nine)
            { }
            column(ten; ten)
            { }
            column(eleven; eleven)
            { }
            column(twelve; twelve)
            { }
            column(thirteen; thirteen)
            { }
            column(fourteen; fourteen)
            { }
            column(fifteen; fifteen)
            { }
            column(sixteen; sixteen)
            { }
            column(seventeen; seventeen)
            { }
            column(eighteen; eighteen)
            { }
            column(nineteen; nineteen)
            { }
            column(twenty; twenty)
            { }
            column(twentyone; twentyone)
            { }
            column(twentytwo; twentytwo)
            { }
            column(twenythree; twenythree)
            { }
            column(twentyfour; twentyfour)
            { }
            column(twentyfive; twentyfive)
            { }
            column(twentysix; twentysix)
            { }
            column(twentyseven; twentyseven)
            { }
            column(twentyeight; twentyeight)
            { }
            column(twentynine; twentynine)
            { }
            column(thirty; thirty)
            { }
            column(thirtyone; thirtyone)
            { }
            column(Year; Year)
            { }
            column(SawingOut; SawingOut)
            { }

            trigger OnAfterGetRecord()

            begin
                Year := 0;
                Year := Date2DMY(PlanDate, 3);

                Month := '';

                MonthNo := Date2DMY(PlanDate, 2);
                if MonthNo = 1 then begin
                    Month := 'Jan'
                end
                else
                    if MonthNo = 2 then begin
                        Month := 'Feb';
                    end
                    else
                        if MonthNo = 3 then begin
                            Month := 'March';
                        end
                        else
                            if MonthNo = 4 then begin
                                Month := 'Apr';
                            end
                            else
                                if MonthNo = 5 then begin
                                    Month := 'May';
                                end
                                else
                                    if MonthNo = 6 then begin
                                        Month := 'Jun';
                                    end
                                    else
                                        if MonthNo = 7 then begin
                                            Month := 'Jul';
                                        end
                                        else
                                            if MonthNo = 8 then begin
                                                Month := 'Aug';
                                            end
                                            else
                                                if MonthNo = 9 then begin
                                                    Month := 'Sep';
                                                end
                                                else
                                                    if MonthNo = 10 then begin
                                                        Month := 'Oct';
                                                    end
                                                    else
                                                        if MonthNo = 11 then begin
                                                            Month := 'Nov';
                                                        end
                                                        else
                                                            Month := 'DeC';

                DayQty := Qty;

                one := 0;
                two := 0;
                three := 0;
                four := 0;
                five := 0;
                six := 0;
                seven := 0;
                eight := 0;
                nine := 0;
                ten := 0;
                eleven := 0;
                twelve := 0;
                thirteen := 0;
                fourteen := 0;
                fifteen := 0;
                sixteen := 0;
                seventeen := 0;
                eighteen := 0;
                nineteen := 0;
                twenty := 0;
                twentyone := 0;
                twentytwo := 0;
                twenythree := 0;
                twentyfour := 0;
                twentyfive := 0;
                twentysix := 0;
                twentyseven := 0;
                twentyseven := 0;
                twentynine := 0;
                thirty := 0;
                thirtyone := 0;

                DayNo := Date2DMY(PlanDate, 1);

                if DayNo = 1 then begin
                    one := DayQty;
                end
                else
                    if DayNo = 2 then begin
                        two := DayQty;
                    end
                    else
                        if DayNo = 3 then begin
                            three := DayQty;
                        end
                        else
                            if DayNo = 4 then begin
                                four := DayQty;
                            end
                            else
                                if DayNo = 5 then begin
                                    five := DayQty;
                                end
                                else
                                    if DayNo = 6 then begin
                                        six := DayQty;
                                    end
                                    else
                                        if DayNo = 7 then begin
                                            seven := DayQty;
                                        end
                                        else
                                            if DayNo = 8 then begin
                                                eight := DayQty;
                                            end
                                            else
                                                if DayNo = 9 then begin
                                                    nine := DayQty;
                                                end
                                                else
                                                    if DayNo = 10 then begin
                                                        ten := DayQty;
                                                    end
                                                    else
                                                        if DayNo = 11 then begin
                                                            eleven := DayQty;
                                                        end
                                                        else
                                                            if DayNo = 12 then begin
                                                                twelve := DayQty;
                                                            end
                                                            else
                                                                if DayNo = 13 then begin
                                                                    thirteen := DayQty;
                                                                end
                                                                else
                                                                    if DayNo = 14 then begin
                                                                        fourteen := DayQty;
                                                                    end
                                                                    else
                                                                        if DayNo = 15 then begin
                                                                            fifteen := DayQty;
                                                                        end
                                                                        else
                                                                            if DayNo = 16 then begin
                                                                                sixteen := DayQty;
                                                                            end
                                                                            else
                                                                                if DayNo = 17 then begin
                                                                                    seventeen := DayQty;
                                                                                end
                                                                                else
                                                                                    if DayNo = 18 then begin
                                                                                        eighteen := DayQty;
                                                                                    end
                                                                                    else
                                                                                        if DayNo = 19 then begin
                                                                                            nineteen := DayQty;
                                                                                        end
                                                                                        else
                                                                                            if DayNo = 20 then begin
                                                                                                twenty := DayQty;
                                                                                            end
                                                                                            else
                                                                                                if DayNo = 21 then begin
                                                                                                    twentyone := DayQty;
                                                                                                end
                                                                                                else
                                                                                                    if DayNo = 22 then begin
                                                                                                        twentytwo := DayQty;
                                                                                                    end
                                                                                                    else
                                                                                                        if DayNo = 23 then begin
                                                                                                            twenythree := DayQty;
                                                                                                        end
                                                                                                        else
                                                                                                            if DayNo = 24 then begin
                                                                                                                twentyfour := DayQty;
                                                                                                            end
                                                                                                            else
                                                                                                                if DayNo = 25 then begin
                                                                                                                    twentyfive := DayQty;
                                                                                                                end
                                                                                                                else
                                                                                                                    if DayNo = 26 then begin
                                                                                                                        twentysix := DayQty;
                                                                                                                    end
                                                                                                                    else
                                                                                                                        if DayNo = 27 then begin
                                                                                                                            twentyseven := DayQty;
                                                                                                                        end
                                                                                                                        else
                                                                                                                            if DayNo = 28 then begin
                                                                                                                                twentyeight := DayQty;
                                                                                                                            end
                                                                                                                            else
                                                                                                                                if DayNo = 29 then begin
                                                                                                                                    twentynine := DayQty;
                                                                                                                                end
                                                                                                                                else
                                                                                                                                    if DayNo = 30 then begin
                                                                                                                                        thirty := DayQty;
                                                                                                                                    end
                                                                                                                                    else
                                                                                                                                        if DayNo = 31 then begin
                                                                                                                                            thirtyone := DayQty;
                                                                                                                                        end;

                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Style No.");
                if StylePoRec.FindFirst() then begin
                    SawingOut := StylePoRec."Sawing Out Qty";
                end;


                StyleRec.SetRange("No.", "Style No.");
                if StyleRec.FindFirst() then begin
                    FactoryName := StyleRec."Factory Name";
                    BuyerName := StyleRec."Buyer Name";
                    OrderQty := StyleRec."Order Qty";
                end;
                comRec.Get;
                comRec.CalcFields(Picture);


            end;

            trigger OnPreDataItem()
            begin
                if stDate <> 0D then
                    SetRange(PlanDate, stDate, endDate);
                if FTY <> '' then
                    SetRange("Factory No.", FTY);
                if Style <> '' then
                    SetRange("Style No.", Style);
                if LotFilter <> '' then
                    SetRange("Lot No.", LotFilter);
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
                    field(FTY; FTY)
                    {
                        ApplicationArea = All;
                        Caption = 'Factory';
                        TableRelation = Location.Code;


                    }

                    field(Style; Style)
                    {
                        ApplicationArea = All;
                        Caption = 'Style';
                        TableRelation = "Style Master"."No.";


                    }
                    field(LotFilter; LotFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Lot No';
                        TableRelation = "Style Master PO"."Lot No.";

                    }
                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';

                    }
                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        location: code[20];
        LotFilter: Code[20];
        FactoryName: Text[50];
        BuyerName: Text[50];
        OrderQty: BigInteger;
        StyleRec: Record "Style Master";
        stDate: Date;
        endDate: Date;
        Month: text;
        MonthNo: Integer;
        DayQty: Decimal;
        DayNo: Integer;
        one: Decimal;
        two: Decimal;
        three: Decimal;
        four: Decimal;
        five: Decimal;
        six: Decimal;
        seven: Decimal;
        eight: Decimal;
        nine: Decimal;
        ten: Decimal;
        eleven: Decimal;
        twelve: Decimal;
        thirteen: Decimal;
        fourteen: Decimal;
        fifteen: Decimal;
        sixteen: Decimal;
        seventeen: Decimal;
        eighteen: Decimal;
        nineteen: Decimal;
        twenty: Decimal;
        twentyone: Decimal;
        twentytwo: Decimal;
        twenythree: Decimal;
        twentyfour: Decimal;
        twentyfive: Decimal;
        twentysix: Decimal;
        twentyseven: Decimal;
        twentyeight: Decimal;
        twentynine: Decimal;
        thirty: Decimal;
        thirtyone: Decimal;
        comRec: Record "Company Information";
        Year: Integer;
        FTY: Code[20];
        Style: Code[20];
        StylePoRec: Record "Style Master PO";
        SawingOut: BigInteger;


}