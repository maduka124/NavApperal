table 50108 "Temp. Budget Entry"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "G/L Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "G/L Code", Date)
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