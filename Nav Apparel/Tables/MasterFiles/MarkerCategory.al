
table 51102 MarkerCategory
{
    DataClassification = ToBeClassified;
    LookupPageId = "Marker Category List";
    DrillDownPageId = "Marker Category List";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Marker Category"; text[50])
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
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Marker Category")
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
        SewingJobCreRec: Record SewingJobCreation;
    begin
        //Check for Exsistance
        SewingJobCreRec.Reset();
        SewingJobCreRec.SetRange(MarkerCatNo, "No.");
        if SewingJobCreRec.FindSet() then
            Error('Marker Category : %1 already used in operations. Cannot delete.', "Marker Category");
    end;

    trigger OnRename()
    begin

    end;

}
