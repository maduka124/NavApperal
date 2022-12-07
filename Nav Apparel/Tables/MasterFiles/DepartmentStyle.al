
table 51093 "Department Style"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Department (Style)";
    DrillDownPageId = "Department (Style)";

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
        StyleRec: Record "Style Master";
    begin
        //Check for Exsistance
        StyleRec.Reset();
        StyleRec.SetRange("Department No.", "No.");
        if StyleRec.FindSet() then
            Error('Department : %1 already used in operations. Cannot delete.', "Department Name");
    end;

    trigger OnRename()
    begin

    end;

}