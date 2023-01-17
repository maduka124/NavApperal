table 50210 PIinformationLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(8; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Line No"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(1; Supplier; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Suplier No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Main Category"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Main Category No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Item Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Item Discription"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Order Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(7; Vlues; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK1; No, "Line No")
        {
            Clustered = true;
        }
    }
}