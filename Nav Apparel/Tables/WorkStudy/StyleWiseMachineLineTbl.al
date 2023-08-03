table 51364 StyleWiseMachineLine
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

        field(3; "Machine No"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Garment Type"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Machine Qty"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No Of Machine';
        }

        field(6; "Machine Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Style Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Record Type"; code[1])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK1; "Line No", No)
        {
            Clustered = true;
        }
    }
}