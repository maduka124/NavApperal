table 51269 GarmentPartsBundleCard2
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; BundleCardNo; Code[20])
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