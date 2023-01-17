table 50209 UDBBLcInformation
{
    DataClassification = ToBeClassified;

    fields
    {
        field(11; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Line No"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(1; "Issue Bank"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Issue Bank No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; BBLC; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Supplier Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Supplier No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "LC Amount"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Open Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Expice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Payment Mode"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; UD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK1; No, "Line No")
        {
            Clustered = true;
        }
    }
}