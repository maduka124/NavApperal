table 50859 FacWiseProductplaningLineTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Cutting Planned"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Cutting Achieved"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Cutting Deference"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Sewing Planned"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Sewing Achieved"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Sewing Deference"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Finishing Planned"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Finishing Achieved"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Finishing Deference"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "No."; Integer)
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