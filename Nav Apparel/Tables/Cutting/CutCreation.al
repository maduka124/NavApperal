
table 50600 CutCreation
{
    DataClassification = ToBeClassified;

    fields
    {
        field(21; "CutCreNo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }

        field(24; "Group ID"; BigInteger)
        {
            DataClassification = ToBeClassified;
            TableRelation = RatioCreation."Group ID" where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }

        field(25; "Component Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = RatioCreation."Component Group Code" where("Style No." = field("Style No."), "Group ID" = field("Group ID"));
            //ValidateTableRelation = false;
            TableRelation = FabricMapping."Component Group" where("Style No." = field("Style No."), "Colour No" = field("Colour No"));
            ValidateTableRelation = false;
        }

        field(27; "Ply Height"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(28; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(29; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Marker Name"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = RatioCreationLine."Marker Name" where("Style No." = field("Style No."), "Group ID" = field("Group ID"), "Component Group Code" = field("Component Group"), "Record Type" = filter('R'));
            ValidateTableRelation = false;
        }

        field(11; "Colour No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Colour Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Po No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; CutCreNo)
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
        NavAppSetup.TestField("CutCre Nos.");

        CutCreNo := NoSeriesMngment.GetNextNo(NavAppSetup."CutCre Nos.", Today, true);

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
