
table 51373 StyleChangeLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SeqNo"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Resource No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; Qty; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Total; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Factory No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; SeqNo)
        {
            Clustered = true;
        }
    }
}
