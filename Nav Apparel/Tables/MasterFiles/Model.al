
table 51104 Model
{
    DataClassification = ToBeClassified;
    LookupPageId = ModelList;
    DrillDownPageId = ModelList;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Model Name"; text[50])
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
        fieldgroup(DropDown; "No.", "Model Name")
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
        // ItemRec.SetRange("Brand Code", "No.");
        // if ItemRec.FindSet() then
        //     Error('Model : %1 already used in Items. Cannot delete.', "Model Name");
    end;

}
