table 50838 PreProductionFollowUpHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "Factory Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Factory Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created User"; Code[50])
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