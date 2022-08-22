
table 71012804 LoginDetails
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "UserID Secondary"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "User Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "SessionID"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Pw"; Code[50])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }

        field(6; "LastLoginDateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Active"; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = true;
        }

        field(8; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "UserID Secondary")
        {
            Clustered = true;
        }
    }

    // fieldgroups
    // {
    //     fieldgroup(DropDown; "No.", Article, "Main Category Name")
    //     {

    //     }
    // }

    trigger OnInsert()
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
