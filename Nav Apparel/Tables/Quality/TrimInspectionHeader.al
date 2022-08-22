
table 50578 TrimInspectionHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "GRN No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Suppler No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Suppler Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "GRN Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Trim Inspected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "GRN No.")
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
