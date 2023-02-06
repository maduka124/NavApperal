
table 51231 ServiceWorksheetHeaderNew
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; ServiceType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Weekly,Monthly,Quarterly,Annualy;
            OptionCaption = '"",Weekly,Monthly,Quarterly,Annualy';
        }

        field(3; "StartDate"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "EndDate"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Global Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }

        field(6; "Factory No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Factory"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Name where("Sewing Unit" = filter(true));
            ValidateTableRelation = false;
        }

        field(8; "Work Center No"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Work Center Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Work Center"."No." where("Factory No." = field("Factory No."), "Linked To Service Item" = filter(true));
            ValidateTableRelation = false;
        }

        field(10; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }

        key(SK; Factory, "Work Center Name", ServiceType, StartDate)
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}
