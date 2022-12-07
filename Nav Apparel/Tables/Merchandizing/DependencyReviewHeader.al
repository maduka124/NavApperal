
table 50906 "Dependency Review Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Line No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Secondary UserID"; Code[20])
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
