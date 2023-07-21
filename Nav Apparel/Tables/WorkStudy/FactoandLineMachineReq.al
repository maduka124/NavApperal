table 51366 FactoryandlinemachineReqlist
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Factory Name"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Resource No."; code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "NavApp Prod Plans Details"."Resource No." where("Factory No." = field("Factory Code"));
            // // TableRelation = "NavApp Planning Lines"."Resource Name" where(Factory = field("Factory Code"));
            // TableRelation = "NavApp Planning Lines"."Resource Name" where(Factory = field("Factory Code"));
            // ValidateTableRelation = false;
        }

        field(6; "Resource Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Work Center".Name where("Factory No." = field("Factory Code"));
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(PK; "Factory Code")
        {
            Clustered = true;
        }
    }
}