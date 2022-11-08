
table 50428 "Sample Room"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Sample Room List";
    DrillDownPageId = "Sample Room List";

    fields
    {
        field(1; "Sample Room No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Sample Room Name"; text[50])
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

        field(5; "Global Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }
    }

    keys
    {
        key(PK; "Sample Room No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Sample Room No.", "Sample Room Name")
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
        SampleReqRec: Record "Sample Requsition Header";
    begin

        //Check for Exsistance
        SampleReqRec.Reset();
        SampleReqRec.SetRange("Sample Room No.", "Sample Room No.");
        if SampleReqRec.FindSet() then
            Error('Sample Room : %1 already used in "Sample Requsition". Cannot delete.', "Sample Room Name");

    end;

    trigger OnRename()
    begin

    end;

}
