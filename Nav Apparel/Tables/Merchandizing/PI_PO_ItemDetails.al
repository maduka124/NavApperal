
table 71012712 "PI Po Item Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "PI No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Item Name"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "UOM Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; UOM; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; Qty; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012588; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012589; "Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            DecimalPlaces = 4 :;
        }

        field(71012590; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012592; "Main Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012593; "Main Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; "PI No.", "PO No.", "Item No.")
        {
            Clustered = true;
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
