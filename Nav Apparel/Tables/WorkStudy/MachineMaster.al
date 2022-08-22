
table 50451 "Machine Master"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Machine Master";
    DrillDownPageId = "Machine Master";

    fields
    {
        field(1; "Machine No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Machine Description"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Machine Category"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Machine Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Machine Category"."Machine Category";
            ValidateTableRelation = false;
        }

        field(5; "Needle Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Needle Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = NeedleType."Needle Description";
            ValidateTableRelation = false;
        }

        field(7; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Machine Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Machine,Helper;
            OptionCaption = 'Machine,Helper';
        }
    }

    keys
    {
        key(PK; "Machine No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Machine No.", "Machine Description")
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
        NewBreakRec: Record "New Breakdown Op Line1";
        NewOpRec: Record "New Operation";
    begin

        //Check for Exsistance
        NewBreakRec.Reset();
        NewBreakRec.SetRange("Machine No.", "Machine No.");
        if NewBreakRec.FindSet() then
            Error('Machine : %1 already used in New Breakdown. Cannot delete.', "Machine Description");

        //Check for Exsistance
        NewOpRec.Reset();
        NewOpRec.SetRange("Machine No.", "Machine No.");
        if NewOpRec.FindSet() then
            Error('Machine : %1 already used in New Operations. Cannot delete.', "Machine Description");

    end;

    trigger OnRename()
    begin

    end;

}
