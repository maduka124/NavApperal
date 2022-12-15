table 51160 AwaitingPOs
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Contract No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Buy-from Vendor Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "PO No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Pk1; "Contract No", "PO No", "Style No")
        {
            Clustered = true;
        }
    }
}