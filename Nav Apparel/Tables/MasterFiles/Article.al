
table 51083 Article
{
    DataClassification = ToBeClassified;
    LookupPageId = Article;
    DrillDownPageId = Article;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Article"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Main Category No."; Code[20])
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
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }

        key(SK; "Main Category Name", Article)
        {

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Article, "Main Category Name")
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
        BOMEstLineRec: Record "BOM Estimate Line";
    begin

        //Check for Exsistance
        BOMEstLineRec.Reset();
        BOMEstLineRec.SetRange("Article No.", "No.");
        if BOMEstLineRec.FindSet() then
            Error('Article : %1 already used in operations. Cannot delete.', Article);

    end;

    trigger OnRename()
    begin

    end;

}
