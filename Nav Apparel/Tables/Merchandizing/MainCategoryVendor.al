
table 50238 "Main Category Vendor"
{
    DataClassification = ToBeClassified;
    //LookupPageId = 50227;
    //DrillDownPageId = 50227;

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Main Category Name"; text[50])
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

        field(7; "Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Vendor Name"; text[200])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Vendor No.", "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Vendor No.", "Vendor Name", "No.", "Main Category Name")
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