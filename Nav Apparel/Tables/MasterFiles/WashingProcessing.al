table 51440 WashingProcessing
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Processing Code"; Code[200])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Processing Name"; Code[200])
        {
            DataClassification = ToBeClassified;
        }

        field(3; SMV; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(4; Seq; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK1; "Processing Code")
        {
            Clustered = true;
        }
    }
}