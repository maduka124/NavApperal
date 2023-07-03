
table 51341 GroupWiseCapacity
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Month No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Month"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Capacity Pcs"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Planned Pcs"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Achieved Pcs"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Diff."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Avg SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Finishing"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Ship Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Ship Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Avg Plan Mnts"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Avg Prod. Mnts"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Plan Hit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Plan Eff."; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Actual Eff."; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Record Type"; Code[20])
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
