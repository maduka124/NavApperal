
table 50412 "Upload Document Type"
{
    DataClassification = ToBeClassified;
    LookupPageId = 50416;
    DrillDownPageId = 50416;

    fields
    {

        field(2; "Doc No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Doc Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Doc No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Doc No.", "Doc Name")
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
        SampleReqRec: Record "Sample Requsition Doc";
    begin

        //Check for Exsistance
        SampleReqRec.Reset();
        SampleReqRec.SetRange("Doc Type No.", "Doc No.");
        if SampleReqRec.FindSet() then
            Error('Document Type : %1 already used in "Sample Requsition". Cannot delete.', "Doc Name");

    end;

    trigger OnRename()
    begin

    end;

}
