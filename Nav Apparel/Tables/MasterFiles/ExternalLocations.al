
table 50788 ExternalLocations
{
    DataClassification = ToBeClassified;
    LookupPageId = ExternalLocationsList;
    DrillDownPageId = ExternalLocationsList;

    fields
    {
        field(71012581; "Location Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Location Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

         field(71012585; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Location Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Location Code", "Location Name")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}
