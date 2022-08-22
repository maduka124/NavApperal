
table 71012713 "PI Po Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "PI No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; Qty; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012584; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "PI No.", "PO No.")
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
