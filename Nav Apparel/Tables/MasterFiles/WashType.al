
table 51140 "Wash Type"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Wash Type";
    DrillDownPageId = "Wash Type";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Wash Type Name"; text[50])
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
        fieldgroup(DropDown; "No.", "Wash Type Name")
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
        SampleReqRec: Record "Sample Requsition Header";
    begin
        //Check for Exsistance
        BOMEstRec.Reset();
        BOMEstRec.SetRange("Wash Type", "No.");
        if BOMEstRec.FindSet() then
            Error('Wash Type : %1 already used in operations. Cannot delete.', "Wash Type Name");

        SampleReqRec.Reset();
        SampleReqRec.SetRange("Wash Type No.", "No.");
        if SampleReqRec.FindSet() then
            Error('Wash Type : %1 already used in operations. Cannot delete.', "Wash Type Name");


    end;

    trigger OnRename()
    begin

    end;

}
