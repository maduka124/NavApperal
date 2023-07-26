
table 51229 ServiceScheduleLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "LineNo."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Part No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Part Name"; text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Unit N0."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }

        field(6; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(7; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Factory No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Factory Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "LineNo.")
        {
            Clustered = true;
        }
    }
}
