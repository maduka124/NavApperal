
table 50332 "Planning Queue"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Planning Queue List";
    DrillDownPageId = "Planning Queue List";

    fields
    {
        field(1; "Queue No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master"."Style No." where(Status = filter(Confirmed));
            ValidateTableRelation = false;
        }

        field(4; "PO No."; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."PO No.";
        }

        field(5; Qty; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(6; SMV; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(7; "TGTSEWFIN Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Learning Curve No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Learning Curve"."No." where(Active = filter(1));
            InitValue = 0;
        }

        field(9; "Resource No"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Finish Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "No of days"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(13; "Eff"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(14; "Planned User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Planned Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "PlannedQty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(17; "Carder"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(18; "Target"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(19; "HoursPerDay"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 10;
        }

        field(20; "Front"; Media)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Back"; Media)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Waistage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Factory"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(25; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(26; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(28; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Queue No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}
