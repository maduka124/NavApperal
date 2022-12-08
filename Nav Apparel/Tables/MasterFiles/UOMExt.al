tableextension 51136 "UOM Extension" extends "Unit of Measure"
{
    fields
    {
        field(50001; "Converion Parameter"; Decimal)
        {
            InitValue = 1;
        }

        field(50002; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}

