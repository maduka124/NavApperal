
table 71012624 Pack
{
    DataClassification = ToBeClassified;
    LookupPageId = "Pack List";
    DrillDownPageId = "Pack List";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Pack"; text[50])
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
        fieldgroup(DropDown; "No.", Pack)
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
        AssorRec.SetRange("Pack No", "No.");
        if AssorRec.FindSet() then
            Error('Pack : %1 already used in operations. Cannot delete.', Pack);

    end;

    trigger OnRename()
    begin

    end;

}
