table 51422 PendingAllocationWash
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Seq No"; Integer)
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

        field(8; "Shipment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Sewing Factory Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name where("Sewing Unit" = filter(true));
            ValidateTableRelation = false;
        }

        field(10; "Sewing Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Plan Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Plan End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "PO Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Wash Allocated"; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = false;
        }

        field(15; "Plan Max Target"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Cancel"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Seq No")
        {
            Clustered = true;
        }

        key(SK; "Plan Start Date")
        {

        }
    }
}