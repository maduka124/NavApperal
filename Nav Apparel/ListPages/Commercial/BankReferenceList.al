page 50766 "Bank Reference List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BankReferenceHeader;
    CardPageId = "Bank Reference Card";
    Editable = false;
    Permissions = tabledata "Sales Invoice Header" = rm;
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }

                field("BankRefNo."; Rec."BankRefNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Reference No';
                }

                field("Reference Date"; Rec."Reference Date")
                {
                    ApplicationArea = All;
                }

                field(AirwayBillNo; Rec.AirwayBillNo)
                {
                    ApplicationArea = All;
                    Caption = 'Air Way Bill No';
                }

                field("Airway Bill Date"; Rec."Airway Bill Date")
                {
                    ApplicationArea = All;
                }

                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = All;
                }

                field(Total; Rec.Total)
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
        BankRefeInvRec.SetRange("No.", Rec."No.");
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