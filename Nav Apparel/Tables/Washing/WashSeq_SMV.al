table 51443 WashingSequenceHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Buyer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Buyer Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Style Name"; Text[200])
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

    var
        myInt: Integer;

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