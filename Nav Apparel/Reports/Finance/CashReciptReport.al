report 51439 CashReceiptReport
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Cash Receipt Voucher';
    RDLCLayout = 'Report_Layouts/Finance/CashReceiptReport.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = where("Bal. Account Type" = filter('G/L Account'), "Journal Template Name" = filter('CASH RECE'));
            RequestFilterFields = "Document No.";
            column(Document_No_; "Document No.")
            { }
            column(Posting_Date; "Posting Date")
            { }
            column(VendorName; VendorName)
            { }
            column(Description; Description)
            { }
            column(Amount; Amount)
            { }
            column(Account_No_; "Account No.")
            { }
            column(AccountHead; AccountHead)
            { }
            column(Debit_Amount; "Debit Amount")
            { }
            column(Credit_Amount; Credit2)
            { }
            column(Amount__LCY_; "Amount (LCY)")
            { }
            column(HeadAmount; HeadAmount)
            { }
            column(CompLogo; comRec.Picture)
            { }
            column(NumberText_2_; NumberText[2])
            { }
            column(NumberText_1_; NumberText[1])
            { }
            column(Account_Type; "Account Type")
            { }
            column(Type1; Type1)
            { }
            column(Type2; Type2)
            { }
            // column(BillNo; INV)
            // { }
            column(Credit2; Credit2)
            { }
            column(ExRate; ExRate)
            { }
            column(BDRate; BDRate)
            { }
            // column(BillNo; BillNo)
            // { }
            // column(Remaining_Amount; RMAmt)
            // { }
            // column(BillNo2; BillNo2)
            // { }

            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLinkReference = "Gen. Journal Line";
                DataItemLink = "Applies-to ID" = field("Document No."), "Applied Line No." = field("Line No.");
                CalcFields = "Factory Inv. No", "Remaining Amount";
                column(BillNo; "Factory Inv. No")
                { }
                column(Remaining_Amount; "Remaining Amount")
                { }
                column(BillNo2; "Document No.")
                { }
                column(ExRate2; ExRate2)
                { }
                column(BDRate2; BDRate2)
                { }


                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    if "Gen. Journal Line"."Credit Amount" <> 0 then
                        Visbool := false;

                    ExRate2 := 0;
                    if "Currency Code" <> 'USD' then begin
                        Curency.Reset();
                        Curency.SetRange("Currency Code", 'USD');
                        Curency.SetCurrentKey("Starting Date");
                        Curency.Ascending(true);
                        if Curency.FindLast() then begin
                            ExRate2 := Curency."Relational Exch. Rate Amount";
                        end;
                    end else
                        ExRate2 := 0;

                    BDRate := 0;
                    if "Currency Code" = 'USD' then begin
                        Curency.Reset();
                        Curency.SetRange("Currency Code", 'USD');
                        Curency.SetCurrentKey("Starting Date");
                        Curency.Ascending(true);
                        if Curency.FindLast() then begin
                            BDRate2 := Curency."Relational Exch. Rate Amount";
                        end;
                    end else
                        BDRate2 := 0;

                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                TotLcy: Decimal;
                VendorRec1: Record Vendor;
                EmpRec: Record Employee;
                GlRec: Record "G/L Account";
            begin
                comRec.Get;
                comRec.CalcFields(Picture);

                Credit2 := 0;
                if "Account Type" <> "Account Type"::Customer then begin
                    Credit2 := "Credit Amount";
                    ExRate2 := 0;
                    BDRate2 := 0;
                end else
                    Credit2 := 0;

                    ExRate := 0;
                    if "Currency Code" <> 'USD' then begin
                        Curency.Reset();
                        Curency.SetRange("Currency Code", 'USD');
                        Curency.SetCurrentKey("Starting Date");
                        Curency.Ascending(true);
                        if Curency.FindLast() then begin
                            ExRate := Curency."Relational Exch. Rate Amount";
                        end;
                    end else
                        ExRate := 1;

                    BDRate := 0;
                    if "Currency Code" = 'USD' then begin
                        Curency.Reset();
                        Curency.SetRange("Currency Code", 'USD');
                        Curency.SetCurrentKey("Starting Date");
                        Curency.Ascending(true);
                        if Curency.FindLast() then begin
                            BDRate := Curency."Relational Exch. Rate Amount";
                        end;
                    end else
                        BDRate := 1;
            
               
                Type1 := 1;
                Type2 := 1;
                if "Account Type" = "Account Type"::Customer then begin
                    Type1 := 0;
                end;
                if "Account Type" = "Account Type"::"Bank Account" then begin
                    Type2 := 0;
                end;



                GenJLineRec.Reset();
                GenJLineRec.SetRange("Document No.", "Document No.");
                GenJLineRec.SetRange("Account Type", GenJLineRec."Account Type"::Customer);
                if GenJLineRec.FindSet() then begin
                    VendorRec.Reset();
                    VendorRec.SetRange("No.", GenJLineRec."Account No.");
                    if VendorRec.FindSet() then begin
                        VendorName := VendorRec.Name;
                    end;
                end;

                AccountHead := '';
                if "Account Type" = "Account Type"::Customer then begin
                    VendorRec.Reset();
                    VendorRec.SetRange("No.", "Account No.");
                    if VendorRec.FindSet() then begin
                        AccountHead := VendorRec.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::"Bank Account" then begin
                    BankAcountRec.Reset();
                    BankAcountRec.SetRange("No.", "Account No.");
                    if BankAcountRec.FindSet() then begin
                        AccountHead := BankAcountRec.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::Vendor then begin
                    VendorRec1.Reset();
                    VendorRec1.SetRange("No.", "Account No.");
                    if VendorRec1.FindSet() then begin
                        AccountHead := VendorRec1.Name;
                    end;
                end;
                if "Account Type" = "Account Type"::Employee then begin
                    EmpRec.Reset();
                    EmpRec.SetRange("No.", "Account No.");
                    if EmpRec.FindSet() then begin
                        AccountHead := EmpRec."First Name";
                    end;
                end;
                if "Account Type" = "Account Type"::"G/L Account" then begin
                    GlRec.Reset();
                    GlRec.SetRange("No.", "Account No.");
                    if GlRec.FindSet() then begin
                        AccountHead := GlRec.Name;
                    end;
                end;

                GenJLineRec.Reset();
                GenJLineRec.SetRange("Document No.", "Document No.");
                GenJLineRec.SetRange("Account Type", GenJLineRec."Account Type"::"Bank Account");
                if GenJLineRec.FindSet() then begin
                    HeadAmount := GenJLineRec.Amount;
                end;

                TotLcy := 0;
                GenJLineRec.Reset();
                GenJLineRec.SetRange("Document No.", "Document No.");
                // GenJLineRec.SetRange("Account Type", GenJLineRec."Account Type"::Customer);
                if GenJLineRec.FindFirst() then begin
                    // GenJLineRec.CalcSums("Amount (LCY)");
                    TotLcy := GenJLineRec."Amount (LCY)";
                    RPTVCheck.InitTextVariable;
                    // RPTVCheck.FormatNoTextCustomized(NumberText, abs(GenJLineRec."Amount (LCY)"), GenJLineRec."Currency Code" + ' ' + '');
                    RPTVCheck.FormatNoTextCustomized(NumberText, abs(TotLcy), '' + ' ' + '');
                end;



            end;

            trigger OnPreDataItem()
            var

            begin
                // SetRange("Document No.", FilterDoc);
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                // group(GroupName)
                // {
                //     Caption = 'Filter By';
                //     // field(FilterDoc; FilterDoc)
                //     // {
                //     //     ApplicationArea = All;
                //     //     Caption = 'Document No';
                //     //     // Editable = false;

                //     // }
                // }
            }
        }
    }

    procedure Set_value(DocNo: Code[20])
    var
    begin
        FilterDoc := DocNo;
    end;

    var
        BDRate2: Decimal;
        ExRate2: Decimal;
        RMAmt: Decimal;
        BillNo2: Code[50];
        BillNo: text[50];
        CustLeRec: Record "Cust. Ledger Entry";
        Credit1: Decimal;
        Credit2: Decimal;
        Type1: Integer;
        Type2: Integer;
        INV: Text[35];
        BDRate: Decimal;
        ExRate: Decimal;
        Curency: Record "Currency Exchange Rate";
        FilterDoc: Code[20];
        BankAcountRec: Record "Bank Account";
        RPTVCheck: Report "Check-Customized";
        NumberText: array[2] of Text[100];
        comRec: Record "Company Information";
        HeadAmount: Decimal;
        AccountHead: Text[200];
        GenJLineRec: Record "Gen. Journal Line";
        VendorName: Text[200];
        VendorRec: Record Customer;
        Visbool: Boolean;
}