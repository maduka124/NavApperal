table 51460 WashCloseLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; Lot; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "PO No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; Reject; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(8; Sample; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Left Over"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Production Loss"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "CST%"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Closing Status"; Option)
        {
            OptionMembers = "Open","Closed";
            OptionCaption = 'Open,Closed';
        }

        field(13; "Color Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Color Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; No, "Line No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
}