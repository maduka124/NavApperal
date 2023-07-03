
table 51343 FactoryWiseCapacity
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

        field(3; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Month No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Month"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Capacity Pcs"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Planned Pcs"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Achieved Pcs"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Diff."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Avg SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Plan Eff."; Decimal)
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
