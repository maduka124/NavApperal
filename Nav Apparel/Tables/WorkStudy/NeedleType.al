
table 50448 NeedleType
{
    DataClassification = ToBeClassified;
    LookupPageId = "Needle Type List";
    DrillDownPageId = "Needle Type List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Needle Description"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Secondary UserID"; Code[20])
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
        fieldgroup(DropDown; "No.", "Needle Description")
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
        MachineRec: Record "Machine Master";
    begin

        //Check for Exsistance
        MachineRec.Reset();
        MachineRec.SetRange("Needle Type No.", "No.");
        if MachineRec.FindSet() then
            Error('Needle Type : %1 already used in Machine Master. Cannot delete.', "Needle Description");

    end;

    trigger OnRename()
    begin

    end;

}
