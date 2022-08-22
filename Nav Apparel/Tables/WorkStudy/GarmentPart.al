
table 50442 GarmentPart
{
    DataClassification = ToBeClassified;
    LookupPageId = "Garment Part List";
    DrillDownPageId = "Garment Part List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Description"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Item Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Item Type Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Type"."Item Type Name";
            ValidateTableRelation = false;
        }

        field(5; "Department No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Department Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."Department Name";
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
        fieldgroup(DropDown; "No.", Description)
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
        NewBreakRec: Record "New Breakdown";
        NewOpRec: Record "New Operation";
    begin

        //Check for Exsistance
        NewBreakRec.Reset();
        NewBreakRec.SetRange("Garment Part No.", "No.");
        if NewBreakRec.FindSet() then
            Error('Garment Part : %1 already used in New Breakdown. Cannot delete.', Description);

        //Check for Exsistance
        NewOpRec.Reset();
        NewOpRec.SetRange("Garment Part No.", "No.");
        if NewOpRec.FindSet() then
            Error('Garment Part : %1 already used in New Operation. Cannot delete.', Description);

    end;

    trigger OnRename()
    begin

    end;

}
