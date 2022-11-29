
table 50863 SAH_PlanEfficiency
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "JAN"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "FEB"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "MAR"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "APR"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "MAY"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "JUN"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "JUL"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "AUG"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "SEP"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "OCT"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "NOV"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "DEC"; decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Year)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Year)
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
