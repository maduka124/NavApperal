
table 50620 FabricRequsitionLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "FabReqNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Layering Start Date/Time"; dateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Cut Start Date/Time"; dateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "FabReqNo.", "Line No")
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
