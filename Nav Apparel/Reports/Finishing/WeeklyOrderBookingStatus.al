report 50638 WeeklyOrderBookingStatus
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Weekly Order Booking Status Report';
    RDLCLayout = 'Report_Layouts/Finishing/WeeklyOrderBookingStatus.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Style Master PO"; "Style Master PO")
        {
            DataItemTableView = sorting("Style No.");
            column(Ship_Date; "Ship Date")
            { }
            column(Shipped_Qty; "Shipped Qty")
            { }
            column(BuyerName; StyleRec."Buyer Name")
            { }
            column(SMV; StyleRec.SMV)
            { }
            column(styleName; StyleRec."No.")
            { }
            column(Description; StyleRec."Style No.")
            { }
            column(PO_No_; "PO No.")
            { }
            column(firstWeek; firstWeek)
            { }
            column(SecondWeek; SecondWeek)
            { }
            column(thirdWeek; thirdWeek)
            { }
            column(fourthWeek; fourthWeek)
            { }
            column(fifthWeek; fifthWeek)
            { }
            column(Month; Month)
            { }
            column(CompLogo; comRec.Picture)
            { }

            //  column()
            // {}
            trigger OnAfterGetRecord()

            begin

                // stDate := CalcDate('-CM', "Ship Date");
                // endDate := CalcDate('CM', "Ship Date");

                StyleRec.Get("Style No.");

                Month := '';
                MonthNo := Date2DMY("Ship Date", 2);
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



                firstWeek := 0;
                SecondWeek := 0;
                thirdWeek := 0;
                fourthWeek := 0;
                fifthWeek := 0;

                WeekNo := Date2DMY("Ship Date", 1);

                if WeekNo <= 7 then begin
                    firstWeek := "Shipped Qty";
                end
                else
                    if WeekNo <= 14 then begin
                        SecondWeek := "Shipped Qty"
                    end
                    else
                        if WeekNo <= 21 then begin
                            thirdWeek := "Shipped Qty";
                        end
                        else
                            if WeekNo <= 28 then begin
                                fourthWeek := "Shipped Qty";
                            end
                            else
                                fifthWeek := "Shipped Qty";
                comRec.Get;
                comRec.CalcFields(Picture);
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Ship Date", stDate, endDate);
                // SetFilter("Ship Date", '%1..%2', stDate, endDate);

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
                    field(stDate; stDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Month Start Date';
                    }
                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Month End Date';
                        trigger OnValidate()
                        var
                        begin
                            endDate := stDate + 30;
                        end;
                    }
                }
            }
        }        
    }

    var
        StyleRec: Record "Style Master";
        WeekNo: Integer;
        firstWeek: BigInteger;
        SecondWeek: BigInteger;
        thirdWeek: BigInteger;
        fourthWeek: BigInteger;
        fifthWeek: BigInteger;
        MonthNo: Integer;
        Month: text;
        stDate: Date;
        endDate: Date;
        MoNO: Integer;
        comRec: Record "Company Information";
}