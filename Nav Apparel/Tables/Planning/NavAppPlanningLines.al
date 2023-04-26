
table 50342 "NavApp Planning Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "PO No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Line No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Resource No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Carder"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Eff"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Learning Curve No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Learning Curve"."No." where(Active = filter(1));
        }

        field(12; SMV; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Finish Time"; Time)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "StartDateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "FinishDateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(19; Qty; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "TGTSEWFIN Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Target"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Front"; Media)
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Back"; Media)
        {
            DataClassification = ToBeClassified;
        }

        field(24; HoursPerDay; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(25; ProdUpdDays; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(26; "Resource Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Factory"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(28; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(29; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Style No.", "Lot No.", "Line No.")
        {
            Clustered = true;
        }

        key(SK; "Resource Name", StartDateTime)
        {

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Resource No.", "Resource Name")
        {
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}
