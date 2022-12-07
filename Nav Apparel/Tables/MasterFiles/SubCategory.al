
table 51134 "Sub Category"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Sub Category";
    DrillDownPageId = "Sub Category";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Sub Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Main Category No."; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Main Category"."No." where("Main Category Name" = filter(<> 'ALL CATEGORIES'));
        }

        field(71012584; "Main Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Secondary UserID"; Code[20])
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
        fieldgroup(DropDown; "No.", "Sub Category Name", "Main Category Name")
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
        ItemRec: Record "item";
        BOMRec: Record "BOM Line AutoGen";
    begin
        //Check for Exsistance
        ItemRec.Reset();
        ItemRec.SetRange("Sub Category No.", "No.");
        if ItemRec.FindSet() then
            Error('Sub Category : %1 already used in operations. Cannot delete.', "Sub Category Name");

        BOMRec.Reset();
        BOMRec.SetRange("Sub Category No.", "No.");
        if BOMRec.FindSet() then
            Error('Sub Category : %1 already used in operations. Cannot delete.', "Sub Category Name");
    end;

    trigger OnRename()
    begin

    end;

}
