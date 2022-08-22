
table 71012772 "Sample Type"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Sample Type";
    DrillDownPageId = "Sample Type";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Sample Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Lead Time"; integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Selection"; Integer)
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

        field(71012587; "Selected"; Boolean)
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
        fieldgroup(DropDown; "No.", "Sample Type Name")
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
        SampleReqRec: Record "Sample Requsition Line";
    begin

        //Check for Exsistance
        SampleReqRec.Reset();
        SampleReqRec.SetRange("Sample No.", "No.");
        if SampleReqRec.FindSet() then
            Error('Sample Type : %1 already used in "Sample Requsition". Cannot delete.', "Sample Type Name");

    end;

    trigger OnRename()
    begin

    end;

}
