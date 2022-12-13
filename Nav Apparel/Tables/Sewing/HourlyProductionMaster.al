
table 50513 "Hourly Production Master"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "Prod Date"; Date)
        {
            DataClassification = ToBeClassified;

        }

        field(3; "Factory No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location.Code;
        }

        field(4; "Factory Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sewing,Finishing;
            OptionCaption = 'Sewing,Finishing';
        }

        field(6; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Created User"; Code[50])
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

}
