table 50856 YearTable
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Year)
        {
            Clustered = true;
        }
    }
}