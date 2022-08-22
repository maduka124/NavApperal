
table 71012642 "Special Operation"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Special Operation";
    DrillDownPageId = "Special Operation";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "SpecialOperation Name"; text[50])
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

        field(71012585; "Selected"; Boolean)
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
        fieldgroup(DropDown; "No.", "SpecialOperation Name")
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
    var
        StyleRec: Record "Special Operation Style";
    begin
        //Check for Exsistance
        StyleRec.Reset();
        StyleRec.SetRange("No.", "No.");
        if StyleRec.FindSet() then
            Error('Special Operation : %1 already used in Styles. Cannot delete.', "SpecialOperation Name");
    end;

    trigger OnRename()
    begin

    end;

}