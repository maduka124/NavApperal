
table 50562 "StyleColor"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Color No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Color"; text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "User ID", "Color No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Color No.", Color)
        {

        }
    }
}
