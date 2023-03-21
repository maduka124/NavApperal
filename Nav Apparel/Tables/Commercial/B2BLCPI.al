
table 50524 "B2BLCPI"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "B2BNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "PI No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "PI Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "PI Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Suppler No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        // Done By Sachith On 21/03/23
        field(9; "New PI No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "B2BNo.", "PI No.")
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
