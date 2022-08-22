page 50550 "Paid Chart - Approved"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AcceptanceHeader;
    SourceTableView = where(Approved = filter(true), Paid = filter(true));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    Caption = 'Paid Chart';

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

                field(PaidDate; PaidDate)
                {
                    ApplicationArea = All;
                    Caption = 'Paid Date';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action("Un Paid")
            {
                ApplicationArea = all;
                Image = UnApply;

                trigger OnAction()
                var
                    SuppPayRec: Record SupplierPayments;
                    Y: Integer;
                    M: Integer;
                    TempValue1: Decimal;
                    TempValue2: Decimal;
                begin
                    Paid := false;
                    PaidDate := 0D;

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
                                    TempValue2 := TempValue1 - "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            2:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.February);
                                    TempValue2 := TempValue1 - "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            3:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.March);
                                    TempValue2 := TempValue1 - "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            4:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.April);
                                    TempValue2 := TempValue1 - "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            5:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.May);
                                    TempValue2 := TempValue1 - "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            6:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.June);
                                    TempValue2 := TempValue1 - "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            7:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.July);
                                    TempValue2 := TempValue1 - "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            8:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.August);
                                    TempValue2 := TempValue1 - "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            9:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.September);
                                    TempValue2 := TempValue1 - "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            10:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.October);
                                    TempValue2 := TempValue1 - "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            11:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.November);
                                    TempValue2 := TempValue1 - "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                            12:
                                begin
                                    Evaluate(TempValue1, SuppPayRec.December);
                                    TempValue2 := TempValue1 - "Accept Value";
                                    SuppPayRec.January := format(TempValue2);
                                end;
                        end;

                        SuppPayRec.Modify();

                    end;

                    CurrPage.Update();
                end;

            }
        }
    }
}