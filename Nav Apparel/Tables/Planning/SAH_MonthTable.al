table 50875 MonthTable
{
    DataClassification = CustomerContent;
    DrillDownPageId = MonthList;
    LookupPageId = MonthList;

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

        key(SK; "Month No")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Month No", "Month Name")
        {

        }
    }
}