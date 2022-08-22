
table 50508 "Contract Commision"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No."; bigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(3; "Commision No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Commision"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Charge".Description;
            ValidateTableRelation = false;
        }

        field(5; "Currency No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Currency"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Description;
            ValidateTableRelation = false;
        }

        field(7; "Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(8; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(9; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Created Date"; Date)
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
