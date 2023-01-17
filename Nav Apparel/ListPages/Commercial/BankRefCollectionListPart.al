page 50771 "Bank Ref Collection ListPart"
{
    PageType = ListPart;
    SourceTable = BankRefCollectionLine;
    DeleteAllowed = false;
    InsertAllowed = false;
    //ModifyAllowed = false;
    SourceTableView = sorting("BankRefNo.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
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
                    Caption = 'AirWay Bill No';
                }

                field("Airway Bill Date"; Rec."Airway Bill Date")
                {
                    ApplicationArea = All;
                }

                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = All;
                }

                field("Release Date"; Rec."Release Date")
                {
                    ApplicationArea = All;
                }

                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    ApplicationArea = All;
                }


                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = All;
                }

                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = All;
                }

                field("Invoice Amount"; Rec."Invoice Amount")
                {
                    ApplicationArea = All;
                }

                field("Release Amount"; Rec."Release Amount")
                {
                    ApplicationArea = All;
                }

                field("Margin A/C Amount"; Rec."Margin A/C Amount")
                {
                    ApplicationArea = All;
                }

                field("FC A/C Amount"; Rec."FC A/C Amount")
                {
                    ApplicationArea = All;
                }

                field("Current A/C Amount"; Rec."Current A/C Amount")
                {
                    ApplicationArea = All;
                }

                field("Bank Charges"; Rec."Bank Charges")
                {
                    ApplicationArea = All;
                }

                field(Tax; Rec.Tax)
                {
                    ApplicationArea = All;
                }

                field("Currier Charges"; Rec."Currier Charges")
                {
                    ApplicationArea = All;
                }

                field("Transferred To Cash Receipt"; rec."Transferred To Cash Receipt")
                {
                    ApplicationArea = All;
                    //Editable = false;
                }

                field("Payment Posted"; rec."Payment Posted")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
}