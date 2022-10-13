
table 50809 "Dept_Designations"
{
    DataClassification = ToBeClassified;
    LookupPageId = Dept_DesignationsList1;
    DrillDownPageId = Dept_DesignationsList1;

    fields
    {
        field(71012581; "Department No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Department Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Designations No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Designations Name"; text[50])
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
    }

    keys
    {
        key(PK; "Department No.", "Designations No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Department Name", "Designations Name")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}