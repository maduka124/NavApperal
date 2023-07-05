table 51348 CapacityDashboardHeader
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No"; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = YearTable.Year;
        }

        field(3; "Month Name"; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = MonthTable."Month Name";
        }

        field(4; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        // field(7; "Factory"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = Location.Code where("Sewing Unit" = filter(1));
        // }
    }

    keys
    {
        key(PK; No)
        {
            Clustered = true;
        }

        key(SK; Year)
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}