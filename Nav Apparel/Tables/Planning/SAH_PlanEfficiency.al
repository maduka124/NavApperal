
table 50863 SAH_PlanEfficiency
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "JAN"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        
        field(3; "FEB"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "MAR"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "APR"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "MAY"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "JUN"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "JUL"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "AUG"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "SEP"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "OCT"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "NOV"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "DEC"; Code[20])
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
