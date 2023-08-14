
table 51393 ExtraPercentageForCutting
{
    DataClassification = ToBeClassified;
    LookupPageId = ExtraPercentageForCuttingList;
    DrillDownPageId = ExtraPercentageForCuttingList;

    fields
    {
        field(1; "Start Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(2; "Finish Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(3; "Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(5; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }


    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
