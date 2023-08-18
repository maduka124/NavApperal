
table 50345 "NavApp Prod Plans Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "PlanDate"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "PO No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Line No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Resource No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Carder"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Eff"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Learning Curve No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Learning Curve"."No.";
        }

        field(11; SMV; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Finish Time"; Time)
        {
            DataClassification = ToBeClassified;
        }

        field(14; Qty; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Target"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(16; HoursPerDay; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(17; ProdUpd; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(18; ProdUpdQty; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(19; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Factory No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Brand Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(24; "LCurve Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }

        field(25; "LCurve Hours Per Day"; Decimal)
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

        key(SK; "PO No.", "Resource No.", PlanDate)
        {
            //Clustered = true;
        }
        key(SK1; "Resource No.", "Style No.")
        {
            //Clustered = true;
        }
        key(SK2; "Line No.")
        {
            //Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
