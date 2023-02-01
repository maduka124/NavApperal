
table 51226 ServiceScheduleHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; ServiceType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "",Weekly,Monthly,Quarterly,Annualy;
            OptionCaption = '"",Weekly,Monthly,Quarterly,Annualy';
        }

        field(3; "Brand No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Brand Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Brand."Brand Name" where(Type = filter(Other));
            ValidateTableRelation = false;
        }

        field(5; "Model No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Model Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Model."Model Name";
            ValidateTableRelation = false;
        }

        field(7; "Machine Category Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Machine Category"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Service Item".Description;
            ValidateTableRelation = false;
        }

        field(9; "Part No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Part Name"; text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item.Description where(Article = field("Brand Name"), "Color Name" = field("Model Name"), "Size Range No." = field("Machine Category"));
            ValidateTableRelation = false;
        }

        field(11; "Unit N0."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }

        field(12; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(13; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Global Dimension Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1), Blocked = CONST(false));
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }

        key(SK; ServiceType, "Brand Name", "Model Name", "Machine Category")
        {
        }
    }


    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}
