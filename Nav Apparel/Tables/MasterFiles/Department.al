
table 51092 "Department"
{
    DataClassification = ToBeClassified;
    LookupPageId = Department;
    DrillDownPageId = Department;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Department Name"; text[50])
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

        field(71012585; "Show in New Operations"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Show in Manpower Budget"; Boolean)
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
        fieldgroup(DropDown; "No.", "Department Name")
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
        DepParaRec: Record "Dependency Parameters";
        GarmentPartRec: Record GarmentPart;
    begin
        //Check for Exsistance
        DepParaRec.Reset();
        DepParaRec.SetRange("Department No.", "No.");
        if DepParaRec.FindSet() then
            Error('Department : %1 already used in operations. Cannot delete.', "Department Name");

        GarmentPartRec.Reset();
        GarmentPartRec.SetRange("Department No", "No.");
        if GarmentPartRec.FindSet() then
            Error('Department : %1 already used in operations. Cannot delete.', "Department Name");
    end;


    trigger OnRename()
    begin

    end;

}