
table 50460 "Item Type"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Item Type List";
    DrillDownPageId = "Item Type List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Item Type Name"; text[50])
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
        fieldgroup(DropDown; "No.", "Item Type Name")
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
        GarmentPartRec: Record GarmentPart;
    begin

        //Check for Exsistance
        GarmentPartRec.Reset();
        GarmentPartRec.SetRange("Item Type No.", "No.");
        if GarmentPartRec.FindSet() then
            Error('Item Type : %1 already used in Garment Parts. Cannot delete.', "Item Type Name");

    end;

    trigger OnRename()
    begin

    end;

}
