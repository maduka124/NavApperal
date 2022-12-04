
table 50909 "Dependency Style Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No."; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
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

        field(6; "Action Type No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Action Type"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Action Description"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Gap Days"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(10; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "MK Critical"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Action User"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }

        field(13; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Plan Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Buyer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Garment Type No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Garment Type Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Complete"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Department No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Department"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(24; "BPCD"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Revise"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(26; "Revise Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Main Dependency No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Style No.", "Line No.")
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
