tableextension 50910 "Gen. Jnl. Extension" extends "Gen. Journal Line"
{
    fields
    {
        //Done By Sachith on 03/04/23(length increase 20 to 200)
        field(50001; "LC/Contract No."; Code[200])
        {
        }

        field(50002; "SupplierNo"; Code[20])
        {
        }

        field(50003; "SupplierName"; Text[200])
        {
        }

        field(50004; "B2BLC No"; Code[20])
        {
        }

        field(50005; "Invoice No"; Code[50])
        {
        }

        field(50006; "BankRefNo"; Code[50])
        {
        }

        field(50007; "AccNo."; Code[20])
        {
        }
    }
}

