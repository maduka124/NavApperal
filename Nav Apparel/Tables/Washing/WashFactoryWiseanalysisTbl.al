table 51431 WashFactoryWiseanalysisTbl
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Wash Type"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Jan; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(3; Feb; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Mar; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Apr; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(6; May; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(7; Jun; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(8; Jul; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(9; Aug; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(10; Sep; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(11; Oct; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(12; Nov; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(13; Dec; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(14; Total; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Record type"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Wash Type")
        {
            Clustered = true;
        }

        key(SK; "Line No")
        {

        }
    }

}