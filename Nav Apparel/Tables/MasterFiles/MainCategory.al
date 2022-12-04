
table 71012615 "Main Category"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Main Category List";
    DrillDownPageId = "Main Category List";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Main Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Master Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Master Category Name"; text[50])
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

        field(71012587; "Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "DimensionOnly"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "SewingJobOnly"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012590; "LOTTracking"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Inv. Posting Group Code"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Inventory Posting Group".Code;
        }

        field(71012592; "Inv. Posting Group Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Prod. Posting Group Code"; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Product Posting Group".Code;
        }

        field(71012594; "Prod. Posting Group Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(71012595; "Style Related"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012596; "No Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }

        field(50100; "Routing Link Code"; Code[10])
        {
            Caption = 'Routing Link Code';
            DataClassification = ToBeClassified;
            TableRelation = "Routing Link";
        }

        field(50101; "General Issuing"; Boolean)
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
        fieldgroup(DropDown; "No.", "Main Category Name", "Master Category Name")
        {

        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
        ItemCategoryRec: Record "Item Category";
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("MainCat Nos.");
        "No." := NoSeriesMngment.GetNextNo(NavAppSetup."MainCat Nos.", Today, true);
        "Created Date" := WorkDate();
        "Created User" := UserId;

        //Insert in to Item category
        ItemCategoryRec.Reset();
        ItemCategoryRec.SetRange(Code, "No.");
        if not ItemCategoryRec.FindSet() then begin
            ItemCategoryRec.Init();
            ItemCategoryRec.Code := "No.";
            ItemCategoryRec.Insert();
        end;
    end;

    trigger OnModify()
    var
        ItemCategoryRec: Record "Item Category";
    begin
        //Insert in to Item category
        ItemCategoryRec.Reset();
        ItemCategoryRec.SetRange(Code, "No.");
        if ItemCategoryRec.FindSet() then begin
            ItemCategoryRec.Description := "Main Category Name";
            ItemCategoryRec.Modify();
        end;
    end;

    trigger OnDelete()
    var
        SubCategoryRec: Record "Sub Category";
    begin
        //Check for Exsistance
        SubCategoryRec.Reset();
        SubCategoryRec.SetRange("Main Category No.", "No.");
        if SubCategoryRec.FindSet() then
            Error('Main Category : %1 already used in operations. Cannot delete.', "Main Category Name");
    end;


}