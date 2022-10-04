
table 50797 Workers
{
    DataClassification = ToBeClassified;
    LookupPageId = "Workers List";
    DrillDownPageId = "Workers List";

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "Worker Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Worker Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,"In Active"';
            OptionMembers = Active,"In Active";
        }

        field(5; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Worker Type", "Worker Name")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
