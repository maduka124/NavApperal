
table 50904 "Dependency Group"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Dependency Group";
    DrillDownPageId = "Dependency Group";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Dependency Group"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Selected"; Boolean)
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
        fieldgroup(DropDown; "No.", "Dependency Group")
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
        DependencyRec: Record "Dependency";
        DependencyByParaRec: Record "Dependency Buyer Para";
        DependencyParaRec: Record "Dependency Parameters";
    begin

        //Check for Exsistance
        DependencyRec.Reset();
        DependencyRec.SetRange("Dependency No.", "No.");
        if DependencyRec.FindSet() then
            Error('Dependency Group : %1 already used in operations. Cannot delete.', "Dependency Group");

        DependencyByParaRec.Reset();
        DependencyByParaRec.SetRange("Dependency Group No.", "No.");
        if DependencyByParaRec.FindSet() then
            Error('Dependency Group : %1 already used in operations. Cannot delete.', "Dependency Group");

        DependencyParaRec.Reset();
        DependencyParaRec.SetRange("Dependency Group No.", "No.");
        if DependencyParaRec.FindSet() then
            Error('Dependency Group : %1 already used in operations. Cannot delete.', "Dependency Group");

    end;

    trigger OnRename()
    begin

    end;

}
