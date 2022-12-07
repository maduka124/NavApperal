table 50651 WashingMachineType
{
    DataClassification = ToBeClassified;
    LookupPageId = WashingMachineTypeList;
    DrillDownPageId = WashingMachineTypeList;

    fields
    {
        field(1; code; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Created User"; Code[50])
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
        key(pk; code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}