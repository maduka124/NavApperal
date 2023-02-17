codeunit 51175 "CodeUnitJobQueue-AllBooking"
{
    procedure Proc1()
    var
        BuyWisOdrBookAllBookRec: Record BuyerWiseOdrBookingAllBookPBi1;
        StyleMasterRec: Record "Style Master";
        StyleMasterPORec: Record "Style Master PO";
        i: Integer;
        StartDate: date;
        FinishDate: Date;
        SeqNo: BigInteger;
        TempID: Text[500];
        MonthName: Text[100];
        Y: Integer;
    begin

        evaluate(Y, copystr(Format(Today()), 7, 2));
        Y := 2000 + Y;

        //Delete old data
        BuyWisOdrBookAllBookRec.Reset();
        BuyWisOdrBookAllBookRec.SetRange(Year, Y);
        if BuyWisOdrBookAllBookRec.FindSet() then
            BuyWisOdrBookAllBookRec.DeleteAll();

        for i := 1 to 12 do begin

            StartDate := DMY2DATE(1, i, Y);

            case i of
                1:
                    FinishDate := DMY2DATE(31, i, Y);
                2:
                    begin
                        if Y mod 4 = 0 then
                            FinishDate := DMY2DATE(29, i, Y)
                        else
                            FinishDate := DMY2DATE(28, i, Y);
                    end;
                3:
                    FinishDate := DMY2DATE(31, i, Y);
                4:
                    FinishDate := DMY2DATE(30, i, Y);
                5:
                    FinishDate := DMY2DATE(31, i, Y);
                6:
                    FinishDate := DMY2DATE(30, i, Y);
                7:
                    FinishDate := DMY2DATE(31, i, Y);
                8:
                    FinishDate := DMY2DATE(31, i, Y);
                9:
                    FinishDate := DMY2DATE(30, i, Y);
                10:
                    FinishDate := DMY2DATE(31, i, Y);
                11:
                    FinishDate := DMY2DATE(30, i, Y);
                12:
                    FinishDate := DMY2DATE(31, i, Y);
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
                        BuyWisOdrBookAllBookRec.SetRange(Year, Y);
                        BuyWisOdrBookAllBookRec.SetRange("Buyer Code", StyleMasterRec."Buyer No.");
                        BuyWisOdrBookAllBookRec.SetRange("Brand No", StyleMasterRec."Brand No.");
                        BuyWisOdrBookAllBookRec.SetRange(MonthNo, i);

                        if not BuyWisOdrBookAllBookRec.FindSet() then begin  //insert

                            SeqNo += 1;

                            case i of
                                1:
                                    MonthName := 'JAN';
                                2:
                                    MonthName := 'FEB';
                                3:
                                    MonthName := 'MAR';
                                4:
                                    MonthName := 'APR';
                                5:
                                    MonthName := 'MAY';
                                6:
                                    MonthName := 'JUN';
                                7:
                                    MonthName := 'JUL';
                                8:
                                    MonthName := 'AUG';
                                9:
                                    MonthName := 'SEP';
                                10:
                                    MonthName := 'OCT';
                                11:
                                    MonthName := 'NOV';
                                12:
                                    MonthName := 'DEC';
                            end;

                            // Done By Sachith 16/02/23 (insert Brand Name and No )
                            //Insert new line
                            BuyWisOdrBookAllBookRec.Init();
                            BuyWisOdrBookAllBookRec.Year := Y;
                            BuyWisOdrBookAllBookRec."Buyer Code" := StyleMasterRec."Buyer No.";
                            BuyWisOdrBookAllBookRec."Buyer Name" := StyleMasterRec."Buyer Name";
                            BuyWisOdrBookAllBookRec."Brand No" := StyleMasterRec."Brand No.";
                            BuyWisOdrBookAllBookRec."Brand Name" := StyleMasterRec."Brand Name";
                            BuyWisOdrBookAllBookRec.MonthName := MonthName;
                            BuyWisOdrBookAllBookRec.MonthNo := i;
                            BuyWisOdrBookAllBookRec.Value := StyleMasterPORec.Qty;
                            BuyWisOdrBookAllBookRec."Created User" := UserId;
                            BuyWisOdrBookAllBookRec."Created Date" := WorkDate();
                            BuyWisOdrBookAllBookRec.Insert();

                        end
                        else begin  //Modify
                            BuyWisOdrBookAllBookRec.Value := BuyWisOdrBookAllBookRec.Value + StyleMasterPORec.Qty;
                            BuyWisOdrBookAllBookRec.Modify();
                        end;
                    end;

                until StyleMasterPORec.Next() = 0;
            end;
        end;
    end;



    trigger OnRun()
    var
    begin
        Proc1();
    end;

}
