
table 50825 StyleWiseGRN
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "GRN No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "User ID", "Style Name", "GRN No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Style Name", "GRN No.")
        {

        }
    }
}
