page 50549 "Payable Chart - Approved"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AcceptanceHeader;
    SourceTableView = where(Approved = filter(true), Paid = filter(false));
    Editable = false;
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
                }

                field("B2BLC No"; "B2BLC No")
                {
                    ApplicationArea = All;
                }

                field("Suppler Name"; "Suppler Name")
                {
                    ApplicationArea = All;
                    Caption = 'Suppler';
                }

                field("Accept Value"; "Accept Value")
                {
                    ApplicationArea = All;
                }

                field("Accept Date"; "Accept Date")
                {
                    ApplicationArea = All;
                }

                field("Acceptance S/N"; "Acceptance S/N")
                {
                    ApplicationArea = All;
                }

                field("Maturity Date"; "Maturity Date")
                {
                    ApplicationArea = All;
                }

                field("Payment Mode"; "Payment Mode")
                {
                    ApplicationArea = All;
                }

                field(Approved; Approved)
                {
                    ApplicationArea = All;
                    Caption = 'Approved Status';
                }

                field(ApproveDate; ApproveDate)
                {
                    ApplicationArea = All;
                    Caption = 'Approved Date';
                }

                field(Paid; Paid)
                {
                    ApplicationArea = All;
                    Caption = 'Paid Status';
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
                    Y: Integer;
                    M: Integer;
                    TempValue1: Decimal;
                    TempValue2: Decimal;
                begin
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

                    CurrPage.Update();

                end;
            }

            action("Unapprove")
            {
                ApplicationArea = all;
                Image = UnApply;
                Caption = 'Unapprove';

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