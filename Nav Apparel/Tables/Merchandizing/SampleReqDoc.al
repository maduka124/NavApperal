
table 71012718 "Sample Requsition Doc"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Line No."; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(71012583; "Doc Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Doc Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Upload Document Type"."Doc Name";
            ValidateTableRelation = false;
        }

        field(71012585; "Path"; Blob)
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "FileType"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "View"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Created User"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Doc Type No.", "Doc Type Name")
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
