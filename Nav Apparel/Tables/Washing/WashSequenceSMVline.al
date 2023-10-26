table 51445 WashSequenceSMVLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Processing Code"; Code[200])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Processing Name"; Code[200])
        {
            DataClassification = ToBeClassified;
        }

        field(5; SMV; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; Seq; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Record Type"; code[20])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; No, "Line No")
        {
            Clustered = true;
        }
    }
}