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
                    BuyWisOdrBookAllBook1Rec: Record BuyerWiseOdrBookingAllBook;
                    BuyerWiseOdrBookinBalatoSewRec: Record BuyerWiseOrderBookinBalatoSew;
                    BuyerWiseOdrBookinBalatoSewTotRec: Record BuyerWiseOrderBookinBalatoSew;
                    BuyerWiseOdrBookinBalatoShipRec: Record BuyerWiseOrderBookinBalatoShip;
                    BuyerWiseOdrBookinBalatoShipTotRec: Record BuyerWiseOrderBookinBalatoShip;
                    BuyerWiseOdrBookinGRWiseBookRec: Record BuyerWiseOrderBookinGRWiseBook;
                    PostSalesInvHeaderRec: Record "Sales Invoice Header";
                    PostSalesInvLineRec: Record "Sales Invoice Line";
                    ProductionOutHeaderRec: Record ProductionOutHeader;
                    MerchanGroupTableRec: Record MerchandizingGroupTable;
                    StyleMasterRec: Record "Style Master";
                    StyleMasterPORec: Record "Style Master PO";
                    CustomerRec: Record Customer;
                    codeunit1: Codeunit "CodeUnitJobQueue-AllBooking";
                    i: Integer;
                    StartDate: date;
                    FinishDate: Date;
                    SeqNo: BigInteger;
                    StyleNo: Code[20];
                    //StyleNo1: Code[20];
                    xxx: Integer;
                    Tot: BigInteger;
                begin

                    if rec.Year > 0 then begin

                        // codeunit1.Proc1();

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

                        SeqNo += 1;

                        //Insert Grand total line
                        BuyWisOdrBookAllBookRec.Init();
                        BuyWisOdrBookAllBookRec."No." := SeqNo;
                        BuyWisOdrBookAllBookRec.Year := rec.Year;
                        BuyWisOdrBookAllBookRec."Buyer Code" := ' ';
                        BuyWisOdrBookAllBookRec."Buyer Name" := 'Total';
                        BuyWisOdrBookAllBookRec.Type := 'T';
                        BuyWisOdrBookAllBookRec."Created User" := UserId;
                        BuyWisOdrBookAllBookRec."Created Date" := WorkDate();
                        BuyWisOdrBookAllBookRec.Insert();

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
                            StyleMasterPORec.SetCurrentKey("Style No.");
                            StyleMasterPORec.Ascending(true);
                            StyleMasterPORec.SetRange("Ship Date", StartDate, FinishDate);
                            if StyleMasterPORec.FindSet() then begin

                                repeat

                                    //Get buyer Name/Code
                                    StyleMasterRec.Reset();
                                    StyleMasterRec.SetRange("No.", StyleMasterPORec."Style No.");
                                    StyleMasterRec.SetFilter("Buyer Name", '<>%1', '');
                                    StyleMasterRec.SetFilter(Status, '=%1', StyleMasterRec.Status::Confirmed);
                                    if StyleMasterRec.FindSet() then begin

                                        // if StyleMasterRec."Buyer Name" = 'AMAZON' then
                                        //     Message('AMAZON');

                                        //Done By Sachith on 16/02/23 (insert brand filter line)
                                        //Check for existing records            
                                        BuyWisOdrBookAllBookRec.Reset();
                                        BuyWisOdrBookAllBookRec.SetRange(Year, rec.Year);
                                        BuyWisOdrBookAllBookRec.SetRange("Buyer Code", StyleMasterRec."Buyer No.");
                                        BuyWisOdrBookAllBookRec.SetRange("Brand Name", StyleMasterRec."Brand Name");
                                        BuyWisOdrBookAllBookRec.SetFilter(Type, '<>%1', 'T');
                                        if not BuyWisOdrBookAllBookRec.FindSet() then begin  //insert

                                            SeqNo += 1;
                                            //Insert new line
                                            //Done By Sachith on 16/02/23 (insert Brand No and Name)
                                            BuyWisOdrBookAllBookRec.Init();
                                            BuyWisOdrBookAllBookRec."No." := SeqNo;
                                            BuyWisOdrBookAllBookRec.Year := rec.Year;
                                            BuyWisOdrBookAllBookRec."Buyer Code" := StyleMasterRec."Buyer No.";
                                            BuyWisOdrBookAllBookRec."Buyer Name" := StyleMasterRec."Buyer Name";
                                            BuyWisOdrBookAllBookRec."Brand No" := StyleMasterRec."Brand No.";
                                            BuyWisOdrBookAllBookRec."Brand Name" := StyleMasterRec."Brand Name";
                                            BuyWisOdrBookAllBookRec.Type := 'L';

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

                                        // //Update Grand total
                                        // BuyWisOdrBookAllBookRec.Reset();
                                        // BuyWisOdrBookAllBookRec.SetRange(Year, rec.Year);
                                        // BuyWisOdrBookAllBookRec.SetFilter(Type, '=%1', 'T');
                                        // if BuyWisOdrBookAllBookRec.FindSet() then begin
                                        //     case i of
                                        //         1:
                                        //             BuyWisOdrBookAllBookRec.JAN := BuyWisOdrBookAllBookRec.JAN + StyleMasterPORec.Qty;
                                        //         2:
                                        //             BuyWisOdrBookAllBookRec.FEB := BuyWisOdrBookAllBookRec.FEB + StyleMasterPORec.Qty;
                                        //         3:
                                        //             BuyWisOdrBookAllBookRec.MAR := BuyWisOdrBookAllBookRec.MAR + StyleMasterPORec.Qty;
                                        //         4:
                                        //             BuyWisOdrBookAllBookRec.APR := BuyWisOdrBookAllBookRec.APR + StyleMasterPORec.Qty;
                                        //         5:
                                        //             BuyWisOdrBookAllBookRec.MAY := BuyWisOdrBookAllBookRec.MAY + StyleMasterPORec.Qty;
                                        //         6:
                                        //             BuyWisOdrBookAllBookRec.JUN := BuyWisOdrBookAllBookRec.JUN + StyleMasterPORec.Qty;
                                        //         7:
                                        //             BuyWisOdrBookAllBookRec.JUL := BuyWisOdrBookAllBookRec.JUL + StyleMasterPORec.Qty;
                                        //         8:
                                        //             BuyWisOdrBookAllBookRec.AUG := BuyWisOdrBookAllBookRec.AUG + StyleMasterPORec.Qty;
                                        //         9:
                                        //             BuyWisOdrBookAllBookRec.SEP := BuyWisOdrBookAllBookRec.SEP + StyleMasterPORec.Qty;
                                        //         10:
                                        //             BuyWisOdrBookAllBookRec.OCT := BuyWisOdrBookAllBookRec.OCT + StyleMasterPORec.Qty;
                                        //         11:
                                        //             BuyWisOdrBookAllBookRec.NOV := BuyWisOdrBookAllBookRec.NOV + StyleMasterPORec.Qty;
                                        //         12:
                                        //             BuyWisOdrBookAllBookRec.DEC := BuyWisOdrBookAllBookRec.DEC + StyleMasterPORec.Qty;
                                        //     end;
                                        //     BuyWisOdrBookAllBookRec.Total := BuyWisOdrBookAllBookRec.Total + StyleMasterPORec.Qty;
                                        //     BuyWisOdrBookAllBookRec.Modify();
                                        // end;
                                    end;

                                until StyleMasterPORec.Next() = 0;
                            end;

                            //Update Grand total
                            BuyWisOdrBookAllBookRec.Reset();
                            BuyWisOdrBookAllBookRec.SetRange(Year, rec.Year);
                            BuyWisOdrBookAllBookRec.SetFilter(Type, '=%1', 'T');
                            BuyWisOdrBookAllBookRec.FindSet();

                            case i of
                                1:
                                    begin
                                        BuyWisOdrBookAllBook1Rec.Reset();
                                        BuyWisOdrBookAllBook1Rec.SetRange(Year, rec.Year);
                                        BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                                        if BuyWisOdrBookAllBook1Rec.FindSet() then
                                            repeat
                                                BuyWisOdrBookAllBookRec.JAN := BuyWisOdrBookAllBookRec.JAN + BuyWisOdrBookAllBook1Rec.JAN;
                                            until BuyWisOdrBookAllBook1Rec.Next() = 0;
                                    end;

                                2:
                                    begin
                                        BuyWisOdrBookAllBook1Rec.Reset();
                                        BuyWisOdrBookAllBook1Rec.SetRange(Year, rec.Year);
                                        BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                                        if BuyWisOdrBookAllBook1Rec.FindSet() then
                                            repeat
                                                BuyWisOdrBookAllBookRec.FEB := BuyWisOdrBookAllBookRec.FEB + BuyWisOdrBookAllBook1Rec.FEB;
                                            until BuyWisOdrBookAllBook1Rec.Next() = 0;
                                    end;
                                3:
                                    begin
                                        BuyWisOdrBookAllBook1Rec.Reset();
                                        BuyWisOdrBookAllBook1Rec.SetRange(Year, rec.Year);
                                        BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                                        if BuyWisOdrBookAllBook1Rec.FindSet() then
                                            repeat
                                                BuyWisOdrBookAllBookRec.MAR := BuyWisOdrBookAllBookRec.MAR + BuyWisOdrBookAllBook1Rec.MAR;
                                            until BuyWisOdrBookAllBook1Rec.Next() = 0;
                                    end;
                                4:
                                    begin
                                        BuyWisOdrBookAllBook1Rec.Reset();
                                        BuyWisOdrBookAllBook1Rec.SetRange(Year, rec.Year);
                                        BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                                        if BuyWisOdrBookAllBook1Rec.FindSet() then
                                            repeat
                                                BuyWisOdrBookAllBookRec.APR := BuyWisOdrBookAllBookRec.APR + BuyWisOdrBookAllBook1Rec.APR;
                                            until BuyWisOdrBookAllBook1Rec.Next() = 0;
                                    end;
                                5:
                                    begin
                                        BuyWisOdrBookAllBook1Rec.Reset();
                                        BuyWisOdrBookAllBook1Rec.SetRange(Year, rec.Year);
                                        BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                                        if BuyWisOdrBookAllBook1Rec.FindSet() then
                                            repeat
                                                BuyWisOdrBookAllBookRec.MAY := BuyWisOdrBookAllBookRec.MAY + BuyWisOdrBookAllBook1Rec.MAY;
                                            until BuyWisOdrBookAllBook1Rec.Next() = 0;
                                    end;
                                6:
                                    begin
                                        BuyWisOdrBookAllBook1Rec.Reset();
                                        BuyWisOdrBookAllBook1Rec.SetRange(Year, rec.Year);
                                        BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                                        if BuyWisOdrBookAllBook1Rec.FindSet() then
                                            repeat
                                                BuyWisOdrBookAllBookRec.JUN := BuyWisOdrBookAllBookRec.JUN + BuyWisOdrBookAllBook1Rec.JUN;
                                            until BuyWisOdrBookAllBook1Rec.Next() = 0;
                                    end;
                                7:
                                    begin
                                        BuyWisOdrBookAllBook1Rec.Reset();
                                        BuyWisOdrBookAllBook1Rec.SetRange(Year, rec.Year);
                                        BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                                        if BuyWisOdrBookAllBook1Rec.FindSet() then
                                            repeat
                                                BuyWisOdrBookAllBookRec.JUL := BuyWisOdrBookAllBookRec.JUL + BuyWisOdrBookAllBook1Rec.JUL;
                                            until BuyWisOdrBookAllBook1Rec.Next() = 0;
                                    end;
                                8:
                                    begin
                                        BuyWisOdrBookAllBook1Rec.Reset();
                                        BuyWisOdrBookAllBook1Rec.SetRange(Year, rec.Year);
                                        BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                                        if BuyWisOdrBookAllBook1Rec.FindSet() then
                                            repeat
                                                BuyWisOdrBookAllBookRec.AUG := BuyWisOdrBookAllBookRec.AUG + BuyWisOdrBookAllBook1Rec.AUG;
                                            until BuyWisOdrBookAllBook1Rec.Next() = 0;
                                    end;
                                9:
                                    begin
                                        BuyWisOdrBookAllBook1Rec.Reset();
                                        BuyWisOdrBookAllBook1Rec.SetRange(Year, rec.Year);
                                        BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                                        if BuyWisOdrBookAllBook1Rec.FindSet() then
                                            repeat
                                                BuyWisOdrBookAllBookRec.SEP := BuyWisOdrBookAllBookRec.SEP + BuyWisOdrBookAllBook1Rec.SEP;
                                            until BuyWisOdrBookAllBook1Rec.Next() = 0;
                                    end;
                                10:
                                    begin
                                        BuyWisOdrBookAllBook1Rec.Reset();
                                        BuyWisOdrBookAllBook1Rec.SetRange(Year, rec.Year);
                                        BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                                        if BuyWisOdrBookAllBook1Rec.FindSet() then
                                            repeat
                                                BuyWisOdrBookAllBookRec.OCT := BuyWisOdrBookAllBookRec.OCT + BuyWisOdrBookAllBook1Rec.OCT;
                                            until BuyWisOdrBookAllBook1Rec.Next() = 0;
                                    end;
                                11:
                                    begin
                                        BuyWisOdrBookAllBook1Rec.Reset();
                                        BuyWisOdrBookAllBook1Rec.SetRange(Year, rec.Year);
                                        BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                                        if BuyWisOdrBookAllBook1Rec.FindSet() then
                                            repeat
                                                BuyWisOdrBookAllBookRec.NOV := BuyWisOdrBookAllBookRec.NOV + BuyWisOdrBookAllBook1Rec.NOV;
                                            until BuyWisOdrBookAllBook1Rec.Next() = 0;
                                    end;
                                12:
                                    begin
                                        BuyWisOdrBookAllBook1Rec.Reset();
                                        BuyWisOdrBookAllBook1Rec.SetRange(Year, rec.Year);
                                        BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                                        if BuyWisOdrBookAllBook1Rec.FindSet() then
                                            repeat
                                                BuyWisOdrBookAllBookRec.DEC := BuyWisOdrBookAllBookRec.DEC + BuyWisOdrBookAllBook1Rec.DEC;
                                            until BuyWisOdrBookAllBook1Rec.Next() = 0;
                                    end;
                            end;

                            BuyWisOdrBookAllBookRec.Modify();
                        end;


                        //Update Grand total of last column
                        BuyWisOdrBookAllBookRec.Reset();
                        BuyWisOdrBookAllBookRec.SetRange(Year, rec.Year);
                        BuyWisOdrBookAllBookRec.SetFilter(Type, '=%1', 'T');
                        if BuyWisOdrBookAllBookRec.FindSet() then begin

                            BuyWisOdrBookAllBook1Rec.Reset();
                            BuyWisOdrBookAllBook1Rec.SetRange(Year, rec.Year);
                            BuyWisOdrBookAllBook1Rec.SetFilter(Type, '<>%1', 'T');
                            if BuyWisOdrBookAllBook1Rec.FindSet() then
                                repeat
                                    BuyWisOdrBookAllBookRec.Total := BuyWisOdrBookAllBookRec.Total + BuyWisOdrBookAllBook1Rec.Total;
                                until BuyWisOdrBookAllBook1Rec.Next() = 0;

                            BuyWisOdrBookAllBookRec.Modify();

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
                        BuyWisOdrBookAllBookRec.SetCurrentKey("No.", "Buyer Name");
                        BuyWisOdrBookAllBookRec.Ascending(false);
                        BuyWisOdrBookAllBookRec.SetRange(Year, rec.Year);
                        BuyWisOdrBookAllBookRec.SetFilter(Type, '<>%1', 'T');
                        if BuyWisOdrBookAllBookRec.FindSet() then begin
                            repeat
                                //
                                //Insert new line
                                //Done By Sachith on 16/02/23 (insert Brand No and Name)
                                SeqNo += 1;
                                BuyerWiseOdrBookinBalatoSewRec.Init();
                                BuyerWiseOdrBookinBalatoSewRec."No." := SeqNo;
                                BuyerWiseOdrBookinBalatoSewRec.Year := BuyWisOdrBookAllBookRec.Year;
                                BuyerWiseOdrBookinBalatoSewRec."Buyer Code" := BuyWisOdrBookAllBookRec."Buyer Code";
                                BuyerWiseOdrBookinBalatoSewRec."Buyer Name" := BuyWisOdrBookAllBookRec."Buyer Name";
                                BuyerWiseOdrBookinBalatoSewRec."Brand No" := BuyWisOdrBookAllBookRec."Brand No";
                                BuyerWiseOdrBookinBalatoSewRec."Brand Name" := BuyWisOdrBookAllBookRec."Brand Name";
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
                                BuyerWiseOdrBookinBalatoSewRec.Type := BuyWisOdrBookAllBookRec.Type;
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

                            //Get styles within the period
                            StyleMasterPORec.Reset();
                            StyleMasterPORec.SetCurrentKey("Style No.");
                            StyleMasterPORec.Ascending(true);
                            StyleMasterPORec.SetRange("Ship Date", StartDate, FinishDate);
                            if StyleMasterPORec.FindSet() then begin

                                repeat

                                    //Get buyer Name/Code
                                    StyleMasterRec.Reset();
                                    StyleMasterRec.SetRange("No.", StyleMasterPORec."Style No.");
                                    StyleMasterRec.SetFilter("Buyer Name", '<>%1', '');
                                    StyleMasterRec.SetFilter(Status, '=%1', StyleMasterRec.Status::Confirmed);

                                    if StyleMasterRec.FindSet() then begin

                                        // //Get sewing out
                                        // ProductionOutHeaderRec.Reset();
                                        // ProductionOutHeaderRec.SetRange("Out Style No.", StyleMasterRec."No.");
                                        // ProductionOutHeaderRec.SetRange("OUT PO No", StyleMasterPORec."PO No.");
                                        // ProductionOutHeaderRec.SetFilter(Type, '=%1', ProductionOutHeaderRec.Type::Saw);

                                        // if ProductionOutHeaderRec.FindSet() then begin
                                        //     repeat

                                        // if (StyleMasterRec."Buyer Name" = 'Inditex') and (StyleMasterRec."Brand Name" = 'STRAVARIUS') then
                                        //     xxx := ProductionOutHeaderRec."No.";

                                        //Check existance
                                        BuyerWiseOdrBookinBalatoSewRec.Reset();
                                        BuyerWiseOdrBookinBalatoSewRec.SetRange(Year, rec.Year);
                                        BuyerWiseOdrBookinBalatoSewRec.SetRange("Buyer Code", StyleMasterRec."Buyer No.");
                                        BuyerWiseOdrBookinBalatoSewRec.SetRange("Brand No", StyleMasterRec."Brand No.");
                                        if BuyerWiseOdrBookinBalatoSewRec.FindSet() then begin

                                            case i of
                                                1:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoSewRec.JAN := BuyerWiseOdrBookinBalatoSewRec.JAN - StyleMasterPORec."Sawing Out Qty";
                                                        if BuyerWiseOdrBookinBalatoSewRec.JAN < 0 then
                                                            BuyerWiseOdrBookinBalatoSewRec.JAN := 0;
                                                    end;
                                                2:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoSewRec.FEB := BuyerWiseOdrBookinBalatoSewRec.FEB - StyleMasterPORec."Sawing Out Qty";
                                                        if BuyerWiseOdrBookinBalatoSewRec.FEB < 0 then
                                                            BuyerWiseOdrBookinBalatoSewRec.FEB := 0;
                                                    end;
                                                3:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoSewRec.MAR := BuyerWiseOdrBookinBalatoSewRec.MAR - StyleMasterPORec."Sawing Out Qty";
                                                        if BuyerWiseOdrBookinBalatoSewRec.MAR < 0 then
                                                            BuyerWiseOdrBookinBalatoSewRec.MAR := 0;
                                                    end;
                                                4:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoSewRec.APR := BuyerWiseOdrBookinBalatoSewRec.APR - StyleMasterPORec."Sawing Out Qty";
                                                        if BuyerWiseOdrBookinBalatoSewRec.APR < 0 then
                                                            BuyerWiseOdrBookinBalatoSewRec.APR := 0;
                                                    end;
                                                5:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoSewRec.MAY := BuyerWiseOdrBookinBalatoSewRec.MAY - StyleMasterPORec."Sawing Out Qty";
                                                        if BuyerWiseOdrBookinBalatoSewRec.MAY < 0 then
                                                            BuyerWiseOdrBookinBalatoSewRec.MAY := 0;
                                                    end;
                                                6:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoSewRec.JUN := BuyerWiseOdrBookinBalatoSewRec.JUN - StyleMasterPORec."Sawing Out Qty";
                                                        if BuyerWiseOdrBookinBalatoSewRec.JUN < 0 then
                                                            BuyerWiseOdrBookinBalatoSewRec.JUN := 0;
                                                    end;
                                                7:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoSewRec.JUL := BuyerWiseOdrBookinBalatoSewRec.JUL - StyleMasterPORec."Sawing Out Qty";
                                                        if BuyerWiseOdrBookinBalatoSewRec.JUL < 0 then
                                                            BuyerWiseOdrBookinBalatoSewRec.JUL := 0;
                                                    end;
                                                8:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoSewRec.AUG := BuyerWiseOdrBookinBalatoSewRec.AUG - StyleMasterPORec."Sawing Out Qty";
                                                        if BuyerWiseOdrBookinBalatoSewRec.AUG < 0 then
                                                            BuyerWiseOdrBookinBalatoSewRec.AUG := 0;
                                                    end;
                                                9:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoSewRec.SEP := BuyerWiseOdrBookinBalatoSewRec.SEP - StyleMasterPORec."Sawing Out Qty";
                                                        if BuyerWiseOdrBookinBalatoSewRec.SEP < 0 then
                                                            BuyerWiseOdrBookinBalatoSewRec.SEP := 0;
                                                    end;
                                                10:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoSewRec.OCT := BuyerWiseOdrBookinBalatoSewRec.OCT - StyleMasterPORec."Sawing Out Qty";
                                                        if BuyerWiseOdrBookinBalatoSewRec.OCT < 0 then
                                                            BuyerWiseOdrBookinBalatoSewRec.OCT := 0;
                                                    end;
                                                11:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoSewRec.NOV := BuyerWiseOdrBookinBalatoSewRec.NOV - StyleMasterPORec."Sawing Out Qty";
                                                        if BuyerWiseOdrBookinBalatoSewRec.NOV < 0 then
                                                            BuyerWiseOdrBookinBalatoSewRec.NOV := 0;
                                                    end;
                                                12:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoSewRec.DEC := BuyerWiseOdrBookinBalatoSewRec.DEC - StyleMasterPORec."Sawing Out Qty";
                                                        if BuyerWiseOdrBookinBalatoSewRec.DEC < 0 then
                                                            BuyerWiseOdrBookinBalatoSewRec.DEC := 0;
                                                    end;
                                            end;

                                            BuyerWiseOdrBookinBalatoSewRec.Total := BuyerWiseOdrBookinBalatoSewRec.Total - StyleMasterPORec."Sawing Out Qty";
                                            if BuyerWiseOdrBookinBalatoSewRec.Total < 0 then
                                                BuyerWiseOdrBookinBalatoSewRec.Total := 0;

                                            BuyerWiseOdrBookinBalatoSewRec.Modify();

                                        end
                                        else
                                            Error('cannot find record');

                                        //until ProductionOutHeaderRec.Next() = 0;
                                        //end;


                                        //  //if (StyleNo1 <> StyleMasterRec."No.") then begin

                                        // //Get sewing out
                                        // ProductionOutHeaderRec.Reset();
                                        // ProductionOutHeaderRec.SetRange("Out Style No.", StyleMasterRec."No.");
                                        // ProductionOutHeaderRec.SetRange("OUT PO No", StyleMasterPORec."PO No.");
                                        // ProductionOutHeaderRec.SetFilter(Type, '=%1', ProductionOutHeaderRec.Type::Saw);

                                        // if ProductionOutHeaderRec.FindSet() then begin
                                        //     repeat

                                        //         // if (StyleMasterRec."Buyer Name" = 'Inditex') and (StyleMasterRec."Brand Name" = 'STRAVARIUS') then
                                        //         //     xxx := ProductionOutHeaderRec."No.";

                                        //         //Check existance
                                        //         BuyerWiseOdrBookinBalatoSewRec.Reset();
                                        //         BuyerWiseOdrBookinBalatoSewRec.SetRange(Year, rec.Year);
                                        //         BuyerWiseOdrBookinBalatoSewRec.SetRange("Buyer Code", StyleMasterRec."Buyer No.");
                                        //         BuyerWiseOdrBookinBalatoSewRec.SetRange("Brand No", StyleMasterRec."Brand No.");
                                        //         if BuyerWiseOdrBookinBalatoSewRec.FindSet() then begin

                                        //             case i of
                                        //                 1:
                                        //                     begin
                                        //                         BuyerWiseOdrBookinBalatoSewRec.JAN := BuyerWiseOdrBookinBalatoSewRec.JAN - ProductionOutHeaderRec."Output Qty";
                                        //                         if BuyerWiseOdrBookinBalatoSewRec.JAN < 0 then
                                        //                             BuyerWiseOdrBookinBalatoSewRec.JAN := 0;
                                        //                     end;
                                        //                 2:
                                        //                     begin
                                        //                         BuyerWiseOdrBookinBalatoSewRec.FEB := BuyerWiseOdrBookinBalatoSewRec.FEB - ProductionOutHeaderRec."Output Qty";
                                        //                         if BuyerWiseOdrBookinBalatoSewRec.FEB < 0 then
                                        //                             BuyerWiseOdrBookinBalatoSewRec.FEB := 0;
                                        //                     end;
                                        //                 3:
                                        //                     begin
                                        //                         BuyerWiseOdrBookinBalatoSewRec.MAR := BuyerWiseOdrBookinBalatoSewRec.MAR - ProductionOutHeaderRec."Output Qty";
                                        //                         if BuyerWiseOdrBookinBalatoSewRec.MAR < 0 then
                                        //                             BuyerWiseOdrBookinBalatoSewRec.MAR := 0;
                                        //                     end;
                                        //                 4:
                                        //                     begin
                                        //                         BuyerWiseOdrBookinBalatoSewRec.APR := BuyerWiseOdrBookinBalatoSewRec.APR - ProductionOutHeaderRec."Output Qty";
                                        //                         if BuyerWiseOdrBookinBalatoSewRec.APR < 0 then
                                        //                             BuyerWiseOdrBookinBalatoSewRec.APR := 0;
                                        //                     end;
                                        //                 5:
                                        //                     begin
                                        //                         BuyerWiseOdrBookinBalatoSewRec.MAY := BuyerWiseOdrBookinBalatoSewRec.MAY - ProductionOutHeaderRec."Output Qty";
                                        //                         if BuyerWiseOdrBookinBalatoSewRec.MAY < 0 then
                                        //                             BuyerWiseOdrBookinBalatoSewRec.MAY := 0;
                                        //                     end;
                                        //                 6:
                                        //                     begin
                                        //                         BuyerWiseOdrBookinBalatoSewRec.JUN := BuyerWiseOdrBookinBalatoSewRec.JUN - ProductionOutHeaderRec."Output Qty";
                                        //                         if BuyerWiseOdrBookinBalatoSewRec.JUN < 0 then
                                        //                             BuyerWiseOdrBookinBalatoSewRec.JUN := 0;
                                        //                     end;
                                        //                 7:
                                        //                     begin
                                        //                         BuyerWiseOdrBookinBalatoSewRec.JUL := BuyerWiseOdrBookinBalatoSewRec.JUL - ProductionOutHeaderRec."Output Qty";
                                        //                         if BuyerWiseOdrBookinBalatoSewRec.JUL < 0 then
                                        //                             BuyerWiseOdrBookinBalatoSewRec.JUL := 0;
                                        //                     end;
                                        //                 8:
                                        //                     begin
                                        //                         BuyerWiseOdrBookinBalatoSewRec.AUG := BuyerWiseOdrBookinBalatoSewRec.AUG - ProductionOutHeaderRec."Output Qty";
                                        //                         if BuyerWiseOdrBookinBalatoSewRec.AUG < 0 then
                                        //                             BuyerWiseOdrBookinBalatoSewRec.AUG := 0;
                                        //                     end;
                                        //                 9:
                                        //                     begin
                                        //                         BuyerWiseOdrBookinBalatoSewRec.SEP := BuyerWiseOdrBookinBalatoSewRec.SEP - ProductionOutHeaderRec."Output Qty";
                                        //                         if BuyerWiseOdrBookinBalatoSewRec.SEP < 0 then
                                        //                             BuyerWiseOdrBookinBalatoSewRec.SEP := 0;
                                        //                     end;
                                        //                 10:
                                        //                     begin
                                        //                         BuyerWiseOdrBookinBalatoSewRec.OCT := BuyerWiseOdrBookinBalatoSewRec.OCT - ProductionOutHeaderRec."Output Qty";
                                        //                         if BuyerWiseOdrBookinBalatoSewRec.OCT < 0 then
                                        //                             BuyerWiseOdrBookinBalatoSewRec.OCT := 0;
                                        //                     end;
                                        //                 11:
                                        //                     begin
                                        //                         BuyerWiseOdrBookinBalatoSewRec.NOV := BuyerWiseOdrBookinBalatoSewRec.NOV - ProductionOutHeaderRec."Output Qty";
                                        //                         if BuyerWiseOdrBookinBalatoSewRec.NOV < 0 then
                                        //                             BuyerWiseOdrBookinBalatoSewRec.NOV := 0;
                                        //                     end;
                                        //                 12:
                                        //                     begin
                                        //                         BuyerWiseOdrBookinBalatoSewRec.DEC := BuyerWiseOdrBookinBalatoSewRec.DEC - ProductionOutHeaderRec."Output Qty";
                                        //                         if BuyerWiseOdrBookinBalatoSewRec.DEC < 0 then
                                        //                             BuyerWiseOdrBookinBalatoSewRec.DEC := 0;
                                        //                     end;
                                        //             end;

                                        //             BuyerWiseOdrBookinBalatoSewRec.Total := BuyerWiseOdrBookinBalatoSewRec.Total - ProductionOutHeaderRec."Output Qty";
                                        //             if BuyerWiseOdrBookinBalatoSewRec.Total < 0 then
                                        //                 BuyerWiseOdrBookinBalatoSewRec.Total := 0;

                                        //             BuyerWiseOdrBookinBalatoSewRec.Modify();

                                        //         end
                                        //         else
                                        //             Error('cannot find record');
                                        //     until ProductionOutHeaderRec.Next() = 0;
                                        // end;
                                        // //StyleNo1 := StyleMasterRec."No.";
                                        // //end;


                                    end;

                                until StyleMasterPORec.Next() = 0;
                            end;
                        end;


                        //Insert total record
                        SeqNo += 1;
                        BuyerWiseOdrBookinBalatoSewTotRec.Init();
                        BuyerWiseOdrBookinBalatoSewTotRec."No." := SeqNo;
                        BuyerWiseOdrBookinBalatoSewTotRec.Year := rec.Year;
                        BuyerWiseOdrBookinBalatoSewTotRec."Buyer Code" := ' ';
                        BuyerWiseOdrBookinBalatoSewTotRec."Buyer Name" := 'Total';
                        BuyerWiseOdrBookinBalatoSewTotRec.Type := 'T';
                        BuyerWiseOdrBookinBalatoSewTotRec."Created User" := UserId;
                        BuyerWiseOdrBookinBalatoSewTotRec."Created Date" := WorkDate();
                        BuyerWiseOdrBookinBalatoSewTotRec.Insert();

                        //Update Grand total
                        BuyerWiseOdrBookinBalatoSewTotRec.Reset();
                        BuyerWiseOdrBookinBalatoSewTotRec.SetRange(Year, rec.Year);
                        BuyerWiseOdrBookinBalatoSewTotRec.SetFilter(Type, '=%1', 'T');
                        BuyerWiseOdrBookinBalatoSewTotRec.FindSet();

                        BuyerWiseOdrBookinBalatoSewRec.Reset();
                        BuyerWiseOdrBookinBalatoSewRec.SetRange(Year, rec.Year);
                        BuyerWiseOdrBookinBalatoSewRec.SetFilter(Type, '<>%1', 'T');
                        if BuyerWiseOdrBookinBalatoSewRec.FindSet() then begin
                            repeat
                                BuyerWiseOdrBookinBalatoSewTotRec.JAN := BuyerWiseOdrBookinBalatoSewTotRec.JAN + BuyerWiseOdrBookinBalatoSewRec.JAN;
                                BuyerWiseOdrBookinBalatoSewTotRec.FEB := BuyerWiseOdrBookinBalatoSewTotRec.FEB + BuyerWiseOdrBookinBalatoSewRec.FEB;
                                BuyerWiseOdrBookinBalatoSewTotRec.MAR := BuyerWiseOdrBookinBalatoSewTotRec.MAR + BuyerWiseOdrBookinBalatoSewRec.MAR;
                                BuyerWiseOdrBookinBalatoSewTotRec.APR := BuyerWiseOdrBookinBalatoSewTotRec.APR + BuyerWiseOdrBookinBalatoSewRec.APR;
                                BuyerWiseOdrBookinBalatoSewTotRec.MAY := BuyerWiseOdrBookinBalatoSewTotRec.MAY + BuyerWiseOdrBookinBalatoSewRec.MAY;
                                BuyerWiseOdrBookinBalatoSewTotRec.JUN := BuyerWiseOdrBookinBalatoSewTotRec.JUN + BuyerWiseOdrBookinBalatoSewRec.JUN;
                                BuyerWiseOdrBookinBalatoSewTotRec.JUL := BuyerWiseOdrBookinBalatoSewTotRec.JUL + BuyerWiseOdrBookinBalatoSewRec.JUL;
                                BuyerWiseOdrBookinBalatoSewTotRec.AUG := BuyerWiseOdrBookinBalatoSewTotRec.AUG + BuyerWiseOdrBookinBalatoSewRec.AUG;
                                BuyerWiseOdrBookinBalatoSewTotRec.SEP := BuyerWiseOdrBookinBalatoSewTotRec.SEP + BuyerWiseOdrBookinBalatoSewRec.sep;
                                BuyerWiseOdrBookinBalatoSewTotRec.OCT := BuyerWiseOdrBookinBalatoSewTotRec.OCT + BuyerWiseOdrBookinBalatoSewRec.OCT;
                                BuyerWiseOdrBookinBalatoSewTotRec.NOV := BuyerWiseOdrBookinBalatoSewTotRec.NOV + BuyerWiseOdrBookinBalatoSewRec.NOV;
                                BuyerWiseOdrBookinBalatoSewTotRec.DEC := BuyerWiseOdrBookinBalatoSewTotRec.DEC + BuyerWiseOdrBookinBalatoSewRec.DEC;
                                BuyerWiseOdrBookinBalatoSewTotRec.Total := BuyerWiseOdrBookinBalatoSewTotRec.Total + BuyerWiseOdrBookinBalatoSewRec.Total;
                            until BuyerWiseOdrBookinBalatoSewRec.Next() = 0;
                        end;

                        BuyerWiseOdrBookinBalatoSewTotRec.Modify();



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
                        BuyWisOdrBookAllBookRec.SetCurrentKey("No.", "Buyer Name");
                        BuyWisOdrBookAllBookRec.Ascending(false);
                        BuyWisOdrBookAllBookRec.SetRange(Year, rec.Year);
                        BuyWisOdrBookAllBookRec.SetFilter(Type, '<>%1', 'T');
                        if BuyWisOdrBookAllBookRec.FindSet() then begin
                            repeat
                                //Insert new line
                                //Done By Sachith on 16/02/23 (insert Brand No and Name)
                                SeqNo += 1;
                                BuyerWiseOdrBookinBalatoShipRec.Init();
                                BuyerWiseOdrBookinBalatoShipRec."No." := SeqNo;
                                BuyerWiseOdrBookinBalatoShipRec.Year := BuyWisOdrBookAllBookRec.Year;
                                BuyerWiseOdrBookinBalatoShipRec."Buyer Code" := BuyWisOdrBookAllBookRec."Buyer Code";
                                BuyerWiseOdrBookinBalatoShipRec."Buyer Name" := BuyWisOdrBookAllBookRec."Buyer Name";
                                BuyerWiseOdrBookinBalatoShipRec."Brand No" := BuyWisOdrBookAllBookRec."Brand No";
                                BuyerWiseOdrBookinBalatoShipRec."Brand Name" := BuyWisOdrBookAllBookRec."Brand Name";
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
                                BuyerWiseOdrBookinBalatoShipRec.Type := BuyWisOdrBookAllBookRec.Type;
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

                            //Get styles within the period
                            StyleMasterPORec.Reset();
                            StyleMasterPORec.SetCurrentKey("Style No.");
                            StyleMasterPORec.Ascending(true);
                            StyleMasterPORec.SetRange("Ship Date", StartDate, FinishDate);
                            if StyleMasterPORec.FindSet() then begin

                                repeat

                                    Tot := 0;
                                    //Get buyer Name/Code
                                    StyleMasterRec.Reset();
                                    StyleMasterRec.SetRange("No.", StyleMasterPORec."Style No.");
                                    StyleMasterRec.SetFilter("Buyer Name", '<>%1', '');
                                    StyleMasterRec.SetFilter(Status, '=%1', StyleMasterRec.Status::Confirmed);

                                    if StyleMasterRec.FindSet() then begin

                                        //Get postes salin invoices for the style / po
                                        PostSalesInvHeaderRec.Reset();
                                        PostSalesInvHeaderRec.SetRange("Style No", StyleMasterPORec."Style No.");
                                        PostSalesInvHeaderRec.SetRange("po No", StyleMasterPORec."po No.");

                                        //Get sales line for the sales invoice
                                        if PostSalesInvHeaderRec.FindSet() then begin
                                            repeat
                                                PostSalesInvLineRec.Reset();
                                                PostSalesInvLineRec.SetFilter("Document No.", PostSalesInvHeaderRec."No.");

                                                if PostSalesInvLineRec.FindSet() then begin
                                                    repeat
                                                        Tot += PostSalesInvLineRec.Quantity;
                                                    until PostSalesInvLineRec.Next() = 0;
                                                end

                                            until PostSalesInvHeaderRec.Next() = 0;
                                        end;


                                        //Check existance
                                        BuyerWiseOdrBookinBalatoShipRec.Reset();
                                        BuyerWiseOdrBookinBalatoShipRec.SetRange(Year, rec.Year);
                                        BuyerWiseOdrBookinBalatoShipRec.SetRange("Buyer Code", StyleMasterRec."Buyer No.");
                                        BuyerWiseOdrBookinBalatoShipRec.SetRange("Brand No", StyleMasterRec."Brand No.");
                                        if BuyerWiseOdrBookinBalatoShipRec.FindSet() then begin

                                            case i of
                                                1:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoShipRec.JAN := BuyerWiseOdrBookinBalatoShipRec.JAN - Tot;
                                                        if BuyerWiseOdrBookinBalatoShipRec.JAN < 0 then
                                                            BuyerWiseOdrBookinBalatoShipRec.JAN := 0;
                                                    end;
                                                2:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoShipRec.FEB := BuyerWiseOdrBookinBalatoShipRec.FEB - Tot;
                                                        if BuyerWiseOdrBookinBalatoShipRec.FEB < 0 then
                                                            BuyerWiseOdrBookinBalatoShipRec.FEB := 0;
                                                    end;
                                                3:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoShipRec.MAR := BuyerWiseOdrBookinBalatoShipRec.MAR - Tot;
                                                        if BuyerWiseOdrBookinBalatoShipRec.MAR < 0 then
                                                            BuyerWiseOdrBookinBalatoShipRec.MAR := 0;
                                                    end;
                                                4:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoShipRec.APR := BuyerWiseOdrBookinBalatoShipRec.APR - Tot;
                                                        if BuyerWiseOdrBookinBalatoShipRec.APR < 0 then
                                                            BuyerWiseOdrBookinBalatoShipRec.APR := 0;
                                                    end;
                                                5:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoShipRec.MAY := BuyerWiseOdrBookinBalatoShipRec.MAY - Tot;
                                                        if BuyerWiseOdrBookinBalatoShipRec.MAY < 0 then
                                                            BuyerWiseOdrBookinBalatoShipRec.MAY := 0;
                                                    end;
                                                6:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoShipRec.JUN := BuyerWiseOdrBookinBalatoShipRec.JUN - Tot;
                                                        if BuyerWiseOdrBookinBalatoShipRec.JUN < 0 then
                                                            BuyerWiseOdrBookinBalatoShipRec.JUN := 0;
                                                    end;
                                                7:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoShipRec.JUL := BuyerWiseOdrBookinBalatoShipRec.JUL - Tot;
                                                        if BuyerWiseOdrBookinBalatoShipRec.JUL < 0 then
                                                            BuyerWiseOdrBookinBalatoShipRec.JUL := 0;
                                                    end;
                                                8:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoShipRec.AUG := BuyerWiseOdrBookinBalatoShipRec.AUG - Tot;
                                                        if BuyerWiseOdrBookinBalatoShipRec.AUG < 0 then
                                                            BuyerWiseOdrBookinBalatoShipRec.AUG := 0;
                                                    end;
                                                9:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoShipRec.SEP := BuyerWiseOdrBookinBalatoShipRec.SEP - Tot;
                                                        if BuyerWiseOdrBookinBalatoShipRec.SEP < 0 then
                                                            BuyerWiseOdrBookinBalatoShipRec.SEP := 0;
                                                    end;
                                                10:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoShipRec.OCT := BuyerWiseOdrBookinBalatoShipRec.OCT - Tot;
                                                        if BuyerWiseOdrBookinBalatoShipRec.OCT < 0 then
                                                            BuyerWiseOdrBookinBalatoShipRec.OCT := 0;
                                                    end;
                                                11:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoShipRec.NOV := BuyerWiseOdrBookinBalatoShipRec.NOV - Tot;
                                                        if BuyerWiseOdrBookinBalatoShipRec.NOV < 0 then
                                                            BuyerWiseOdrBookinBalatoShipRec.NOV := 0;
                                                    end;
                                                12:
                                                    begin
                                                        BuyerWiseOdrBookinBalatoShipRec.DEC := BuyerWiseOdrBookinBalatoShipRec.DEC - Tot;
                                                        if BuyerWiseOdrBookinBalatoShipRec.DEC < 0 then
                                                            BuyerWiseOdrBookinBalatoShipRec.DEC := 0;
                                                    end;
                                            end;

                                            BuyerWiseOdrBookinBalatoShipRec.Total := BuyerWiseOdrBookinBalatoShipRec.Total - Tot;
                                            if BuyerWiseOdrBookinBalatoShipRec.Total < 0 then
                                                BuyerWiseOdrBookinBalatoShipRec.Total := 0;

                                            BuyerWiseOdrBookinBalatoShipRec.Modify();

                                        end
                                        else
                                            Error('cannot find record');

                                    end;

                                until StyleMasterPORec.Next() = 0;
                            end;

                        end;

                        //Insert total record
                        SeqNo += 1;
                        BuyerWiseOdrBookinBalatoShipRec.Init();
                        BuyerWiseOdrBookinBalatoShipRec."No." := SeqNo;
                        BuyerWiseOdrBookinBalatoShipRec.Year := rec.Year;
                        BuyerWiseOdrBookinBalatoShipRec."Buyer Code" := ' ';
                        BuyerWiseOdrBookinBalatoShipRec."Buyer Name" := 'Total';
                        BuyerWiseOdrBookinBalatoShipRec.Type := 'T';
                        BuyerWiseOdrBookinBalatoShipRec."Created User" := UserId;
                        BuyerWiseOdrBookinBalatoShipRec."Created Date" := WorkDate();
                        BuyerWiseOdrBookinBalatoShipRec.Insert();

                        //Update Grand total
                        BuyerWiseOdrBookinBalatoShipRec.Reset();
                        BuyerWiseOdrBookinBalatoShipRec.SetRange(Year, rec.Year);
                        BuyerWiseOdrBookinBalatoShipRec.SetFilter(Type, '=%1', 'T');
                        BuyerWiseOdrBookinBalatoShipRec.FindSet();

                        BuyerWiseOdrBookinBalatoShipTotRec.Reset();
                        BuyerWiseOdrBookinBalatoShipTotRec.SetRange(Year, rec.Year);
                        BuyerWiseOdrBookinBalatoShipTotRec.SetFilter(Type, '<>%1', 'T');
                        if BuyerWiseOdrBookinBalatoShipTotRec.FindSet() then begin
                            repeat
                                BuyerWiseOdrBookinBalatoShipRec.JAN := BuyerWiseOdrBookinBalatoShipRec.JAN + BuyerWiseOdrBookinBalatoShipTotRec.JAN;
                                BuyerWiseOdrBookinBalatoShipRec.FEB := BuyerWiseOdrBookinBalatoShipRec.FEB + BuyerWiseOdrBookinBalatoShipTotRec.FEB;
                                BuyerWiseOdrBookinBalatoShipRec.MAR := BuyerWiseOdrBookinBalatoShipRec.MAR + BuyerWiseOdrBookinBalatoShipTotRec.MAR;
                                BuyerWiseOdrBookinBalatoShipRec.APR := BuyerWiseOdrBookinBalatoShipRec.APR + BuyerWiseOdrBookinBalatoShipTotRec.APR;
                                BuyerWiseOdrBookinBalatoShipRec.MAY := BuyerWiseOdrBookinBalatoShipRec.MAY + BuyerWiseOdrBookinBalatoShipTotRec.MAY;
                                BuyerWiseOdrBookinBalatoShipRec.JUN := BuyerWiseOdrBookinBalatoShipRec.JUN + BuyerWiseOdrBookinBalatoShipTotRec.JUN;
                                BuyerWiseOdrBookinBalatoShipRec.JUL := BuyerWiseOdrBookinBalatoShipRec.JUL + BuyerWiseOdrBookinBalatoShipTotRec.JUL;
                                BuyerWiseOdrBookinBalatoShipRec.AUG := BuyerWiseOdrBookinBalatoShipRec.AUG + BuyerWiseOdrBookinBalatoShipTotRec.AUG;
                                BuyerWiseOdrBookinBalatoShipRec.SEP := BuyerWiseOdrBookinBalatoShipRec.SEP + BuyerWiseOdrBookinBalatoShipTotRec.sep;
                                BuyerWiseOdrBookinBalatoShipRec.OCT := BuyerWiseOdrBookinBalatoShipRec.OCT + BuyerWiseOdrBookinBalatoShipTotRec.OCT;
                                BuyerWiseOdrBookinBalatoShipRec.NOV := BuyerWiseOdrBookinBalatoShipRec.NOV + BuyerWiseOdrBookinBalatoShipTotRec.NOV;
                                BuyerWiseOdrBookinBalatoShipRec.DEC := BuyerWiseOdrBookinBalatoShipRec.DEC + BuyerWiseOdrBookinBalatoShipTotRec.DEC;
                                BuyerWiseOdrBookinBalatoShipRec.Total := BuyerWiseOdrBookinBalatoShipRec.Total + BuyerWiseOdrBookinBalatoShipTotRec.Total;
                            until BuyerWiseOdrBookinBalatoShipTotRec.Next() = 0;
                        end;

                        BuyerWiseOdrBookinBalatoShipRec.Modify();


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
                                    BuyerWiseOdrBookinGRWiseBookRec.Type := 'L';
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

                        //Insert Grand total line
                        BuyerWiseOdrBookinGRWiseBookRec.Init();
                        BuyerWiseOdrBookinGRWiseBookRec."No." := SeqNo;
                        BuyerWiseOdrBookinGRWiseBookRec.Year := rec.Year;
                        BuyerWiseOdrBookinGRWiseBookRec."Group Id" := 'Total';
                        BuyerWiseOdrBookinGRWiseBookRec."Group Head" := 'Total';
                        BuyerWiseOdrBookinGRWiseBookRec."Group Name" := 'Total';
                        BuyerWiseOdrBookinGRWiseBookRec.Type := 'T';
                        BuyerWiseOdrBookinGRWiseBookRec."Created User" := UserId;
                        BuyerWiseOdrBookinGRWiseBookRec."Created Date" := WorkDate();
                        BuyerWiseOdrBookinGRWiseBookRec.Insert();

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
                            StyleMasterPORec.SetCurrentKey("Style No.");
                            StyleMasterPORec.Ascending(true);
                            StyleMasterPORec.SetRange("Ship Date", StartDate, FinishDate);
                            if StyleMasterPORec.FindSet() then begin
                                repeat

                                    //Get buyer for the style
                                    StyleMasterRec.Reset();
                                    StyleMasterRec.SetRange("No.", StyleMasterPORec."Style No.");
                                    StyleMasterRec.SetFilter("Buyer Name", '<>%1', '');
                                    StyleMasterRec.SetFilter(Status, '=%1', StyleMasterRec.Status::Confirmed);
                                    if StyleMasterRec.FindSet() then begin

                                        //Get merchnadizer group for the buyer
                                        CustomerRec.Reset();
                                        CustomerRec.SetRange("No.", StyleMasterRec."Buyer No.");
                                        if CustomerRec.FindSet() then begin

                                            //Check existance
                                            BuyerWiseOdrBookinGRWiseBookRec.Reset();
                                            BuyerWiseOdrBookinGRWiseBookRec.SetRange(Year, rec.Year);
                                            BuyerWiseOdrBookinGRWiseBookRec.SetRange("Group Id", CustomerRec."Group Id");
                                            BuyerWiseOdrBookinGRWiseBookRec.SetFilter(Type, '<>%1', 'T');
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

                                            //Update Grand total
                                            BuyerWiseOdrBookinGRWiseBookRec.Reset();
                                            BuyerWiseOdrBookinGRWiseBookRec.SetRange(Year, rec.Year);
                                            BuyerWiseOdrBookinGRWiseBookRec.SetFilter(Type, '=%1', 'T');
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

            action("All Booking Chart")
            {
                ApplicationArea = All;
                Image = BarChart;

                trigger OnAction()
                var
                    BuyWisOdrBookAllBookDashBoardPage: Page BuyWisOdrBookAllBookDashBoard;
                begin
                    BuyWisOdrBookAllBookDashBoardPage.Editable(true);
                    BuyWisOdrBookAllBookDashBoardPage.Run();
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