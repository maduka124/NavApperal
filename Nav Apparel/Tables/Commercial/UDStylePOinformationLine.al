table 50208 UDStylePOinformation
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "PO No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Order Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Ship Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Values"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Ship Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Ship Values"; Decimal)
        {
            DataClassification = ToBeClassified;
        }      

    }

    keys
    {
        key(PK1; "No.", "Line No")
        {
            Clustered = true;
        }
    }
}