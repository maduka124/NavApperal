
table 51326 BOMLineAutoGenPlWksht
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Item No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
