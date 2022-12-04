
table 51100 LoginDetails
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "UserID Secondary"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "User Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "SessionID"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Pw"; code[50])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }

        field(6; "LastLoginDateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Active"; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = true;
        }

        field(8; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "UserID Secondary")
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
