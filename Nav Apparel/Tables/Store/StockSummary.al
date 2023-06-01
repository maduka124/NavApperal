table 51316 StockSummary
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; "Factory Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Buyer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Contract Lc No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Main Category Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; UOM; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Value; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "SeqNo"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Style Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(Key1; SeqNo)
        {
            Clustered = true;
        }
    }



}