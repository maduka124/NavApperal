
table 50891 "BOM Estima Cost Line Revision"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "No."; Code[20])   //This is Cost Sheet No
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Master Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Master Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Doz Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "BOM No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Revision"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", Revision, "Master Category No.")
        {
            Clustered = true;
        }
    }
}
