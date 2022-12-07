
table 51095 "Garment Store"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Garment Store";
    DrillDownPageId = "Garment Store";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Store Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Country No_"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Country"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Secondary UserID"; Code[20])
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
        fieldgroup(DropDown; "No.", "Store Name", Country)
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
        StyleRec: Record "Style Master";
    begin
        //Check for Exsistance
        StyleRec.Reset();
        StyleRec.SetRange("Store No.", "No.");
        if StyleRec.FindSet() then
            Error('Store : %1 already used in operations. Cannot delete.', "Store Name");
    end;

    trigger OnRename()
    begin

    end;

}