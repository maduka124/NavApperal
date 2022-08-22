
table 50536 "GITPIPI"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "GITPINo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "PI No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "PI Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "PI Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Suppler No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "PI Sys No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "GITPINo.", "PI No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var

    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;


    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
