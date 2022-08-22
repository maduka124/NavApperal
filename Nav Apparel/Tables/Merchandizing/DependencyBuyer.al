
table 71012701 "Dependency Buyer"
{
    DataClassification = ToBeClassified;
    //LookupPageId = 50227;
    //DrillDownPageId = 50227;

    fields
    {
        field(71012581; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Main Dependency No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Dependency No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Dependency"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Buyer No.", "Main Dependency No.", "Dependency No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Buyer No.", "Main Dependency No.", "Dependency No.", "Dependency")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}