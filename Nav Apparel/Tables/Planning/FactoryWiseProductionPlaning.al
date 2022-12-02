table 50858 FactWiseProductPlaningHdrtbale
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Factory; Text[50])
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

        field(5; "No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }

    keys
    {
        key(PK; "No", Factory)
        {
            Clustered = true;
        }
    }
}