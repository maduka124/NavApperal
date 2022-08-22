
table 50602 GroupMaster
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Group ID"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Group ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(Dropdown; "Group ID", "Style Name")
        {

        }
    }

    trigger OnInsert()
    begin

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
