table 51284 GarmentPartsBundleCard2Right
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

        field(3; Description; Text[200])
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
        key(PK; BundleCardNo, "No.")
        {
            Clustered = true;
        }

        key(Sk; Description)
        { }
    }
}