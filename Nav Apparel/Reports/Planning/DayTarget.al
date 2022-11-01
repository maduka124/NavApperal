report 50646 DayTarget
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    RDLCLayout = 'Report_Layouts/Planning/Daytarget.rdl';
    DefaultLayout = RDLC;


    dataset
    {
        dataitem("Style Master"; "Style Master")
        {
            column(Factory_Name; "Factory Name")
            { }
            column(Buyer_Name; "Buyer Name")
            { }
            column(CompLogo; comRec.Picture)
            { }

            dataitem("NavApp Prod Plans Details"; "NavApp Prod Plans Details")
            {
                DataItemLinkReference = "Style Master";
                DataItemLink = "Style No." = field("No.");
                DataItemTableView = sorting("No.");

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
                                                                Month := 'Des';

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
                end;
            }
            trigger OnAfterGetRecord()

            begin
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()

            begin
                // SetRange("Factory Name", FTY);
                // SetRange("No.", Style);
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
                        Caption = 'Location';
                        TableRelation = Location.Code;

                    }
                    field(Style; Style)
                    {
                        ApplicationArea = All;
                        Caption = 'Style`';
                        TableRelation = "Style Master"."No.";

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

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

    var
        myInt: Integer;
        Month: text;
        MonthNo: Integer;
        DayQty: Decimal;
        DayNo: Integer;
        one: BigInteger;
        two: BigInteger;
        three: BigInteger;
        four: BigInteger;
        five: BigInteger;
        six: BigInteger;
        seven: BigInteger;
        eight: BigInteger;
        nine: BigInteger;
        ten: BigInteger;
        eleven: BigInteger;
        twelve: BigInteger;
        thirteen: BigInteger;
        fourteen: BigInteger;
        fifteen: BigInteger;
        sixteen: BigInteger;
        seventeen: BigInteger;
        eighteen: BigInteger;
        nineteen: BigInteger;
        twenty: BigInteger;
        twentyone: BigInteger;
        twentytwo: BigInteger;
        twenythree: BigInteger;
        twentyfour: BigInteger;
        twentyfive: BigInteger;
        twentysix: BigInteger;
        twentyseven: BigInteger;
        twentyeight: BigInteger;
        twentynine: BigInteger;
        thirty: BigInteger;
        thirtyone: BigInteger;
        comRec: Record "Company Information";
        Year: Integer;
        FTY: Text[50];
        Style: Code[20];

}