
table 51232 ServiceWorksheetLineNew
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Doc No"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Part No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Part Name"; text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Brand No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Brand Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Brand."Brand Name" where(Type = filter(Other));
            ValidateTableRelation = false;
        }

        field(7; "Model No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Model Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Model."Model Name";
            ValidateTableRelation = false;
        }

        field(9; "Machine Category Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Machine Category"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Service Item".Description;
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

        field(13; "Service Date"; date)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Remarks"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Next Service Date"; date)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(20; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Technician No"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Technician Name"; text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Technician.Name where(Active = filter(true));
            ValidateTableRelation = false;
        }

        field(23; "Line No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }

        key(SK; "Brand Name", "Model Name", "Machine Category")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}
