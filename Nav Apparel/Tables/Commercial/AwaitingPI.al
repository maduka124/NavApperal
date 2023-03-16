table 51182 AwaitingPIs
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Contract No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "PI Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "PI Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "PI No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Supplier Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Supplier No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "PI No New"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Contract No", "PI No")
        {
            Clustered = true;
        }
    }
}