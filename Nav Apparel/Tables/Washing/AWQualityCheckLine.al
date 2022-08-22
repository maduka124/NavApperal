table 50689 AWQualityCheckLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Sample Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(4; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Fail","Pass";
            OptionCaption = 'Fail,Pass';
        }

        field(5; Qty; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(6; Defect; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Defects.Defects;
            ValidateTableRelation = false;
        }

        field(7; Comment; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(8; State; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Line No. Header"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Split No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(pk; No, "Line No. Header", "Line No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}