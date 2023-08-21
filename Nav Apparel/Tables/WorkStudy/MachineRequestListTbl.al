table 51360 MachineRequestListTble
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Style No"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(2; Line; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(3; Buyer; Code[200])
        {
            DataClassification = ToBeClassified;
        }

        field(4; Brand; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Machine Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(6; Qty; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(7; Factory; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "seq No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Style Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Order Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Machine No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Garment Type"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Machine Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(14; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Style No", Line)
        {
            Clustered = true;
        }
    }

}