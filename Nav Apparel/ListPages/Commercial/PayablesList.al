page 50549 "Payable Chart - Approved"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AcceptanceHeader;
    SourceTableView = sorting("AccNo.") order(descending) where(Approved = filter(true), Paid = filter(false));
    //Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Payable Chart';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("AccNo."; "AccNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                    Editable = false;
                }

                field("B2BLC No"; "B2BLC No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Suppler Name"; "Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';
                    Editable = false;
                }

                field("Accept Value"; "Accept Value")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Accept Date"; "Accept Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Acceptance S/N"; "Acceptance S/N")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Maturity Date"; "Maturity Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("LC Issue Bank"; "LC Issue Bank")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Bank Amount"; "Bank Amount")
                {
                    ApplicationArea = All;
                }

                field("Payment Mode"; "Payment Mode")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Approved; Approved)
                {
                    ApplicationArea = All;
                    Caption = 'Approved Status';
                    Editable = false;
                }

                field(ApproveDate; ApproveDate)
                {
                    ApplicationArea = All;
                    Caption = 'Approved Date';
                    Editable = false;
                }

                field(Paid; Paid)
                {
                    ApplicationArea = All;
                    Caption = 'Paid Status';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Paidd")
            {
                ApplicationArea = all;
                Image = Payables;
                Caption = 'Paid';

                trigger OnAction()
                var
                    SuppPayRec: Record SupplierPayments;
                    PayJrnlPage: page "Payment Journal";
                    Y: Integer;
                    M: Integer;
                    TempValue1: Decimal;
                    TempValue2: Decimal;
                    GenJournalRec: Record "Gen. Journal Line";
                    NavAppSetupRec: Record "NavApp Setup";
                    B2BLCRec: Record B2BLCMaster;
                    LineNo: BigInteger;
                begin

                    if "Bank Amount" = 0 then
                        Error('Bank amount is blank.');

                    Paid := true;
                    PaidDate := Today;

                    evaluate(Y, copystr(Format(Today), 1, 2));
                    Y := Y + 2000;
                    evaluate(M, copystr(Format(Today), 4, 2));

                    SuppPayRec.Reset();
                    SuppPayRec.SetRange("Suppler No.", "Suppler No.");
                    SuppPayRec.SetRange(Year, Y);

                    if SuppPayRec.FindSet() then begin

                        case M of
                            1:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.January);
                                    TempValue2 := TempValue1 + "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            2:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.February);
                                    TempValue2 := TempValue1 + "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            3:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.March);
                                    TempValue2 := TempValue1 + "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            4:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.April);
                                    TempValue2 := TempValue1 + "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            5:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.May);
                                    TempValue2 := TempValue1 + "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            6:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.June);
                                    TempValue2 := TempValue1 + "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            7:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.July);
                                    TempValue2 := TempValue1 + "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            8:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.August);
                                    TempValue2 := TempValue1 + "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            9:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.September);
                                    TempValue2 := TempValue1 + "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            10:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.October);
                                    TempValue2 := TempValue1 + "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            11:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.November);
                                    TempValue2 := TempValue1 + "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            12:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.December);
                                    TempValue2 := TempValue1 + "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                        end;

                        SuppPayRec.Modify();

                    end
                    else begin
                        SuppPayRec.Init();
                        SuppPayRec."Suppler No." := "Suppler No.";
                        SuppPayRec."Suppler Name" := "Suppler Name";
                        SuppPayRec.Year := Y;

                        case M of
                            1:
                                begin
                                    SuppPayRec.January := format("Accept Value");
                                    SuppPayRec.February := '0';
                                    SuppPayRec.March := '0';
                                    SuppPayRec.April := '0';
                                    SuppPayRec.May := '0';
                                    SuppPayRec.June := '0';
                                    SuppPayRec.July := '0';
                                    SuppPayRec.August := '0';
                                    SuppPayRec.September := '0';
                                    SuppPayRec.October := '0';
                                    SuppPayRec.November := '0';
                                    SuppPayRec.December := '0';
                                end;
                            2:
                                begin
                                    SuppPayRec.January := '0';
                                    SuppPayRec.February := format("Accept Value");
                                    SuppPayRec.March := '0';
                                    SuppPayRec.April := '0';
                                    SuppPayRec.May := '0';
                                    SuppPayRec.June := '0';
                                    SuppPayRec.July := '0';
                                    SuppPayRec.August := '0';
                                    SuppPayRec.September := '0';
                                    SuppPayRec.October := '0';
                                    SuppPayRec.November := '0';
                                    SuppPayRec.December := '0';
                                end;
                            3:
                                begin
                                    SuppPayRec.January := '0';
                                    SuppPayRec.February := '0';
                                    SuppPayRec.March := format("Accept Value");
                                    SuppPayRec.April := '0';
                                    SuppPayRec.May := '0';
                                    SuppPayRec.June := '0';
                                    SuppPayRec.July := '0';
                                    SuppPayRec.August := '0';
                                    SuppPayRec.September := '0';
                                    SuppPayRec.October := '0';
                                    SuppPayRec.November := '0';
                                    SuppPayRec.December := '0';
                                end;
                            4:
                                begin
                                    SuppPayRec.January := '0';
                                    SuppPayRec.February := '0';
                                    SuppPayRec.March := '0';
                                    SuppPayRec.April := format("Accept Value");
                                    SuppPayRec.May := '0';
                                    SuppPayRec.June := '0';
                                    SuppPayRec.July := '0';
                                    SuppPayRec.August := '0';
                                    SuppPayRec.September := '0';
                                    SuppPayRec.October := '0';
                                    SuppPayRec.November := '0';
                                    SuppPayRec.December := '0';
                                end;
                            5:
                                begin
                                    SuppPayRec.January := '0';
                                    SuppPayRec.February := '0';
                                    SuppPayRec.March := '0';
                                    SuppPayRec.April := '0';
                                    SuppPayRec.May := format("Accept Value");
                                    SuppPayRec.June := '0';
                                    SuppPayRec.July := '0';
                                    SuppPayRec.August := '0';
                                    SuppPayRec.September := '0';
                                    SuppPayRec.October := '0';
                                    SuppPayRec.November := '0';
                                    SuppPayRec.December := '0';
                                end;
                            6:
                                begin
                                    SuppPayRec.January := '0';
                                    SuppPayRec.February := '0';
                                    SuppPayRec.March := '0';
                                    SuppPayRec.April := '0';
                                    SuppPayRec.May := '0';
                                    SuppPayRec.June := format("Accept Value");
                                    SuppPayRec.July := '0';
                                    SuppPayRec.August := '0';
                                    SuppPayRec.September := '0';
                                    SuppPayRec.October := '0';
                                    SuppPayRec.November := '0';
                                    SuppPayRec.December := '0';
                                end;
                            7:
                                begin
                                    SuppPayRec.January := '0';
                                    SuppPayRec.February := '0';
                                    SuppPayRec.March := '0';
                                    SuppPayRec.April := '0';
                                    SuppPayRec.May := '0';
                                    SuppPayRec.June := '0';
                                    SuppPayRec.July := format("Accept Value");
                                    SuppPayRec.August := '0';
                                    SuppPayRec.September := '0';
                                    SuppPayRec.October := '0';
                                    SuppPayRec.November := '0';
                                    SuppPayRec.December := '0';
                                end;
                            8:
                                begin
                                    SuppPayRec.January := '0';
                                    SuppPayRec.February := '0';
                                    SuppPayRec.March := '0';
                                    SuppPayRec.April := '0';
                                    SuppPayRec.May := '0';
                                    SuppPayRec.June := '0';
                                    SuppPayRec.July := '0';
                                    SuppPayRec.August := format("Accept Value");
                                    SuppPayRec.September := '0';
                                    SuppPayRec.October := '0';
                                    SuppPayRec.November := '0';
                                    SuppPayRec.December := '0';
                                end;
                            9:
                                begin
                                    SuppPayRec.January := '0';
                                    SuppPayRec.February := '0';
                                    SuppPayRec.March := '0';
                                    SuppPayRec.April := '0';
                                    SuppPayRec.May := '0';
                                    SuppPayRec.June := '0';
                                    SuppPayRec.July := '0';
                                    SuppPayRec.August := '0';
                                    SuppPayRec.September := format("Accept Value");
                                    SuppPayRec.October := '0';
                                    SuppPayRec.November := '0';
                                    SuppPayRec.December := '0';
                                end;
                            10:
                                begin
                                    SuppPayRec.January := '0';
                                    SuppPayRec.February := '0';
                                    SuppPayRec.March := '0';
                                    SuppPayRec.April := '0';
                                    SuppPayRec.May := '0';
                                    SuppPayRec.June := '0';
                                    SuppPayRec.July := '0';
                                    SuppPayRec.August := '0';
                                    SuppPayRec.September := '0';
                                    SuppPayRec.October := format("Accept Value");
                                    SuppPayRec.November := '0';
                                    SuppPayRec.December := '0';
                                end;
                            11:
                                begin
                                    SuppPayRec.January := '0';
                                    SuppPayRec.February := '0';
                                    SuppPayRec.March := '0';
                                    SuppPayRec.April := '0';
                                    SuppPayRec.May := '0';
                                    SuppPayRec.June := '0';
                                    SuppPayRec.July := '0';
                                    SuppPayRec.August := '0';
                                    SuppPayRec.September := '0';
                                    SuppPayRec.October := '0';
                                    SuppPayRec.November := format("Accept Value");
                                    SuppPayRec.December := '0';
                                end;
                            12:
                                begin
                                    SuppPayRec.January := '0';
                                    SuppPayRec.February := '0';
                                    SuppPayRec.March := '0';
                                    SuppPayRec.April := '0';
                                    SuppPayRec.May := '0';
                                    SuppPayRec.June := '0';
                                    SuppPayRec.July := '0';
                                    SuppPayRec.August := '0';
                                    SuppPayRec.September := '0';
                                    SuppPayRec.October := '0';
                                    SuppPayRec.November := '0';
                                    SuppPayRec.December := format("Accept Value");
                                end;
                        end;

                        SuppPayRec.Insert();
                    end;


                    //Get Worksheet line no
                    NavAppSetupRec.Reset();
                    NavAppSetupRec.FindSet();

                    B2BLCRec.Reset();
                    B2BLCRec.SetRange("B2B LC No", "B2BLC No");
                    B2BLCRec.FindSet();

                    //Insert into Payment journal
                    //Get max line no
                    GenJournalRec.Reset();
                    GenJournalRec.SetRange("Journal Template Name", NavAppSetupRec."Pay. Gen. Jrn. Template Name");
                    GenJournalRec.SetRange("Journal Batch Name", NavAppSetupRec."Pay. Gen. Jrn. Batch Name");

                    if GenJournalRec.FindLast() then
                        LineNo := GenJournalRec."Line No.";


                    LineNo += 100;
                    GenJournalRec.Init();
                    GenJournalRec."Journal Template Name" := NavAppSetupRec."Pay. Gen. Jrn. Template Name";
                    GenJournalRec."Journal Batch Name" := NavAppSetupRec."Pay. Gen. Jrn. Batch Name";
                    GenJournalRec."Line No." := LineNo;
                    GenJournalRec.Validate("Account Type", GenJournalRec."Account Type"::Customer);
                    //GenJournalRec.Validate("Account No.", NavAppSetupRec."Account No");
                    GenJournalRec.Validate("Bal. Account Type", GenJournalRec."Bal. Account Type"::"Bank Account");
                    //GenJournalRec.Validate("Bal. Account No.", NavAppSetupRec."Bal Account No");
                    GenJournalRec."Document Type" := GenJournalRec."Document Type"::Payment;
                    GenJournalRec."Document No." := "AccNo.";
                    GenJournalRec."Document Date" := WorkDate();
                    GenJournalRec.Validate(Amount, "Bank Amount");
                    GenJournalRec."Posting Date" := WorkDate();
                    GenJournalRec.Description := 'Acceptance for B2B LC :' + "B2BLC No";
                    GenJournalRec."Expiration Date" := "Maturity Date";
                    GenJournalRec."Source Code" := 'PAYMENTJNL';
                    GenJournalRec."LC/Contract No." := B2BLCRec."LC/Contract No.";
                    GenJournalRec.Insert();

                    CurrPage.Update();
                    PayJrnlPage.Run();

                end;
            }

            action("Unapprove")
            {
                ApplicationArea = all;
                Image = UnApply;
                Caption = 'Un-approve';

                trigger OnAction()
                var
                begin
                    Approved := false;
                    ApproveDate := 0D;
                    CurrPage.Update();
                end;
            }
        }
    }
}