table 51255 "Buyer Style PO Search GRN"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "GRN No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(3; Supplier; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(4; Location; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Seq No"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK1; "Seq No")
        {
            Clustered = true;
        }
    }
}