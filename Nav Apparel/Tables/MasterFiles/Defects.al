
table 51091 "Defects"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Defects List";
    DrillDownPageId = "Defects List";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Defects"; text[50])
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
        fieldgroup(DropDown; "No.", "Defects")
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
        DefectsRec: Record FabricInspectionLine1;
    begin

        //Check for Exsistance
        DefectsRec.Reset();
        DefectsRec.SetRange("DefectsNo.", "No.");
        if DefectsRec.FindSet() then
            Error(' Defect : %1 already used in operations. Cannot delete.', Defects);

    end;

    trigger OnRename()
    begin

    end;

}
