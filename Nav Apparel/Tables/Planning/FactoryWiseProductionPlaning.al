table 50858 FactWiseProductPlaningHdrtbale
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "No"; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(5; "Factory Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name;
            ValidateTableRelation = false;
        }

        field(2; "Factory Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "From Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "To Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No")
        {
            Clustered = true;
        }
    }
}