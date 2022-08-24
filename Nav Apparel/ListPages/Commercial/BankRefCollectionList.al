page 50769 "Bank Ref Collection List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BankRefCollectionHeader;
    CardPageId = "Bank Ref Collection Card";
    Editable = false;

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

                field("Release Amount"; "Release Amount")
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

                field("Margin A/C Amount"; "Margin A/C Amount")
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


    trigger OnDeleteRecord(): Boolean
    var
        BankRefeCollRec: Record BankRefCollectionLine;
    begin
        BankRefeCollRec.Reset();
        BankRefeCollRec.SetRange("BankRefNo.", "BankRefNo.");
        if BankRefeCollRec.FindSet() then
            BankRefeCollRec.Delete();
    end;
}