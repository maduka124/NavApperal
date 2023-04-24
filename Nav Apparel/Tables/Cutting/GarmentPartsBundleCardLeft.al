table 51283 GarmentPartsBundleCardLeft
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; BundleCardNo; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(3; Select; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(4; Description; Text[200])
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(6; "Created User"; Text[200])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; BundleCardNo, No)
        {
            Clustered = true;
        }

        key(SK; Description)
        {
        }
    }
}