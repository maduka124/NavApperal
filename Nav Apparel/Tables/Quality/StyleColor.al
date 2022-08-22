
table 50562 "StyleColor"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Color No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Color"; text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Color No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Color No.", Color)
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
