
table 50610 TableCreartionLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "TableCreNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(4; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No.";
            ValidateTableRelation = false;
        }

        field(5; "Colour No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Colour Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Group ID"; BigInteger)
        {
            DataClassification = ToBeClassified;
            TableRelation = CutCreation."Group ID" where("Style No." = field("Style No."));
            ValidateTableRelation = false;
        }

        field(8; "Component Group"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = FabricMapping."Component Group" where("Style No." = field("Style No."), "Colour No" = field("Colour No"));
            ValidateTableRelation = false;
        }

        field(10; "Marker Name"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = CutCreationLine."Marker Name" where("Style No." = field("Style No."), "Group ID" = field("Group ID"), "Component Group Code" = field("Component Group"), "Record Type" = filter('R'), "Cut No" = filter(<> 0));
            ValidateTableRelation = false;
        }

        field(11; "Cut No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = CutCreationLine."Cut No" where("Style No." = field("Style No."), "Group ID" = field("Group ID"), "Component Group Code" = field("Component Group"), "Marker Name" = field("Marker Name"), "Cut No" = filter(<> 0));
            ValidateTableRelation = false;
        }

        field(12; "Layering Start Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Layering End Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Cut Start Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Cut End Date/Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "TableCreNo.", "Line No")
        {
            Clustered = true;
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
    begin

    end;

    trigger OnRename()
    begin

    end;

}
