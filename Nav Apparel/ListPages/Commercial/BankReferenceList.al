page 50766 "Bank Reference List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BankReferenceHeader;
    CardPageId = "Bank Reference Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }

                field("BankRefNo."; "BankRefNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Reference No';
                }

                field("Reference Date"; "Reference Date")
                {
                    ApplicationArea = All;
                }

                field(AirwayBillNo; AirwayBillNo)
                {
                    ApplicationArea = All;
                    Caption = 'Air Way Bill No';
                }

                field("Airway Bill Date"; "Airway Bill Date")
                {
                    ApplicationArea = All;
                }

                field("Maturity Date"; "Maturity Date")
                {
                    ApplicationArea = All;
                }

                field(Total; Total)
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        BankRefeInvRec: Record BankReferenceInvoice;
        SalesInvRec: Record "Sales Invoice Header";
    begin

        //Update sales invoice header recods
        BankRefeInvRec.Reset();
        BankRefeInvRec.SetRange("No.", "No.");
        if BankRefeInvRec.FindSet() then begin
            repeat
                SalesInvRec.Reset();
                SalesInvRec.SetRange("No.", BankRefeInvRec."Invoice No");
                if SalesInvRec.FindSet() then begin
                    SalesInvRec.AssignedBankRefNo := '';
                    SalesInvRec.Modify();
                end;
            until BankRefeInvRec.Next() = 0;

            //Delete Line records
            BankRefeInvRec.Delete();
        end;

    end;

}