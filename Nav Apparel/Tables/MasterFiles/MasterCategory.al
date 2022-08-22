
table 71012621 "Master Category"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Master Category List";
    DrillDownPageId = "Master Category List";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Master Category Name"; text[50])
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
        fieldgroup(DropDown; "No.", "Master Category Name")
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
        MainCatRec: Record "Main Category";
    begin
        //Check for Exsistance
        MainCatRec.Reset();
        MainCatRec.SetRange("Master Category No.", "No.");
        if MainCatRec.FindSet() then
            Error('Master Category : %1 already used in Main Category. Cannot delete.', "Master Category Name");
    end;

    trigger OnRename()
    begin

    end;

}