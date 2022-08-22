
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
