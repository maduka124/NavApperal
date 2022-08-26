table 50662 "WashingStep"
{
    DataClassification = ToBeClassified;
    LookupPageId = WashingStep;
    DrillDownPageId = WashingStep;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Created User"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }


    keys
    {
        key(pk; Code)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}