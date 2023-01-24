table 51216 Description
{
    DataClassification = ToBeClassified;
    LookupPageId = "Description List";
    DrillDownPageId = "Description List";

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(2; Description; Text[500])
        {
            DataClassification = ToBeClassified;

        }

        field(3; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Created Date"; Date)
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
    }


    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}