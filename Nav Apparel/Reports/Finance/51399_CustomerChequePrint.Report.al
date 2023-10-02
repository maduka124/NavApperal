report 51399 "Customer Cheque Print"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    // RDLCLayout = 'Report_Layouts/Print Cheque.rdl';
    RDLCLayout = 'Report_Layouts/AVCheck.rdl';

    UseSystemPrinter = false;

    dataset
    {
        dataitem("Gen. Journal Line"; "Gen. Journal Line")
        {
            DataItemTableView = SORTING("Document No.")
                                WHERE(Amount = FILTER(> 0));
            RequestFilterFields = "Document No.";
            column(AccPayOnly; AccPayOnly)
            {
            }
            column(FORMAT__Document_Date__; FORMAT("Document Date"))
            {
            }
            column(Payee; "Message to Recipient")
            {
            }
            column(NumberText_1_; NumberText[1])
            {
            }
            column(NumberText_2_; NumberText[2])
            {
            }
            column(NumberText_3_; NumberText[3])
            {
            }
            column(DATE2DMY__Document_Date__1_; DATE2DMY("Document Date", 1))
            {
            }
            column(DATE2DMY__Document_Date__2_; DATE2DMY("Document Date", 2))
            {
                AutoFormatType = 0;
                //DecimalPlaces = 2 : 0;
            }
            column(DVAmount; DVAmount)
            {
            }
            column(TVDate; TVDate)
            {
            }
            column(USERID; USERID)
            {
            }
            column(Gen__Journal_Line_Document_No_; "Document No.")
            {
            }
            column(D_1; D1)
            {
            }
            column(D_2; D2)
            {
            }
            column(M_1; M1)
            {
            }
            column(M_2; M2)
            {
            }
            column(Y_1; Y1)
            {
            }
            column(Y_2; Y2)
            {
            }
            column(Y_3; Y3)
            {
            }
            column(Y_4; Y4)
            {
            }
            column(Accpay_Text; AccPayText)
            {
            }
            column(AccPay_Line; AccPayLine)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF AccPayOnly THEN BEGIN
                    AccPayText := 'A/C Payee Only.';
                    AccPayLine := '-------------------------';
                END;
                IF TVVendor = '' THEN
                    RVGenJnl.SETRANGE("Journal Batch Name", "Journal Batch Name");
                RVGenJnl.SETRANGE("Document No.", "Document No.");
                IF RVGenJnl.FIND('-') THEN
                    REPEAT
                        TVVendor := RVGenJnl.Description;
                    UNTIL RVGenJnl.NEXT = 0;

                // RVCustomer.SETRANGE("No.", "Account No.");
                // IF RVCustomer.FIND('-') THEN
                //     TVVendor := RVCustomer."SVAT Reg No.";

                // RVVendor.SETRANGE("No.", "Account No.");
                // IF RVVendor.FIND('-') OR (RVVendor."No." <> 'S059R') THEN
                //     TVVendor := RVVendor.Category;
                // IF ("Account Type" = "Account Type"::"G/L Account") OR (RVVendor."No." = 'S059R') THEN
                //     TVVendor := "Gen. Journal Line"."To City";

                IF Amount < 0 THEN
                    Amount := Amount * -1;

                DVAmount := DVAmount + Amount;//-"WHT Amount");

                TVDate := COPYSTR(FORMAT("Document Date", 2, '<Day,2>'), 1, 1) + ' ' +
                          COPYSTR(FORMAT("Document Date", 2, '<Day,2>'), 2, 1) + '  ' +
                          COPYSTR(FORMAT("Document Date", 2, '<Month,2>'), 1, 1) + ' ' +
                          COPYSTR(FORMAT("Document Date", 2, '<Month,2>'), 2, 1) + '       ' +
                          COPYSTR(FORMAT("Document Date", 2, '<Year,2>'), 1, 1) + ' ' +
                          COPYSTR(FORMAT("Document Date", 2, '<Year,2>'), 2, 1);

                D1 := COPYSTR(FORMAT("Document Date", 2, '<Day,2>'), 1, 1);
                D2 := COPYSTR(FORMAT("Document Date", 2, '<Day,2>'), 2, 1);
                M1 := COPYSTR(FORMAT("Document Date", 2, '<Month,2>'), 1, 1);
                M2 := COPYSTR(FORMAT("Document Date", 2, '<Month,2>'), 2, 1);
                Y1 := COPYSTR(FORMAT("Document Date", 0, '<Year4>'), 1, 1);
                Y2 := COPYSTR(FORMAT("Document Date", 0, '<Year4>'), 2, 1);
                Y3 := COPYSTR(FORMAT("Document Date", 0, '<Year4>'), 3, 1);
                Y4 := COPYSTR(FORMAT("Document Date", 0, '<Year4>'), 4, 1);

                RPTVCheck.InitTextVariable;
                RPTVCheck.FormatNoTextCustomized(NumberText, DVAmount, "Gen. Journal Line"."Currency Code" + ' ' + '');

                // if NumberText[2] = '' then
                //     NumberText[1] += ' ONLY';

                // if NumberText[3] = '' then
                //     NumberText[2] += ' ONLY';
                //NumberText[1] := NumberText[1] + NumberText[2] + NumberText[3];

                // IF "Account Type" = "Account Type"::Customer THEN BEGIN
                //     IF CusRec.GET("Account No.") THEN;
                //     TVVendor := CusRec."SVAT Reg No.";
                // END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(AccPayOnly; AccPayOnly)
                    {
                        ApplicationArea = all;
                        Caption = 'Account Payee Only';
                    }
                }
            }
        }

        actions
        {
        }
    }
    trigger OnPostReport()
    begin
        if not CurrReport.Preview then begin
            GenJurnal."Cheque printed" := true;
            GenJurnal.Modify();
        end;
    end;

    var
        GenJurnal: Record "Gen. Journal Line";
        RVCustomer: Record Customer;
        TVName: Text[50];
        // RPTVCheck: Report Check;
        RPTVCheck: Report "Check-Customized";
        NumberText: array[3] of Text[50];
        IVDay: Integer;
        TVDate: Text[60];
        RVGenJnl: Record "Gen. Journal Line";
        TVVendor: Text[60];
        RVVendor: Record Vendor;
        DVAmount: Decimal;
        D1: Code[1];
        D2: Code[1];
        M1: Code[1];
        M2: Code[1];
        Y1: Code[1];
        Y2: Code[1];
        Y3: Code[1];
        Y4: Code[1];
        AccPayOnly: Boolean;
        AccPayText: Text[30];
        AccPayLine: Text[30];
        CusRec: Record Customer;
}

