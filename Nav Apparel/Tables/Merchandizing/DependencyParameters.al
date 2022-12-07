
table 50905 "Dependency Parameters"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Dependency Parameters";
    DrillDownPageId = "Dependency Parameters";

    fields
    {
        field(71012581; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(71012582; "Dependency Group No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Dependency Group"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dependency Group"."Dependency Group";
            ValidateTableRelation = false;
        }

        field(71012584; "Action Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Action Type"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Action Type"."Action Type";
            ValidateTableRelation = false;
        }

        field(71012586; "Action Description"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Gap Days"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012588; "Department No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Department"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Department"."Department Name";
            ValidateTableRelation = false;
        }

        field(71012590; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "MK Critical"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "Action User"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }

        field(71012593; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012594; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012595; "Secondary UserID"; Code[20])
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
