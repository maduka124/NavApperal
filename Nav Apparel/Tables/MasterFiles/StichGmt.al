
table 71012645 "Stich Gmt"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Stich Gmt";
    DrillDownPageId = "Stich Gmt";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Stich Gmt Name"; text[50])
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
        fieldgroup(DropDown; "No.", "Stich Gmt Name")
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
        BOMEstRec: Record "BOM Estimate Cost";
    begin
        //Check for Exsistance
        BOMEstRec.Reset();
        BOMEstRec.SetRange("Stich Gmt", "No.");
        if BOMEstRec.FindSet() then
            Error('Stich Garment : %1 already used in operations. Cannot delete.', "Stich Gmt Name");
    end;

    trigger OnRename()
    begin

    end;

}
