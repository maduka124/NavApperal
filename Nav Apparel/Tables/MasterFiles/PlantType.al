
table 51127 "Plant Type"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Plant Type List";
    DrillDownPageId = "Plant Type List";

    fields
    {
        field(71012581; "Plant Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Plant Type Name"; text[50])
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
        key(PK; "Plant Type No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Plant Type No.", "Plant Type Name")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := Today;
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        LocationRec: Record Location;
    begin

        //Check for Exsistance
        LocationRec.Reset();
        LocationRec.SetRange("Plant Type No.", "Plant Type No.");
        if LocationRec.FindSet() then
            Error('Plant Type : %1 already used in operations. Cannot delete.', "Plant Type Name");

    end;


    trigger OnRename()
    begin

    end;

}
