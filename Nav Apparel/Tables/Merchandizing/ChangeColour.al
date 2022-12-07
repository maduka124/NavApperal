
table 50899 "Change Colour"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(71012582; "From Colour No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "From Colour Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = AssortmentDetails."Colour Name" where("Style No." = field("Style No."), "Lot No." = field("Lot No."));
            ValidateTableRelation = false;
        }

        field(71012584; "To Colour No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "To Colour Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Colour."Colour Name";
            ValidateTableRelation = false;
        }

        field(71012586; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "From Colour Name", "To Colour Name")
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
