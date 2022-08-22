
table 71012750 "Sample Type Buyer"
{
    DataClassification = ToBeClassified;
    //LookupPageId = 50214;
    //DrillDownPageId = 50214;

    fields
    {
        field(71012581; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Sample Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Lead Time"; integer)
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
        key(PK; "Buyer No.", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Sample Type Name")
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
    begin

    end;

    trigger OnRename()
    begin

    end;

}
