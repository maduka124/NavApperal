
table 50619 FabricRequsition
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "FabReqNo."; Code[20])
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

        field(4; "Colour No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Colour Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Group ID"; BigInteger)
        {
            DataClassification = ToBeClassified;
            TableRelation = GroupMaster."Group ID" where("Style No." = field("Style No."));
        }

        field(7; "Component Group Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = FabricMapping."Component Group" where("Style No." = field("Style No."), "Colour No" = field("Colour No"));
            ValidateTableRelation = false;
        }

        field(8; "Component Group Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Marker Name"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = CutCreationLine."Marker Name" where("Style No." = field("Style No."), "Group ID" = field("Group ID"), "Component Group Code" = field("Component Group Code"), "Record Type" = filter('R'));
            ValidateTableRelation = false;
        }

        field(10; "Cut No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = CutCreationLine."Cut No" where("Style No." = field("Style No."), "Group ID" = field("Group ID"), "Component Group Code" = field("Component Group Code"), "Marker Name" = field("Marker Name"), "Cut No" = filter(<> 0));
            ValidateTableRelation = false;
        }

        field(11; "Marker Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(12; "UOM Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(13; UOM; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Table No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Table Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "TableMaster"."Table Name";
            ValidateTableRelation = false;
        }

        field(16; "Required Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(19; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Location Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Location Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "FabReqNo.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "FabReqNo.", "Style Name", "Colour Name", "Component Group Name", "Group ID", "Marker Name", "Cut No")
        {

        }
    }


    trigger OnInsert()
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        NavAppSetup.TestField("FabReqNo Nos.");

        "FabReqNo." := NoSeriesMngment.GetNextNo(NavAppSetup."FabReqNo Nos.", Today, true);

        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;


    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        RoleRec: Record "RoleIssuingNoteHeader";
    begin

        //Check for Exsistance
        RoleRec.Reset();
        RoleRec.SetRange("Req No.", "FabReqNo.");
        if RoleRec.FindSet() then
            Error('Fabric Requsition : %1 already used in Role Issuing. Cannot delete.', "FabReqNo.");

    end;

    trigger OnRename()
    begin

    end;

}
