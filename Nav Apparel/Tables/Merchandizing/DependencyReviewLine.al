
table 71012795 "Dependency Review Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Dependency Group No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Dependency Group"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Action Description"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Gap Days"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(8; "Action User"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }

        field(9; "Plan Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "BPCD"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Revised"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Revise Date"; Date)
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

        field(15; "Line No."; BigInteger)
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
