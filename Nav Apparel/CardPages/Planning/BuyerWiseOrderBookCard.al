page 51165 "BuyerWiseOrderBooking"
{
    PageType = Card;
    SourceTable = BuyerWiseOrderBookingHeader;
    Caption = 'Buyer Wise Order Booking';
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            group("General")
            {
                field(No; rec.No)
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field(Year; rec.Year)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    var

                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;
                    end;
                }
            }

            group("All Booking")
            {
                part("BuyeWisOdrBook-AllBookListPart"; "BuyeWisOdrBook-AllBookListPart")
                {
                    ApplicationArea = All;
                    Caption = '';
                    SubPageLink = Year = field(Year);
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
                    BuyWisOdrBookAllBookRec: Record BuyerWiseOdrBookingAllBook;
                    i: Integer;
                    StartDate: date;
                    FinishDate: Date;
                    SeqNo: BigInteger;
                    StyleMasterRec: Record "Style Master";
                    StyleMasterPORec: Record "Style Master PO";


                    CalenderRec: Record "Calendar Entry";
                    CustomerRec: Record Customer;
                    Total1: Decimal;
                    Total2: Decimal;
                    Total3: Decimal;
                    Total4: Decimal;
                    Total5: Decimal;
                    Total6: Decimal;
                    Total7: Decimal;
                    Total8: Decimal;
                    Total9: Decimal;
                    Total10: Decimal;
                    Total11: Decimal;
                    Total12: Decimal;
                    Total1_A: Decimal;
                    Total2_A: Decimal;
                    Total3_A: Decimal;
                    Total4_A: Decimal;
                    Total5_A: Decimal;
                    Total6_A: Decimal;
                    Total7_A: Decimal;
                    Total8_A: Decimal;
                    Total9_A: Decimal;
                    Total10_A: Decimal;
                    Total11_A: Decimal;
                    Total12_A: Decimal;
                    TotalAvgSMV1: Decimal;
                    TotalAvgSMV2: Decimal;
                    TotalAvgSMV3: Decimal;
                    TotalAvgSMV4: Decimal;
                    TotalAvgSMV5: Decimal;
                    TotalAvgSMV6: Decimal;
                    TotalAvgSMV7: Decimal;
                    TotalAvgSMV8: Decimal;
                    TotalAvgSMV9: Decimal;
                    TotalAvgSMV10: Decimal;
                    TotalAvgSMV11: Decimal;
                    TotalAvgSMV12: Decimal;
                    Total1_POQty: Decimal;
                    Total2_POQty: Decimal;
                    Total3_POQty: Decimal;
                    Total4_POQty: Decimal;
                    Total5_POQty: Decimal;
                    Total6_POQty: Decimal;
                    Total7_POQty: Decimal;
                    Total8_POQty: Decimal;
                    Total9_POQty: Decimal;
                    Total10_POQty: Decimal;
                    Total11_POQty: Decimal;
                    Total12_POQty: Decimal;
                    Carders: Integer;
                    HoursPerDay: Decimal;
                    NoofDays: Decimal;
                    NoofDays1: Decimal;
                    NoofDays2: Decimal;
                    NoofDays3: Decimal;
                    NoofDays4: Decimal;
                    NoofDays5: Decimal;
                    NoofDays6: Decimal;
                    NoofDays7: Decimal;
                    NoofDays8: Decimal;
                    NoofDays9: Decimal;
                    NoofDays10: Decimal;
                    NoofDays11: Decimal;
                    NoofDays12: Decimal;

                    Month: Integer;
                begin

                    if rec.Year > 0 then begin

                        /////////////////////////////All booking
                        //Delete old data
                        BuyWisOdrBookAllBookRec.Reset();
                        BuyWisOdrBookAllBookRec.SetRange(Year, rec.Year);
                        if BuyWisOdrBookAllBookRec.FindSet() then
                            BuyWisOdrBookAllBookRec.DeleteAll();

                        //Get max record
                        BuyWisOdrBookAllBookRec.Reset();
                        if BuyWisOdrBookAllBookRec.Findlast() then
                            SeqNo := BuyWisOdrBookAllBookRec."No.";

                        for i := 1 to 12 do begin

                            StartDate := DMY2DATE(1, i, rec.Year);

                            case i of
                                1:
                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                2:
                                    begin
                                        if rec.Year mod 4 = 0 then
                                            FinishDate := DMY2DATE(29, i, rec.Year)
                                        else
                                            FinishDate := DMY2DATE(28, i, rec.Year);
                                    end;
                                3:
                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                4:
                                    FinishDate := DMY2DATE(30, i, rec.Year);
                                5:
                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                6:
                                    FinishDate := DMY2DATE(30, i, rec.Year);
                                7:
                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                8:
                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                9:
                                    FinishDate := DMY2DATE(30, i, rec.Year);
                                10:
                                    FinishDate := DMY2DATE(31, i, rec.Year);
                                11:
                                    FinishDate := DMY2DATE(30, i, rec.Year);
                                12:
                                    FinishDate := DMY2DATE(31, i, rec.Year);
                            end;

                            //Get styles within the period
                            StyleMasterPORec.Reset();
                            StyleMasterPORec.SetRange("Ship Date", StartDate, FinishDate);
                            if StyleMasterPORec.FindSet() then begin

                                repeat

                                    //Get buyer Name/Code
                                    StyleMasterRec.Reset();
                                    StyleMasterRec.SetRange("No.", StyleMasterPORec."Style No.");
                                    StyleMasterRec.FindSet();

                                    //Check for existing records
                                    BuyWisOdrBookAllBookRec.Reset();
                                    BuyWisOdrBookAllBookRec.SetRange(Year, rec.Year);
                                    BuyWisOdrBookAllBookRec.SetRange("Buyer Code", StyleMasterRec."Buyer No.");
                                    if not BuyWisOdrBookAllBookRec.FindSet() then begin  //insert

                                        SeqNo += 1;
                                        //Insert new line
                                        BuyWisOdrBookAllBookRec.Init();
                                        BuyWisOdrBookAllBookRec."No." := SeqNo;
                                        BuyWisOdrBookAllBookRec.Year := rec.Year;
                                        BuyWisOdrBookAllBookRec."Buyer Code" := StyleMasterRec."Buyer No.";
                                        BuyWisOdrBookAllBookRec."Buyer Name" := StyleMasterRec."Buyer Name";

                                        case i of
                                            1:
                                                BuyWisOdrBookAllBookRec.JAN := StyleMasterPORec.Qty;
                                            2:
                                                BuyWisOdrBookAllBookRec.FEB := StyleMasterPORec.Qty;
                                            3:
                                                BuyWisOdrBookAllBookRec.MAR := StyleMasterPORec.Qty;
                                            4:
                                                BuyWisOdrBookAllBookRec.APR := StyleMasterPORec.Qty;
                                            5:
                                                BuyWisOdrBookAllBookRec.MAY := StyleMasterPORec.Qty;
                                            6:
                                                BuyWisOdrBookAllBookRec.JUN := StyleMasterPORec.Qty;
                                            7:
                                                BuyWisOdrBookAllBookRec.JUL := StyleMasterPORec.Qty;
                                            8:
                                                BuyWisOdrBookAllBookRec.AUG := StyleMasterPORec.Qty;
                                            9:
                                                BuyWisOdrBookAllBookRec.SEP := StyleMasterPORec.Qty;
                                            10:
                                                BuyWisOdrBookAllBookRec.OCT := StyleMasterPORec.Qty;
                                            11:
                                                BuyWisOdrBookAllBookRec.NOV := StyleMasterPORec.Qty;
                                            12:
                                                BuyWisOdrBookAllBookRec.DEC := StyleMasterPORec.Qty;
                                        end;

                                        BuyWisOdrBookAllBookRec."Created User" := UserId;
                                        BuyWisOdrBookAllBookRec."Created Date" := WorkDate();
                                        BuyWisOdrBookAllBookRec.Total := StyleMasterPORec.Qty;
                                        BuyWisOdrBookAllBookRec.Insert();

                                    end
                                    else begin  //Modify

                                        case i of
                                            1:
                                                BuyWisOdrBookAllBookRec.JAN := BuyWisOdrBookAllBookRec.JAN + StyleMasterPORec.Qty;
                                            2:
                                                BuyWisOdrBookAllBookRec.FEB := BuyWisOdrBookAllBookRec.FEB + StyleMasterPORec.Qty;
                                            3:
                                                BuyWisOdrBookAllBookRec.MAR := BuyWisOdrBookAllBookRec.MAR + StyleMasterPORec.Qty;
                                            4:
                                                BuyWisOdrBookAllBookRec.APR := BuyWisOdrBookAllBookRec.APR + StyleMasterPORec.Qty;
                                            5:
                                                BuyWisOdrBookAllBookRec.MAY := BuyWisOdrBookAllBookRec.MAY + StyleMasterPORec.Qty;
                                            6:
                                                BuyWisOdrBookAllBookRec.JUN := BuyWisOdrBookAllBookRec.JUN + StyleMasterPORec.Qty;
                                            7:
                                                BuyWisOdrBookAllBookRec.JUL := BuyWisOdrBookAllBookRec.JUL + StyleMasterPORec.Qty;
                                            8:
                                                BuyWisOdrBookAllBookRec.AUG := BuyWisOdrBookAllBookRec.AUG + StyleMasterPORec.Qty;
                                            9:
                                                BuyWisOdrBookAllBookRec.SEP := BuyWisOdrBookAllBookRec.SEP + StyleMasterPORec.Qty;
                                            10:
                                                BuyWisOdrBookAllBookRec.OCT := BuyWisOdrBookAllBookRec.OCT + StyleMasterPORec.Qty;
                                            11:
                                                BuyWisOdrBookAllBookRec.NOV := BuyWisOdrBookAllBookRec.NOV + StyleMasterPORec.Qty;
                                            12:
                                                BuyWisOdrBookAllBookRec.DEC := BuyWisOdrBookAllBookRec.DEC + StyleMasterPORec.Qty;
                                        end;

                                        BuyWisOdrBookAllBookRec.Total := BuyWisOdrBookAllBookRec.Total + StyleMasterPORec.Qty;
                                        BuyWisOdrBookAllBookRec.Modify();
                                    end;

                                until StyleMasterPORec.Next() = 0;
                            end;
                        end;

                        Message('Completed');
                    end
                    else
                        Error('Year is blank.');

                end;
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        BuyerWiseOdrBookingAllBookRec: Record BuyerWiseOdrBookingAllBook;


    begin
        BuyerWiseOdrBookingAllBookRec.Reset();
        BuyerWiseOdrBookingAllBookRec.SetRange(Year, rec.Year);
        if BuyerWiseOdrBookingAllBookRec.FindSet() then
            BuyerWiseOdrBookingAllBookRec.DeleteAll();


    end;


    trigger OnOpenPage()
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
}