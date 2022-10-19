
table 50818 ManpowBudSummary
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; LineNo; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Category Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Act Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Final Budget with Absenteesm"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Factory Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Date"; date)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", LineNo)
        {
            Clustered = true;
        }
    }
}
