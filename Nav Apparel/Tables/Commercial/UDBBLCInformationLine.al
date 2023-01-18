table 50209 UDBBLcInformation
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

        field(3; "Issue Bank No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Issue Bank"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; BBLC; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Supplier No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Supplier Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "LC Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Open Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Expice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Payment Mode No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Payment Mode"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(13; UD; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(14; BBLCValue; Decimal)
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