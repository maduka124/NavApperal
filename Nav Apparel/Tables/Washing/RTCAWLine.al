table 50684 RTCAWLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(3; Item; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = IntermediateTable."FG Item Name" where(No = field("Req No"), "Line No" = field("Header Line No "), "Split No" = field("Split No"));
            ValidateTableRelation = false;
        }

        field(4; UOM; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; Qty; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Header Line No "; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Split No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(14; ItemCode; code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Pk; "No.", "Req No", "Split No", "Line No")
        {
            Clustered = true;
        }
    }
}