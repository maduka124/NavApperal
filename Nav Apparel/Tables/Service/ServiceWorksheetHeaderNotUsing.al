
table 50732 ServiceWorksheetHeader   //Not using
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Created User"; Code[50])
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
