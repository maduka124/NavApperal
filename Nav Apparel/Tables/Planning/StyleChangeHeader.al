
table 51378 StyleChangeHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SeqNo"; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
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
