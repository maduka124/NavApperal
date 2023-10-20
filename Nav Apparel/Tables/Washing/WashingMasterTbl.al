table 51430 WashingMaster
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        // field(2; "Seq No"; Integer)
        // {
        //     DataClassification = ToBeClassified;
        // }

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
            TableRelation = Location.Name where("Sewing Unit" = filter(1));
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

        field(21; "Plan Max Target"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Washing Plant Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Cut Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Sew Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(52; "Received Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(53; "First Received Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(54; "Last Received Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(55; "Plan Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Shade Band Approval Plan Date';
        }

        field(56; "Actual Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Shade Band Actual Approval Plan Date';
        }

        field(57; "Close Plan Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Washing Plan Date';
        }

        field(58; "Close Actual Plan Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Washing Actual Plan Date';
        }

        field(59; "Delivery Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(60; "Delivery End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(61; "Delivery Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "Style No", "PO No", Lot, "Color Code")
        {
            Clustered = true;
        }

        key(SK; "Plan Start Date")
        {

        }
    }
}