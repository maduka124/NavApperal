page 50763 "Bank Reference Card"
{
    PageType = Card;
    SourceTable = BankReferenceHeader;
    Caption = 'Export Bank Reference';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("BankRefNo."; "BankRefNo.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        SalesInvRec: Record "Sales Invoice Header";
                    begin
                        SalesInvRec.Reset();

                        if SalesInvRec.FindSet() then begin
                            repeat
                                SalesInvRec.BankRefNo := "No.";
                                SalesInvRec.Modify();
                            until SalesInvRec.Next() = 0;
                        end;
                    end;
                }

                field("Reference Date"; "Reference Date")
                {
                    ApplicationArea = All;
                }

                field(AirwayBillNo; AirwayBillNo)
                {
                    ApplicationArea = All;
                    Caption = 'Airway Bill No';
                }

                field("Airway Bill Date"; "Airway Bill Date")
                {
                    ApplicationArea = All;
                }

                field("Maturity Date"; "Maturity Date")
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
            }

            group(" ")
            {
                part("Bank Ref Invoice ListPart1"; "Bank Ref Invoice ListPart1")
                {
                    ApplicationArea = All;
                    Caption = 'Available Invoices';
                    SubPageLink = BankRefNo = FIELD("No.");
                }

                part("Bank Ref Invoice ListPart2"; "Bank Ref Invoice ListPart2")
                {
                    ApplicationArea = All;
                    Caption = 'Selected Invoices';
                    SubPageLink = "No." = FIELD("No.");
                }
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."BankRef Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        BankRefeInvRec: Record BankReferenceInvoice;
    begin
        BankRefeInvRec.SetRange("No.", "No.");
        BankRefeInvRec.DeleteAll();
    end;
}