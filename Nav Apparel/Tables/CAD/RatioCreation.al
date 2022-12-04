
table 50603 RatioCreation
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50001; "RatioCreNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50002; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }

        field(50004; "Group ID"; BigInteger)
        {
            DataClassification = ToBeClassified;
            TableRelation = GroupMaster."Group ID" where("Style No." = field("Style No."));
        }

        field(50005; "Component Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = FabricMapping."Component Group" where("Style No." = field("Style No."), "Colour No" = field("Colour No"));
            //TableRelation = ComponentGroup."Component Group No." where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }

        field(50006; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50007; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(50008; "Colour No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50009; "Colour Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "UOM Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }

        field(50011; UOM; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        // field(15; "Lot No."; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(50012; "Po No."; Code[20])
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

}
