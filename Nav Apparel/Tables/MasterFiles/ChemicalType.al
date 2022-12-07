
table 51087 ChemicalType
{
    DataClassification = ToBeClassified;
    LookupPageId = ChemicalTypeList;
    DrillDownPageId = ChemicalTypeList;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Chemical Type Name"; text[50])
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
        fieldgroup(DropDown; "No.", "Chemical Type Name")
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
    // ItemRec: Record Item;
    begin
        // //Check for Exsistance
        // ItemRec.Reset();
        // ItemRec.SetRange("Chemical Type Code", "No.");
        // if ItemRec.FindSet() then
        //     Error('Chemical Type : %1 already used in Items. Cannot delete.', "Chemical Type Name");
    end;

}
