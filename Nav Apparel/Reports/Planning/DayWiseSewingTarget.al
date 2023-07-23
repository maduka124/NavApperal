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
            column(Factory_Name; "Factory No.")
            { }
            column(Buyer_Name; BuyerName)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(Order_Qty; OrderQty)
            { }
            column(StyleOrderQty; StyleOrderQty)
            { }
            column(Line_No_; "Line No.")
            { }
            column(Style_Name; "Style Name")
            { }
            column(Style_No_; "Style No.")
            { }
            column(Lot_No_; "Lot No.")
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
            column(stDate; stDate)
            { }
            column(endDate; endDate)
            { }
            column(SMV; SMV)
            { }
            column(PO_No_; "PO No.")
            { }
            // column)
            // {}

            trigger OnAfterGetRecord()
            begin
                Year := 0;
                Year := Date2DMY(PlanDate, 3);
                Month := '';
                MonthNo := Date2DMY(PlanDate, 2);

                case MonthNo of
                    1:
                        Month := 'Jan';
                    2:
                        Month := 'Feb';
                    3:
                        Month := 'March';
                    4:
                        Month := 'Apr';
                    5:
                        Month := 'May';
                    6:
                        Month := 'Jun';
                    7:
                        Month := 'Jul';
                    8:
                        Month := 'Aug';
                    9:
                        Month := 'Sep';
                    10:
                        Month := 'Oct';
                    11:
                        Month := 'Nov';
                    12:
                        Month := 'Dec';
                end;

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
                case DayNo of
                    1:
                        one := DayQty;
                    2:
                        two := DayQty;
                    3:
                        three := DayQty;
                    4:
                        four := DayQty;
                    5:
                        five := DayQty;
                    6:
                        six := DayQty;
                    7:
                        seven := DayQty;
                    8:
                        eight := DayQty;
                    9:
                        nine := DayQty;
                    10:
                        ten := DayQty;
                    11:
                        eleven := DayQty;
                    12:
                        twelve := DayQty;
                    13:
                        thirteen := DayQty;
                    14:
                        fourteen := DayQty;
                    15:
                        fifteen := DayQty;
                    16:
                        sixteen := DayQty;
                    17:
                        seventeen := DayQty;
                    18:
                        eighteen := DayQty;
                    19:
                        nineteen := DayQty;
                    20:
                        twenty := DayQty;
                    21:
                        twentyone := DayQty;
                    22:
                        twentytwo := DayQty;
                    23:
                        twenythree := DayQty;
                    24:
                        twentyfour := DayQty;
                    25:
                        twentyfive := DayQty;
                    26:
                        twentysix := DayQty;
                    27:
                        twentyseven := DayQty;
                    28:
                        twentyeight := DayQty;
                    29:
                        twentynine := DayQty;
                    30:
                        thirty := DayQty;
                    31:
                        thirtyone := DayQty;
                end;

                StylePoRec.Reset();
                StylePoRec.SetRange("Style No.", "Style No.");
                StylePoRec.SetRange("Lot No.", "Lot No.");
                StylePoRec.SetRange("PO No.", "PO No.");
                if StylePoRec.FindFirst() then begin
                    SawingOut := StylePoRec."Sawing Out Qty";
                    OrderQty := StylePoRec."Qty"
                end
                else
                    SawingOut := 0;

                StyleRec.SetRange("No.", "Style No.");
                if StyleRec.FindFirst() then begin
                    // FactoryName := StyleRec."Factory Name";
                    BuyerName := StyleRec."Buyer Name";
                    StyleOrderQty := StyleRec."Order Qty"
                end;

                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            begin
                if (stDate = 0D) and (endDate <> 0D) then
                    Error('Invalid Start Date.');

                if (stDate <> 0D) and (endDate = 0D) then
                    Error('Invalid End Date.');

                if (stDate > endDate) then
                    Error('Invalid Date Period.');

                if (stDate <> 0D) and (endDate <> 0D) then
                    SetRange(PlanDate, stDate, endDate);

                if FTY <> '' then
                    SetRange("Factory No.", FTY);

                if Style <> '' then
                    SetRange("Style No.", Style);

                if LotFilter <> '' then
                    SetRange("Lot No.", LotFilter);

                SetFilter("Qty", '>%1', 0);
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
                        TableRelation = Location.Code where("Sewing Unit" = filter(true));
                    }

                    field(Style; Style)
                    {
                        ApplicationArea = All;
                        Caption = 'Style';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            NavAppProdPlansDetRec: Record "NavApp Prod Plans Details";
                            StyleVar: Code[20];
                        begin
                            NavAppProdPlansDetRec.Reset();
                            NavAppProdPlansDetRec.SetFilter("Factory No.", '=%1', FTY);
                            NavAppProdPlansDetRec.SetCurrentKey("Style No.");
                            NavAppProdPlansDetRec.Ascending(true);
                            if NavAppProdPlansDetRec.FindSet() then begin
                                repeat
                                    if StyleVar <> NavAppProdPlansDetRec."Style No." then begin
                                        NavAppProdPlansDetRec.MARK(TRUE);
                                        StyleVar := NavAppProdPlansDetRec."Style No.";
                                    end;
                                until NavAppProdPlansDetRec.Next() = 0;
                                NavAppProdPlansDetRec.MARKEDONLY(TRUE);

                                if Page.RunModal(50519, NavAppProdPlansDetRec) = Action::LookupOK then begin
                                    Style := NavAppProdPlansDetRec."Style No.";
                                end;
                            end;
                        end;
                    }

                    field(LotFilter; LotFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Lot No';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            StyleMasterPORec: Record "Style Master PO";
                            Lot: Code[20];
                        begin
                            StyleMasterPORec.Reset();
                            StyleMasterPORec.SetRange("Style No.", Style);
                            StyleMasterPORec.SetCurrentKey("Lot No.");
                            StyleMasterPORec.Ascending(true);
                            if StyleMasterPORec.FindSet() then begin
                                repeat
                                    StyleMasterPORec.MARK(TRUE);
                                until StyleMasterPORec.Next() = 0;
                                StyleMasterPORec.MARKEDONLY(TRUE);

                                if Page.RunModal(51336, StyleMasterPORec) = Action::LookupOK then begin
                                    LotFilter := StyleMasterPORec."Lot No.";
                                end;
                            end;
                        end;
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
    }

    var
        FactoryFilter: Code[20];
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
        StyleOrderQty: BigInteger;


}