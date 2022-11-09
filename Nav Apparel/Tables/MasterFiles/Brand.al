
table 71012586 Brand
{
    DataClassification = ToBeClassified;
    LookupPageId = Brand;
    DrillDownPageId = Brand;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Brand Name"; text[50])
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

        field(71012585; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Merchandiser","Other";
            OptionCaption = 'Merchandiser,Other';
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
        fieldgroup(DropDown; "No.", "Brand Name")
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
        StyleRec.SetRange("Brand No.", "No.");
        if StyleRec.FindSet() then
            Error('Brand : %1 already used in operations. Cannot delete.', "Brand Name");
    end;

    trigger OnRename()
    begin

    end;

}
