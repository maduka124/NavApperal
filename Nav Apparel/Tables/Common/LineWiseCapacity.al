
table 51345 LineWiseCapacity
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Factory"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Resource No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Resource Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Month No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Month"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Capacity Pcs"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Planned Pcs"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Achieved Pcs"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Diff."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Record Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
