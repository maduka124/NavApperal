
table 50774 "Factory CPM"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Factory CPM List";
    DrillDownPageId = "Factory CPM List";

    fields
    {
        field(1; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Factory Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name;
            ValidateTableRelation = false;
        }

        field(4; "CPM"; Decimal)
        {
            DataClassification = ToBeClassified;
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
        key(PK; "Factory Code", "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Factory Name", CPM)
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}
