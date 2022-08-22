
table 50477 "Maning Levels Line"
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

        field(7; "Department No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Department Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Department."Department Name";
            ValidateTableRelation = false;
        }

        field(9; "SMV Machine"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "SMV Manual"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Target Per Hour"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Theo MO"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Theo HP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Act MO"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Act HP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Act MC"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Comments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Created Date"; Date)
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
