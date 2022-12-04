page 50770 "Bank Ref Collection Card"
{
    PageType = Card;
    SourceTable = BankRefCollectionHeader;
    Caption = 'Export Bank Ref. Collection';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("BankRefNo."; rec."BankRefNo.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Bank Reference No';

                    trigger OnValidate()
                    var
                        BankRefCollLineRec: Record BankRefCollectionLine;
                        BankRefHeaderRec: Record BankReferenceHeader;
                        BankRefInvRec: Record BankReferenceInvoice;
                        LineNo: Integer;
                    begin

                        BankRefCollLineRec.Reset();
                        BankRefCollLineRec.SetRange("BankRefNo.", rec."BankRefNo.");

                        if not BankRefCollLineRec.FindSet() then begin

                            BankRefHeaderRec.Reset();
                            BankRefHeaderRec.SetRange("BankRefNo.", rec."BankRefNo.");
                            BankRefHeaderRec.FindSet();

                            BankRefInvRec.Reset();
                            BankRefInvRec.SetRange(BankRefNo, rec."BankRefNo.");
                            if BankRefInvRec.FindSet() then
                                repeat
                                    LineNo += 1;
                                    BankRefCollLineRec.Init();
                                    BankRefCollLineRec."BankRefNo." := rec."BankRefNo.";
                                    BankRefCollLineRec."Airway Bill Date" := BankRefHeaderRec."Airway Bill Date";
                                    BankRefCollLineRec.AirwayBillNo := BankRefHeaderRec.AirwayBillNo;
                                    BankRefCollLineRec."Created User" := UserId;
                                    BankRefCollLineRec."Created Date" := WorkDate();
                                    BankRefCollLineRec."Invoice Amount" := BankRefInvRec."Ship Value";
                                    BankRefCollLineRec."Invoice Date" := BankRefInvRec."Invoice Date";
                                    BankRefCollLineRec."Invoice No" := BankRefInvRec."Invoice No";
                                    BankRefCollLineRec."LineNo." := LineNo;
                                    BankRefCollLineRec."Maturity Date" := BankRefHeaderRec."Maturity Date";
                                    BankRefCollLineRec."Reference Date" := BankRefHeaderRec."Reference Date";
                                    BankRefCollLineRec.Insert();
                                until BankRefInvRec.Next() = 0;
                        end;

                        CurrPage.Update();
                    end;
                }

                field("Release Amount"; rec."Release Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin
                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."Release Amount" := (rec."Release Amount" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }

                field("Release Date"; rec."Release Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                    begin
                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            BankRefeCollRec.ModifyAll("Release Date", rec."Release Date");

                        CurrPage.Update();
                    end;
                }

                field("Exchange Rate"; rec."Exchange Rate")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                    begin
                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            BankRefeCollRec.ModifyAll("Exchange Rate",rec."Exchange Rate");

                        CurrPage.Update();
                    end;
                }

                field("Margin A/C Amount"; rec."Margin A/C Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin
                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."Margin A/C Amount" := (rec."Margin A/C Amount" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }

                field("Bank Charges"; rec."Bank Charges")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin
                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."Bank Charges" := (rec."Bank Charges" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }

                field(Tax; rec.Tax)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin
                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."Tax" := (rec."Tax" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }

                field("Currier Charges"; rec."Currier Charges")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin
                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."Currier Charges" := (rec."Currier Charges" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }

                field("FC A/C Amount"; rec."FC A/C Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin
                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."FC A/C Amount" := (rec."FC A/C Amount" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }

                field("Current A/C Amount"; rec."Current A/C Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        BankRefeCollRec: Record BankRefCollectionLine;
                        InvoiceTotal: Decimal;
                    begin
                        InvoiceTotal := get_InvoiceTotal();

                        BankRefeCollRec.Reset();
                        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
                        if BankRefeCollRec.FindSet() then
                            repeat
                                BankRefeCollRec."Current A/C Amount" := (rec."Current A/C Amount" / InvoiceTotal) * BankRefeCollRec."Invoice Amount";
                                BankRefeCollRec.Modify();
                            until BankRefeCollRec.Next() = 0;

                        CurrPage.Update();
                    end;
                }
            }

            group(" ")
            {
                part("Bank Ref Collection ListPart"; "Bank Ref Collection ListPart")
                {
                    ApplicationArea = All;
                    Caption = 'Invoices';
                    SubPageLink = "BankRefNo." = FIELD("BankRefNo.");
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    var
        BankRefeCollRec: Record BankRefCollectionLine;
    begin
        BankRefeCollRec.Reset();
        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
        if BankRefeCollRec.FindSet() then
            BankRefeCollRec.Delete();
    end;


    procedure get_InvoiceTotal(): Decimal
    var
        BankRefeCollRec: Record BankRefCollectionLine;
        InvoiceTotal: Decimal;
    begin

        BankRefeCollRec.Reset();
        BankRefeCollRec.SetRange("BankRefNo.", rec."BankRefNo.");
        if BankRefeCollRec.FindSet() then
            repeat
                InvoiceTotal += BankRefeCollRec."Invoice Amount";
            until BankRefeCollRec.Next() = 0;
        exit(InvoiceTotal);
    end;


}