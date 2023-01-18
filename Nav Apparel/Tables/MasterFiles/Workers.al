
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
            // Done By Sachith On 18/01/23
            TableRelation = UserRoles.Description;
            ValidateTableRelation = false;
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

        field(7; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        // Done By Sachith on 18/01/23
        field(8; "Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."Department Name";
            ValidateTableRelation = false;
        }

        // Done By Sachith on 18/01/23
        field(9; "Department No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        // Done By Sachith on 18/01/23
        field(10; "User Role Code"; Code[20])
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
