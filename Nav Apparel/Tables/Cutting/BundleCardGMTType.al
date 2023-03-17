table 51264 BundleCardGMTType
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Garment Part Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Description"; Text[200])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "Garment Part Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;



}