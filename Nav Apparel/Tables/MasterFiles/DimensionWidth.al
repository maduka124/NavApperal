
table 71012602 DimensionWidth
{
    DataClassification = ToBeClassified;
    LookupPageId = "Dimension Width";
    DrillDownPageId = "Dimension Width";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Dimension Width"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Main Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Main Category"."No." where("Main Category Name" = filter(<> 'All Categories'));
        }

        field(71012584; "Main Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Length"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Created Date"; Date)
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
        fieldgroup(DropDown; "No.", "Dimension Width", "Main Category Name")
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
        BOMEstRec: Record "BOM Estimate Line";
    begin
        //Check for Exsistance
        BOMEstRec.Reset();
        BOMEstRec.SetRange("Dimension No.", "No.");
        if BOMEstRec.FindSet() then
            Error('Dimension/Width : %1 already used in operations. Cannot delete.', "Dimension Width");
    end;

    trigger OnRename()
    begin

    end;

}
