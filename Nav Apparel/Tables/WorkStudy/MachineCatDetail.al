
table 50445 "Machine Category"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Machine Category List";
    DrillDownPageId = "Machine Category List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Machine Category"; text[50])
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

        field(5; "Secondary UserID"; Code[20])
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
        fieldgroup(DropDown; "No.", "Machine Category")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;


    trigger OnDelete()
    var
        MacRec: Record "Machine Master";
    begin

        //Check for Existance
        MacRec.Reset();
        MacRec.SetRange("Machine Category", "No.");
        if MacRec.FindSet() then
            Error('Machine Category : %1 already used in Machine Master. Cannot delete.', "Machine Category");

    end;

}
