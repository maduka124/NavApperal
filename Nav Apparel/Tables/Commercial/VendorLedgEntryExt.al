tableextension 51191 "VendorLedgEntryExt" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50001; "LC/Contract No."; Code[200])
        {
        }

        field(50002; "AccNo."; Code[20])
        {
        }

        field(50003; "B2BLC No"; Code[20])
        {
        }

        field(50004; "Cheque Printed"; Boolean)
        {
            Caption = 'Cheque Printed';
            DataClassification = ToBeClassified;
        }
    }
}

