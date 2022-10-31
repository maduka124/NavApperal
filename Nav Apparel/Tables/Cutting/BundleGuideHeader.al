
table 50664 BundleGuideHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "BundleGuideNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }

        field(4; "Color No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Color Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = AssorColorSizeRatio."Colour Name" where("Style No." = field("Style No."), "Colour Name" = filter('<> *'));
            ValidateTableRelation = false;
        }

        field(6; "Group ID"; BigInteger)
        {
            DataClassification = ToBeClassified;
            TableRelation = GroupMaster."Group ID" where("Style No." = field("Style No."));
        }

        field(7; "Component Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = FabricMapping."Component Group" where("Style No." = field("Style No."), "Colour No" = field("Color No"));
            ValidateTableRelation = false;
        }

        field(8; "Cut No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = CutCreationLine."Cut No" where("Style No." = field("Style No."), "Group ID" = field("Group ID"), "Component Group Code" = field("Component Group"), "Colour No" = field("Color No"), "Cut No" = filter(<> 0));
            ValidateTableRelation = false;
        }

        field(9; "Bundle Rule"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Bundle Method"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,"Roll Wise";
            OptionCaption = 'Normal,Roll Wise';
        }

        field(11; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Created User"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "BundleGuideNo.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "BundleGuideNo.", "Style No.", "Color Name", "Group ID", "Component Group", "Cut No")
        {
        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("BundleGuide Nos.");

        "BundleGuideNo." := NoSeriesMngment.GetNextNo(NavAppSetup."BundleGuide Nos.", Today, true);

        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
