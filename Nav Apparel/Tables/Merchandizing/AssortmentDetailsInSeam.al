
table 50885 AssortmentDetailsInseam
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

        field(71012583; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Com Size"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "InSeam"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "GMT Size"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012588; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Style No.", "Lot No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "GMT Size")
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
