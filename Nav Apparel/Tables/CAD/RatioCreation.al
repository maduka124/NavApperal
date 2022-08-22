
table 50603 RatioCreation
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "RatioCreNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }

        field(4; "Group ID"; BigInteger)
        {
            DataClassification = ToBeClassified;
            TableRelation = GroupMaster."Group ID" where("Style No." = field("Style No."));
        }

        field(5; "Component Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = FabricMapping."Component Group" where("Style No." = field("Style No."), "Colour No" = field("Colour No"));
            //TableRelation = ComponentGroup."Component Group No." where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }

        field(9; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Colour No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Colour Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "UOM Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }

        field(14; UOM; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; RatioCreNo)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Group ID", "Component Group")
        {

        }
    }

    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("RatioCre Nos.");

        RatioCreNo := NoSeriesMngment.GetNextNo(NavAppSetup."RatioCre Nos.", Today, true);

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
