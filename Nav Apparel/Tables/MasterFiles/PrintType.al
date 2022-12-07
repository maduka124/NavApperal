
table 51128 "Print Type"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Print Type List";
    DrillDownPageId = "Print Type List";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Print Type Name"; text[50])
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
        fieldgroup(DropDown; "No.", "Print Type Name")
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
        BOMEstCostRec: Record "BOM Estimate Cost";
    begin
        //Check for Exsistance
        BOMEstCostRec.Reset();
        BOMEstCostRec.SetRange("Print Type", "No.");
        if BOMEstCostRec.FindSet() then
            Error('Print Type : %1 already used in operations. Cannot delete.', "Print Type Name");

    end;

    trigger OnRename()
    begin

    end;

}
