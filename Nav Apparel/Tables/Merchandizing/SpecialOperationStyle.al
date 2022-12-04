
table 50933 "Special Operation Style"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Special Operation Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Style No.", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Style No.", "No.", "Special Operation Name")
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