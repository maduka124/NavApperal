
table 50886 AssortmentDetails
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Type"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Colour No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Colour."No.";
        }

        field(71012586; "Colour Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Country Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Country Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region".Name;
            ValidateTableRelation = false;
        }

        field(71012590; "SID/REF No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Pack No"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "Pack"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Pack.Pack;
            ValidateTableRelation = false;
        }

        field(71012593; "No Pack"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012594; "Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Ratio,Solid;
            OptionCaption = 'Ratio,Solid';
        }

        field(71012595; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012596; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012597; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Style No.", "Lot No.", Type, "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Colour Name")
        {

        }
    }

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
