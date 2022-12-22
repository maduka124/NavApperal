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

            group("Balance To Sew")
            {
                part("BuyWisOdrBoo-BalTosewListPart"; "BuyWisOdrBoo-BalTosewListPart")
                {
                    ApplicationArea = All;
                    Caption = '';
                    SubPageLink = Year = field(Year);
                }
            }

            group("Balance To Ship")
            {
                part("BuyWisOdrBoo-BalToShipListPart"; "BuyWisOdrBoo-BalToShipListPart")
                {
                    ApplicationArea = All;
                    Caption = '';
                    SubPageLink = Year = field(Year);
                }
            }

            group("Group Wise Booking")
            {
                part("BuyWisOdrBoo-GRWisBookListPart"; "BuyWisOdrBoo-GRWisBookListPart")
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
                    BuyerWiseOdrBookinBalatoSewRec: Record BuyerWiseOrderBookinBalatoSew;
                    BuyerWiseOdrBookinBalatoShipRec: Record BuyerWiseOrderBookinBalatoShip;
                    BuyerWiseOdrBookinGRWiseBookRec: Record BuyerWiseOrderBookinGRWiseBook;
                    ProductionOutHeaderRec: Record ProductionOutHeader;
                    MerchanGroupTableRec: Record MerchandizingGroupTable;
                    StyleMasterRec: Record "Style Master";
                    StyleMasterPORec: Record "Style Master PO";
                    CustomerRec: Record Customer;
                    i: Integer;
                    StartDate: date;
                    FinishDate: Date;
                    SeqNo: BigInteger;
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
                                    if StyleMasterRec.FindSet() then begin

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
                                    end;

                                until StyleMasterPORec.Next() = 0;
                            end;
                        end;



                        /////////////////////////////////Balance to Sew
                        //Delete old data
                        BuyerWiseOdrBookinBalatoSewRec.Reset();
                        BuyerWiseOdrBookinBalatoSewRec.SetRange(Year, rec.Year);
                        if BuyerWiseOdrBookinBalatoSewRec.FindSet() then
                            BuyerWiseOdrBookinBalatoSewRec.DeleteAll();

                        //Get max record  
                        SeqNo := 0;
                        BuyerWiseOdrBookinBalatoSewRec.Reset();
                        if BuyerWiseOdrBookinBalatoSewRec.Findlast() then
                            SeqNo := BuyerWiseOdrBookinBalatoSewRec."No.";

                        //Insert all bookings
                        BuyWisOdrBookAllBookRec.Reset();
                        BuyWisOdrBookAllBookRec.SetRange(Year, rec.Year);
                        if BuyWisOdrBookAllBookRec.FindSet() then begin
                            repeat
                                //Insert new line
                                SeqNo += 1;
                                BuyerWiseOdrBookinBalatoSewRec.Init();
                                BuyerWiseOdrBookinBalatoSewRec."No." := SeqNo;
                                BuyerWiseOdrBookinBalatoSewRec.Year := BuyWisOdrBookAllBookRec.Year;
                                BuyerWiseOdrBookinBalatoSewRec."Buyer Code" := BuyWisOdrBookAllBookRec."Buyer Code";
                                BuyerWiseOdrBookinBalatoSewRec."Buyer Name" := BuyWisOdrBookAllBookRec."Buyer Name";
                                BuyerWiseOdrBookinBalatoSewRec.JAN := BuyWisOdrBookAllBookRec.JAN;
                                BuyerWiseOdrBookinBalatoSewRec.FEB := BuyWisOdrBookAllBookRec.FEB;
                                BuyerWiseOdrBookinBalatoSewRec.MAR := BuyWisOdrBookAllBookRec.MAR;
                                BuyerWiseOdrBookinBalatoSewRec.APR := BuyWisOdrBookAllBookRec.APR;
                                BuyerWiseOdrBookinBalatoSewRec.MAY := BuyWisOdrBookAllBookRec.MAY;
                                BuyerWiseOdrBookinBalatoSewRec.JUN := BuyWisOdrBookAllBookRec.JUN;
                                BuyerWiseOdrBookinBalatoSewRec.JUL := BuyWisOdrBookAllBookRec.JUL;
                                BuyerWiseOdrBookinBalatoSewRec.AUG := BuyWisOdrBookAllBookRec.AUG;
                                BuyerWiseOdrBookinBalatoSewRec.SEP := BuyWisOdrBookAllBookRec.SEP;
                                BuyerWiseOdrBookinBalatoSewRec.OCT := BuyWisOdrBookAllBookRec.OCT;
                                BuyerWiseOdrBookinBalatoSewRec.NOV := BuyWisOdrBookAllBookRec.NOV;
                                BuyerWiseOdrBookinBalatoSewRec.DEC := BuyWisOdrBookAllBookRec.DEC;
                                BuyerWiseOdrBookinBalatoSewRec."Created User" := UserId;
                                BuyerWiseOdrBookinBalatoSewRec."Created Date" := WorkDate();
                                BuyerWiseOdrBookinBalatoSewRec.Total := BuyWisOdrBookAllBookRec.Total;
                                BuyerWiseOdrBookinBalatoSewRec.Insert();
                            until BuyWisOdrBookAllBookRec.Next() = 0;
                        end;

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

                            //Get sewing out
                            ProductionOutHeaderRec.Reset();
                            ProductionOutHeaderRec.SetRange("Prod Date", StartDate, FinishDate);
                            ProductionOutHeaderRec.SetFilter(Type, '=%1', ProductionOutHeaderRec.Type::Saw);
                            if ProductionOutHeaderRec.FindSet() then begin
                                repeat

                                    StyleMasterRec.Reset();
                                    StyleMasterRec.SetRange("No.", ProductionOutHeaderRec."Style No.");
                                    if StyleMasterRec.FindSet() then begin

                                        //Check existance
                                        BuyerWiseOdrBookinBalatoSewRec.Reset();
                                        BuyerWiseOdrBookinBalatoSewRec.SetRange(Year, rec.Year);
                                        BuyerWiseOdrBookinBalatoSewRec.SetRange("Buyer Code", StyleMasterRec."Buyer No.");
                                        if BuyerWiseOdrBookinBalatoSewRec.FindSet() then begin

                                            case i of
                                                1:
                                                    BuyerWiseOdrBookinBalatoSewRec.JAN := BuyerWiseOdrBookinBalatoSewRec.JAN - ProductionOutHeaderRec."Output Qty";
                                                2:
                                                    BuyerWiseOdrBookinBalatoSewRec.FEB := BuyerWiseOdrBookinBalatoSewRec.FEB - ProductionOutHeaderRec."Output Qty";
                                                3:
                                                    BuyerWiseOdrBookinBalatoSewRec.MAR := BuyerWiseOdrBookinBalatoSewRec.MAR - ProductionOutHeaderRec."Output Qty";
                                                4:
                                                    BuyerWiseOdrBookinBalatoSewRec.APR := BuyerWiseOdrBookinBalatoSewRec.APR - ProductionOutHeaderRec."Output Qty";
                                                5:
                                                    BuyerWiseOdrBookinBalatoSewRec.MAY := BuyerWiseOdrBookinBalatoSewRec.MAY - ProductionOutHeaderRec."Output Qty";
                                                6:
                                                    BuyerWiseOdrBookinBalatoSewRec.JUN := BuyerWiseOdrBookinBalatoSewRec.JUN - ProductionOutHeaderRec."Output Qty";
                                                7:
                                                    BuyerWiseOdrBookinBalatoSewRec.JUL := BuyerWiseOdrBookinBalatoSewRec.JUL - ProductionOutHeaderRec."Output Qty";
                                                8:
                                                    BuyerWiseOdrBookinBalatoSewRec.AUG := BuyerWiseOdrBookinBalatoSewRec.AUG - ProductionOutHeaderRec."Output Qty";
                                                9:
                                                    BuyerWiseOdrBookinBalatoSewRec.SEP := BuyerWiseOdrBookinBalatoSewRec.SEP - ProductionOutHeaderRec."Output Qty";
                                                10:
                                                    BuyerWiseOdrBookinBalatoSewRec.OCT := BuyerWiseOdrBookinBalatoSewRec.OCT - ProductionOutHeaderRec."Output Qty";
                                                11:
                                                    BuyerWiseOdrBookinBalatoSewRec.NOV := BuyerWiseOdrBookinBalatoSewRec.NOV - ProductionOutHeaderRec."Output Qty";
                                                12:
                                                    BuyerWiseOdrBookinBalatoSewRec.DEC := BuyerWiseOdrBookinBalatoSewRec.DEC - ProductionOutHeaderRec."Output Qty";
                                            end;

                                            BuyerWiseOdrBookinBalatoSewRec.Total := BuyerWiseOdrBookinBalatoSewRec.Total - ProductionOutHeaderRec."Output Qty";
                                            BuyerWiseOdrBookinBalatoSewRec.Modify();

                                        end;
                                    end;

                                until ProductionOutHeaderRec.Next() = 0;
                            end;

                        end;



                        //////////////////////////////Balance to ship
                        //Delete old data
                        BuyerWiseOdrBookinBalatoShipRec.Reset();
                        BuyerWiseOdrBookinBalatoShipRec.SetRange(Year, rec.Year);
                        if BuyerWiseOdrBookinBalatoShipRec.FindSet() then
                            BuyerWiseOdrBookinBalatoShipRec.DeleteAll();

                        //Get max record  
                        SeqNo := 0;
                        BuyerWiseOdrBookinBalatoShipRec.Reset();
                        if BuyerWiseOdrBookinBalatoShipRec.Findlast() then
                            SeqNo := BuyerWiseOdrBookinBalatoShipRec."No.";

                        //Insert all bookings
                        BuyWisOdrBookAllBookRec.Reset();
                        BuyWisOdrBookAllBookRec.SetRange(Year, rec.Year);
                        if BuyWisOdrBookAllBookRec.FindSet() then begin
                            repeat
                                //Insert new line
                                SeqNo += 1;
                                BuyerWiseOdrBookinBalatoShipRec.Init();
                                BuyerWiseOdrBookinBalatoShipRec."No." := SeqNo;
                                BuyerWiseOdrBookinBalatoShipRec.Year := BuyWisOdrBookAllBookRec.Year;
                                BuyerWiseOdrBookinBalatoShipRec."Buyer Code" := BuyWisOdrBookAllBookRec."Buyer Code";
                                BuyerWiseOdrBookinBalatoShipRec."Buyer Name" := BuyWisOdrBookAllBookRec."Buyer Name";
                                BuyerWiseOdrBookinBalatoShipRec.JAN := BuyWisOdrBookAllBookRec.JAN;
                                BuyerWiseOdrBookinBalatoShipRec.FEB := BuyWisOdrBookAllBookRec.FEB;
                                BuyerWiseOdrBookinBalatoShipRec.MAR := BuyWisOdrBookAllBookRec.MAR;
                                BuyerWiseOdrBookinBalatoShipRec.APR := BuyWisOdrBookAllBookRec.APR;
                                BuyerWiseOdrBookinBalatoShipRec.MAY := BuyWisOdrBookAllBookRec.MAY;
                                BuyerWiseOdrBookinBalatoShipRec.JUN := BuyWisOdrBookAllBookRec.JUN;
                                BuyerWiseOdrBookinBalatoShipRec.JUL := BuyWisOdrBookAllBookRec.JUL;
                                BuyerWiseOdrBookinBalatoShipRec.AUG := BuyWisOdrBookAllBookRec.AUG;
                                BuyerWiseOdrBookinBalatoShipRec.SEP := BuyWisOdrBookAllBookRec.SEP;
                                BuyerWiseOdrBookinBalatoShipRec.OCT := BuyWisOdrBookAllBookRec.OCT;
                                BuyerWiseOdrBookinBalatoShipRec.NOV := BuyWisOdrBookAllBookRec.NOV;
                                BuyerWiseOdrBookinBalatoShipRec.DEC := BuyWisOdrBookAllBookRec.DEC;
                                BuyerWiseOdrBookinBalatoShipRec."Created User" := UserId;
                                BuyerWiseOdrBookinBalatoShipRec."Created Date" := WorkDate();
                                BuyerWiseOdrBookinBalatoShipRec.Total := BuyWisOdrBookAllBookRec.Total;
                                BuyerWiseOdrBookinBalatoShipRec.Insert();
                            until BuyWisOdrBookAllBookRec.Next() = 0;
                        end;

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

                            //Get sewing out
                            ProductionOutHeaderRec.Reset();
                            ProductionOutHeaderRec.SetRange("Prod Date", StartDate, FinishDate);
                            ProductionOutHeaderRec.SetFilter(Type, '=%1', ProductionOutHeaderRec.Type::Ship);
                            if ProductionOutHeaderRec.FindSet() then begin
                                repeat

                                    StyleMasterRec.Reset();
                                    StyleMasterRec.SetRange("No.", ProductionOutHeaderRec."Style No.");
                                    if StyleMasterRec.FindSet() then begin

                                        //Check existance
                                        BuyerWiseOdrBookinBalatoShipRec.Reset();
                                        BuyerWiseOdrBookinBalatoShipRec.SetRange(Year, rec.Year);
                                        BuyerWiseOdrBookinBalatoShipRec.SetRange("Buyer Code", StyleMasterRec."Buyer No.");
                                        if BuyerWiseOdrBookinBalatoShipRec.FindSet() then begin

                                            case i of
                                                1:
                                                    BuyerWiseOdrBookinBalatoShipRec.JAN := BuyerWiseOdrBookinBalatoShipRec.JAN - ProductionOutHeaderRec."Output Qty";
                                                2:
                                                    BuyerWiseOdrBookinBalatoShipRec.FEB := BuyerWiseOdrBookinBalatoShipRec.FEB - ProductionOutHeaderRec."Output Qty";
                                                3:
                                                    BuyerWiseOdrBookinBalatoShipRec.MAR := BuyerWiseOdrBookinBalatoShipRec.MAR - ProductionOutHeaderRec."Output Qty";
                                                4:
                                                    BuyerWiseOdrBookinBalatoShipRec.APR := BuyerWiseOdrBookinBalatoShipRec.APR - ProductionOutHeaderRec."Output Qty";
                                                5:
                                                    BuyerWiseOdrBookinBalatoShipRec.MAY := BuyerWiseOdrBookinBalatoShipRec.MAY - ProductionOutHeaderRec."Output Qty";
                                                6:
                                                    BuyerWiseOdrBookinBalatoShipRec.JUN := BuyerWiseOdrBookinBalatoShipRec.JUN - ProductionOutHeaderRec."Output Qty";
                                                7:
                                                    BuyerWiseOdrBookinBalatoShipRec.JUL := BuyerWiseOdrBookinBalatoShipRec.JUL - ProductionOutHeaderRec."Output Qty";
                                                8:
                                                    BuyerWiseOdrBookinBalatoShipRec.AUG := BuyerWiseOdrBookinBalatoShipRec.AUG - ProductionOutHeaderRec."Output Qty";
                                                9:
                                                    BuyerWiseOdrBookinBalatoShipRec.SEP := BuyerWiseOdrBookinBalatoShipRec.SEP - ProductionOutHeaderRec."Output Qty";
                                                10:
                                                    BuyerWiseOdrBookinBalatoShipRec.OCT := BuyerWiseOdrBookinBalatoShipRec.OCT - ProductionOutHeaderRec."Output Qty";
                                                11:
                                                    BuyerWiseOdrBookinBalatoShipRec.NOV := BuyerWiseOdrBookinBalatoShipRec.NOV - ProductionOutHeaderRec."Output Qty";
                                                12:
                                                    BuyerWiseOdrBookinBalatoShipRec.DEC := BuyerWiseOdrBookinBalatoShipRec.DEC - ProductionOutHeaderRec."Output Qty";
                                            end;

                                            BuyerWiseOdrBookinBalatoShipRec.Total := BuyerWiseOdrBookinBalatoShipRec.Total - ProductionOutHeaderRec."Output Qty";
                                            BuyerWiseOdrBookinBalatoShipRec.Modify();

                                        end;
                                    end;

                                until ProductionOutHeaderRec.Next() = 0;
                            end;

                        end;




                        ///////////////////////////////Group wise booking
                        //Delete old data
                        BuyerWiseOdrBookinGRWiseBookRec.Reset();
                        BuyerWiseOdrBookinGRWiseBookRec.SetRange(Year, rec.Year);
                        if BuyerWiseOdrBookinGRWiseBookRec.FindSet() then
                            BuyerWiseOdrBookinGRWiseBookRec.DeleteAll();

                        //Get max record  
                        SeqNo := 0;
                        BuyerWiseOdrBookinGRWiseBookRec.Reset();
                        if BuyerWiseOdrBookinGRWiseBookRec.Findlast() then
                            SeqNo := BuyerWiseOdrBookinGRWiseBookRec."No.";

                        //Insert all group heads
                        MerchanGroupTableRec.Reset();
                        if MerchanGroupTableRec.FindSet() then begin
                            repeat

                                BuyerWiseOdrBookinGRWiseBookRec.Reset();
                                BuyerWiseOdrBookinGRWiseBookRec.SetRange(Year, rec.Year);
                                BuyerWiseOdrBookinGRWiseBookRec.SetRange("Group Name", MerchanGroupTableRec."Group Name");
                                if not BuyerWiseOdrBookinGRWiseBookRec.findset() then begin

                                    SeqNo += 1;
                                    BuyerWiseOdrBookinGRWiseBookRec.Init();
                                    BuyerWiseOdrBookinGRWiseBookRec."No." := SeqNo;
                                    BuyerWiseOdrBookinGRWiseBookRec."Group Id" := MerchanGroupTableRec."Group Id";
                                    BuyerWiseOdrBookinGRWiseBookRec."Group Head" := MerchanGroupTableRec."Group Head";
                                    BuyerWiseOdrBookinGRWiseBookRec."Group Name" := MerchanGroupTableRec."Group Name";
                                    BuyerWiseOdrBookinGRWiseBookRec.Year := rec.Year;
                                    BuyerWiseOdrBookinGRWiseBookRec."Created User" := UserId;
                                    BuyerWiseOdrBookinGRWiseBookRec."Created Date" := WorkDate();
                                    BuyerWiseOdrBookinGRWiseBookRec.Insert();
                                end
                                else begin
                                    BuyerWiseOdrBookinGRWiseBookRec.JAN := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.FEB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.MAR := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.APR := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.MAY := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.JUN := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.JUL := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.AUG := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.SEP := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.OCT := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.NOV := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.DEC := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.JAN_FOB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.FEB_FOB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.MAR_FOB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.APR_FOB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.MAY_FOB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.JUN_FOB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.JUL_FOB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.AUG_FOB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.SEP_FOB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.OCT_FOB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.NOV_FOB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.DEC_FOB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.Total := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.Total_FOB := 0;
                                    BuyerWiseOdrBookinGRWiseBookRec.Modify();
                                end;

                            until MerchanGroupTableRec.Next() = 0;
                        end;

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

                            //Get style po details for the date range
                            StyleMasterPORec.Reset();
                            StyleMasterPORec.SetRange("Ship Date", StartDate, FinishDate);
                            if StyleMasterPORec.FindSet() then begin
                                repeat

                                    //Get buyer for the style
                                    StyleMasterRec.Reset();
                                    StyleMasterRec.SetRange("No.", StyleMasterPORec."Style No.");
                                    if StyleMasterRec.FindSet() then begin

                                        //Get merchnadizer group for the buyer
                                        CustomerRec.Reset();
                                        CustomerRec.SetRange("No.", StyleMasterRec."Buyer No.");
                                        CustomerRec.FindSet();

                                        //Check existance
                                        BuyerWiseOdrBookinGRWiseBookRec.Reset();
                                        BuyerWiseOdrBookinGRWiseBookRec.SetRange(Year, rec.Year);
                                        BuyerWiseOdrBookinGRWiseBookRec.SetRange("Group Id", CustomerRec."Group Id");
                                        if BuyerWiseOdrBookinGRWiseBookRec.FindSet() then begin

                                            case i of
                                                1:
                                                    begin
                                                        BuyerWiseOdrBookinGRWiseBookRec.JAN := BuyerWiseOdrBookinGRWiseBookRec.JAN + StyleMasterPORec."Qty";
                                                        BuyerWiseOdrBookinGRWiseBookRec.JAN_FOB := BuyerWiseOdrBookinGRWiseBookRec.JAN_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                    end;
                                                2:
                                                    begin
                                                        BuyerWiseOdrBookinGRWiseBookRec.FEB := BuyerWiseOdrBookinGRWiseBookRec.FEB + StyleMasterPORec."Qty";
                                                        BuyerWiseOdrBookinGRWiseBookRec.FEB_FOB := BuyerWiseOdrBookinGRWiseBookRec.FEB_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                    end;
                                                3:
                                                    begin
                                                        BuyerWiseOdrBookinGRWiseBookRec.MAR := BuyerWiseOdrBookinGRWiseBookRec.MAR + StyleMasterPORec."Qty";
                                                        BuyerWiseOdrBookinGRWiseBookRec.MAR_FOB := BuyerWiseOdrBookinGRWiseBookRec.MAR_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                    end;
                                                4:
                                                    begin
                                                        BuyerWiseOdrBookinGRWiseBookRec.APR := BuyerWiseOdrBookinGRWiseBookRec.APR + StyleMasterPORec."Qty";
                                                        BuyerWiseOdrBookinGRWiseBookRec.APR_FOB := BuyerWiseOdrBookinGRWiseBookRec.APR_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                    end;
                                                5:
                                                    begin
                                                        BuyerWiseOdrBookinGRWiseBookRec.MAY := BuyerWiseOdrBookinGRWiseBookRec.MAY + StyleMasterPORec."Qty";
                                                        BuyerWiseOdrBookinGRWiseBookRec.MAY_FOB := BuyerWiseOdrBookinGRWiseBookRec.MAY_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                    end;
                                                6:
                                                    begin
                                                        BuyerWiseOdrBookinGRWiseBookRec.JUN := BuyerWiseOdrBookinGRWiseBookRec.JUN + StyleMasterPORec."Qty";
                                                        BuyerWiseOdrBookinGRWiseBookRec.JUN_FOB := BuyerWiseOdrBookinGRWiseBookRec.JUN_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                    end;
                                                7:
                                                    begin
                                                        BuyerWiseOdrBookinGRWiseBookRec.JUL := BuyerWiseOdrBookinGRWiseBookRec.JUL + StyleMasterPORec."Qty";
                                                        BuyerWiseOdrBookinGRWiseBookRec.JUL_FOB := BuyerWiseOdrBookinGRWiseBookRec.JUL_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                    end;
                                                8:
                                                    begin
                                                        BuyerWiseOdrBookinGRWiseBookRec.AUG := BuyerWiseOdrBookinGRWiseBookRec.AUG + StyleMasterPORec."Qty";
                                                        BuyerWiseOdrBookinGRWiseBookRec.AUG_FOB := BuyerWiseOdrBookinGRWiseBookRec.AUG_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                    end;
                                                9:
                                                    begin
                                                        BuyerWiseOdrBookinGRWiseBookRec.SEP := BuyerWiseOdrBookinGRWiseBookRec.SEP + StyleMasterPORec."Qty";
                                                        BuyerWiseOdrBookinGRWiseBookRec.SEP_FOB := BuyerWiseOdrBookinGRWiseBookRec.SEP_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                    end;
                                                10:
                                                    begin
                                                        BuyerWiseOdrBookinGRWiseBookRec.OCT := BuyerWiseOdrBookinGRWiseBookRec.OCT + StyleMasterPORec."Qty";
                                                        BuyerWiseOdrBookinGRWiseBookRec.OCT_FOB := BuyerWiseOdrBookinGRWiseBookRec.OCT_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                    end;
                                                11:
                                                    begin
                                                        BuyerWiseOdrBookinGRWiseBookRec.NOV := BuyerWiseOdrBookinGRWiseBookRec.NOV + StyleMasterPORec."Qty";
                                                        BuyerWiseOdrBookinGRWiseBookRec.NOV_FOB := BuyerWiseOdrBookinGRWiseBookRec.NOV_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                    end;
                                                12:
                                                    begin
                                                        BuyerWiseOdrBookinGRWiseBookRec.DEC := BuyerWiseOdrBookinGRWiseBookRec.DEC + StyleMasterPORec."Qty";
                                                        BuyerWiseOdrBookinGRWiseBookRec.DEC_FOB := BuyerWiseOdrBookinGRWiseBookRec.DEC_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                                    end;
                                            end;

                                            BuyerWiseOdrBookinGRWiseBookRec.Total := BuyerWiseOdrBookinGRWiseBookRec.Total + StyleMasterPORec."Qty";
                                            BuyerWiseOdrBookinGRWiseBookRec.Total_FOB := BuyerWiseOdrBookinGRWiseBookRec.Total_FOB + (StyleMasterPORec."Qty" * StyleMasterPORec."Unit Price");
                                            BuyerWiseOdrBookinGRWiseBookRec.Modify();

                                        end;
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
        BuyerWiseOdrBookinBalatoSewRec: Record BuyerWiseOrderBookinBalatoSew;
        BuyerWiseOdrBookinBalatoShipRec: Record BuyerWiseOrderBookinBalatoShip;
        BuyerWiseOrderBookinGRWiseBookRec: Record BuyerWiseOrderBookinGRWiseBook;

    begin
        BuyerWiseOdrBookingAllBookRec.Reset();
        BuyerWiseOdrBookingAllBookRec.SetRange(Year, rec.Year);
        if BuyerWiseOdrBookingAllBookRec.FindSet() then
            BuyerWiseOdrBookingAllBookRec.DeleteAll();

        BuyerWiseOdrBookinBalatoSewRec.Reset();
        BuyerWiseOdrBookinBalatoSewRec.SetRange(Year, rec.Year);
        if BuyerWiseOdrBookinBalatoSewRec.FindSet() then
            BuyerWiseOdrBookinBalatoSewRec.DeleteAll();

        BuyerWiseOdrBookinBalatoShipRec.Reset();
        BuyerWiseOdrBookinBalatoShipRec.SetRange(Year, rec.Year);
        if BuyerWiseOdrBookinBalatoShipRec.FindSet() then
            BuyerWiseOdrBookinBalatoShipRec.DeleteAll();

        BuyerWiseOrderBookinGRWiseBookRec.Reset();
        BuyerWiseOrderBookinGRWiseBookRec.SetRange(Year, rec.Year);
        if BuyerWiseOrderBookinGRWiseBookRec.FindSet() then
            BuyerWiseOrderBookinGRWiseBookRec.DeleteAll();
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