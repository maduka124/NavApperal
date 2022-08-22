
table 50479 "Machine Layout Line1"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Description"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Machine No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Machine Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Minutes"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Target"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "WP No"; Integer)
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
