table 51425 AllocatedPoWash
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Seq No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Buyer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Style Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "PO No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; Lot; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Color Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Color Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Shipment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Sewing Factory Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name where("Sewing Unit" = filter(true));
            ValidateTableRelation = false;
        }

        field(12; "Sewing Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Plan Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Plan End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Washing Plant"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name where("Plant Type Name" = filter('WASHING UNIT'));
            ValidateTableRelation = false;
        }

        field(16; "Wash Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Wash Type"."Wash Type Name" where(Allocation = filter(1));
            ValidateTableRelation = false;
        }

        field(17; "PO Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Buyer Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Color Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(20; Recipe; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Wash Allocated Color"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Plan Max Target"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Washing Plant Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Line No", "Seq No")
        {
            Clustered = true;
        }
    }

}