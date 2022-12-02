table 50859 FacWiseProductplaningLineTable
{
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Cutting Planned"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Cutting Achieved"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Cutting Difference"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Sewing Planned"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Sewing Achieved"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Sewing Difference"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Finishing Planned"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Finishing Achieved"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Finishing Difference"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK1; "No.", Date)
        {
            Clustered = true;
        }
    }

}