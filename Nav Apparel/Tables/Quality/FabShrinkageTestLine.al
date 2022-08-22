
table 50685 "FabShrinkageTestLine"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "FabShrTestNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Pattern Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Pattern Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "SHRINKAGE"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "From Length%"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(7; "To Length%"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(8; "Length%"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "PTN VARI Length"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "From WiDth%"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(11; "To WiDth%"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(12; "WiDth%"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "PTN VARI WiDth"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Avg Pattern% Length"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(17; "Avg Pattern% Width"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }
    }

    keys
    {
        key(PK; "FabShrTestNo.", "Line No.")
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
