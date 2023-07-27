
table 51229 ServiceScheduleLine    //Not using 
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Part No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Part Name"; text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Unit N0."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }

        field(4; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(5; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Factory No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Factory Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
}
