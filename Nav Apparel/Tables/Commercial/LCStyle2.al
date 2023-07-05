
table 51354 "LC Style 2"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; Qty; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Buyer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Assign LC No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Line No"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(11; "LC No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Line No", "LC No")
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

}
