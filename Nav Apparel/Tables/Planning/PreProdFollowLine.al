table 50833 PreProductionFollowUpline
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Factory"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Buyer"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Order Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Ship Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "PP Sample Recevied Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Patten Received Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Fabric Received Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Shrinkage Report Received Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Fabric Relax Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Size Set Marker Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "size Set Cutting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Size Set Sewing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Size Set Wash Send Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Size Set Wash Received Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Size Set QC Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Pilot Cutting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Pilot Sewing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Pilot Wash Send Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Pilot Wash Received Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Pilot Report"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Bulk Cutting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Line layout Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Remarks"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Create User"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }

        field(28; "Production File Received Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Buyer No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(31; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(38; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(39; "Factory Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(40; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Line No", "Factory", "Style No")
        {
            Clustered = true;
        }
    }

}