
table 50916 "PI Po Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "PI No."; Code[200])
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

        field(71012587; "PO Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }
        field(71012588; "Line No"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
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
}
