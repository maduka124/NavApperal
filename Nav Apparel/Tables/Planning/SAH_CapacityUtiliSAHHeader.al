table 50877 SAH_CapacityUtiliSAHHeader
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No"; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = YearTable.Year;
        }

        field(3; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }

        key(SK; Year)
        {

        }
    }
}