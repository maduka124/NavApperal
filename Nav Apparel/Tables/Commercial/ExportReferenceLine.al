
table 51242 ExportReferenceLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Invoice No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Inv Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Fty Inv No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
