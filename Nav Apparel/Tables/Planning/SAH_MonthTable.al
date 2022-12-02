table 50875 MonthTable
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Month No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Month Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Month Name")
        {
            Clustered = true;
        }
    }

    // fieldgroups
    // {
    //     fieldgroup(DropDown; "Month Name")
    //     {

    //     }
    // }
}