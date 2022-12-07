
table 51088 Colour
{
    DataClassification = ToBeClassified;
    LookupPageId = Colour;
    DrillDownPageId = Colour;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Colour Name"; text[50])
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
        fieldgroup(DropDown; "No.", "Colour Name")
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
        AssorRec: Record AssortmentDetails;
    begin
        //Check for Exsistance
        AssorRec.Reset();
        AssorRec.SetRange("Colour No", "No.");
        if AssorRec.FindSet() then
            Error('Colour : %1 already used in operations. Cannot delete.', "Colour Name");

    end;

    trigger OnRename()
    begin

    end;

}
