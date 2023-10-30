table 51451 WashinProductionLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Buyer Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Buyer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Style Master"."Style No." where("Buyer Name" = field("Buyer Name"));
            // TableRelation = WashingMaster."Style Name" where("Buyer Name" = field("Buyer Name"));
            // ValidateTableRelation = false;
        }

        field(6; "PO No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Lot No"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = WashingMaster.Lot where("Style No" = field("Style No."));
            // ValidateTableRelation = false;
        }

        field(8; "Color Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Color Name"; text[50])
        {
            DataClassification = ToBeClassified;
            // TableRelation = WashingMaster."Color Name" where("Style No" = field("Style No."), Lot = field("Lot No"), "PO No" = field("PO No"));
            // ValidateTableRelation = false;
        }

        field(12; "Day Production Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Production FINAL WASH"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Production LASER WHISKERS"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Production LASER DESTROY"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Production PP SPRAY"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Production WHISKERS"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(28; "Production ACID/ RANDOM WASH"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Production BASE WASH"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Production BRUSH"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Production DESTROY"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Production LASER BRUSH"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Production Updated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Production Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(26; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK1; No, "Line No")
        {
            Clustered = true;
        }
    }

}