
table 50483 "Machine Layout"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "PKey"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Type"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "WP No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Machine Layout Line1"."Line No.";
        }

        field(6; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Description"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Machine No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Machine Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Minutes"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Target"; Decimal)
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


    }

    keys
    {
        key(PK; PKey)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
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
