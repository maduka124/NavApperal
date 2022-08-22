
table 50589 SewingJobCreationLine2
{
    DataClassification = ToBeClassified;
   
    fields
    {
        field(1; "SJCNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Line No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Allocated Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(10; "Extra Cut %"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(11; "Total Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(12; "Day Max Target"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(13; "Line Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "SJCNo.", "Style No.", "PO No.", "Line No.")
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
