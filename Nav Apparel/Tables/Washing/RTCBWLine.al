table 50677 RTCBWLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(3; Item; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Washing Sample Requsition Line"."Fabric Description" where("No." = field("Req No"));
            ValidateTableRelation = false;
        }

        field(4; UOM; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
            ValidateTableRelation = false;
        }

        field(5; Qty; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Request Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Created User"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Pk; "No.", "Req No", "Line No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        RTCBWHeaderRec: Record RTCBWHeader;
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}