page 50771 "Bank Ref Collection ListPart"
{
    PageType = ListPart;
    SourceTable = BankRefCollectionLine;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    SourceTableView = sorting("BankRefNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
                    Caption = 'AirWay Bill No';
                }

                field("Airway Bill Date"; "Airway Bill Date")
                {
                    ApplicationArea = All;
                }

                field("Maturity Date"; "Maturity Date")
                {
                    ApplicationArea = All;
                }

                field("Release Date"; "Release Date")
                {
                    ApplicationArea = All;
                }

                field("Exchange Rate"; "Exchange Rate")
                {
                    ApplicationArea = All;
                }


                field("Invoice No"; "Invoice No")
                {
                    ApplicationArea = All;
                }

                field("Invoice Date"; "Invoice Date")
                {
                    ApplicationArea = All;
                }

                field("Invoice Amount"; "Invoice Amount")
                {
                    ApplicationArea = All;
                }

                field("Release Amount"; "Release Amount")
                {
                    ApplicationArea = All;
                }

                field("Margin A/C Amount"; "Margin A/C Amount")
                {
                    ApplicationArea = All;
                }

                field("FC A/C Amount"; "FC A/C Amount")
                {
                    ApplicationArea = All;
                }

                field("Current A/C Amount"; "Current A/C Amount")
                {
                    ApplicationArea = All;
                }

                field("Bank Charges"; "Bank Charges")
                {
                    ApplicationArea = All;
                }

                field(Tax; Tax)
                {
                    ApplicationArea = All;
                }

                field("Currier Charges"; "Currier Charges")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}