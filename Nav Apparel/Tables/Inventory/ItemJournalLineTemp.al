table 51250 ItemJournalLinetemp
{
    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Line No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Source No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Daily Consumption Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Original Requirement"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Posted requirement"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Prod. Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Prod. Order Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Daily Consumption"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
}