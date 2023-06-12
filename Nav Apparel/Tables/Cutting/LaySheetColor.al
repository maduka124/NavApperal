
table 51319 LaySheetColor
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "LaySheetNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Color No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Color"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "LaySheetNo.", "Color")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Color)
        {

        }
    }
}
