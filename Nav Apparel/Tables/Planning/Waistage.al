
table 50368 Wastage
{
    DataClassification = ToBeClassified;
    LookupPageId = Wastage;
    DrillDownPageId = Wastage;

    fields
    {
        field(1; "Start Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(2; "Finish Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(3; "Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(5; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
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
