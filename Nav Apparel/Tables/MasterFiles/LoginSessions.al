
table 51145 LoginSessions
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Secondary UserID"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "SessionID"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Created DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Secondary UserID", SessionID)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created DateTime" := CurrentDateTime();
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}
