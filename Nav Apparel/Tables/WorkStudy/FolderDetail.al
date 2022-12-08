
table 50468 "Folder Detail"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Folder Detail List";
    DrillDownPageId = "Folder Detail List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Folder Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Secondary UserID"; Code[20])
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
        fieldgroup(DropDown; "No.", "Folder Name")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnDelete()
    var
        NewBreakRec: Record "New Breakdown Op Line2";
    begin

        //Check for Exsistance
        NewBreakRec.Reset();
        NewBreakRec.SetRange(Attachment, "No.");
        if NewBreakRec.FindSet() then
            Error('Folder : %1 already used in operations. Cannot delete.', "Folder Name");

    end;
}
