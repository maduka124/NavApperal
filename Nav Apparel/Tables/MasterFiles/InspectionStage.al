
table 51097 InspectionStage
{
    DataClassification = ToBeClassified;
    LookupPageId = "Inspection Stage List";
    DrillDownPageId = "Inspection Stage List";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Inspection Stage"; text[50])
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
        fieldgroup(DropDown; "No.", "Inspection Stage")
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
        FabricInsRec: Record FabricInspection;
    begin
        //Check for Exsistance
        FabricInsRec.Reset();
        FabricInsRec.SetRange("Inspection Stage No.", "No.");
        if FabricInsRec.FindSet() then
            Error('Inspection Stage : %1 already used in operations. Cannot delete.', "Inspection Stage");
    end;

    trigger OnRename()
    begin

    end;

}
