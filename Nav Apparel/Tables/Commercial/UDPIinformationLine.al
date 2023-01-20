table 51210 UDPIinformationLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Suplier No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; Supplier; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Main Category No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Main Category"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Item Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Order Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; Value; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Order Qty1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "BBLC No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK1; "No.", "Line No")
        {
            Clustered = true;
        }
    }
}