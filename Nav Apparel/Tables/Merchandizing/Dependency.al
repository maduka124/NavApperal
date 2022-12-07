
table 50901 "Dependency"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Dependency Card";
    DrillDownPageId = "Dependency Card";

    fields
    {
        field(71012581; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(71012582; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Dependency No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Dependency"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dependency Group"."Dependency Group";
            ValidateTableRelation = false;
        }

        field(71012585; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Buyer Name."; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer.Name;
            ValidateTableRelation = false;
        }

        field(71012588; "Secondary UserID"; Code[20])
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

    // fieldgroups
    // {
    //     fieldgroup(DropDown; "No.", "Action Type")
    //     {

    //     }
    // }

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
