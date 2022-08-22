
table 50548 AcceptanceLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "AccNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "PI No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Inv No"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Item No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Item Name"; text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item.Description;
            ValidateTableRelation = false;
        }

        field(7; "Unit No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Unit Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
            ValidateTableRelation = false;
        }

        field(9; "Color"; Code[50])
        {
            DataClassification = ToBeClassified;
        }


        field(10; "Size"; Code[50])
        {
            DataClassification = ToBeClassified;
        }


        field(11; "Article "; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Dimension"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            DecimalPlaces = 4 :;
        }

        field(15; "Total Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            DecimalPlaces = 4 :;
        }

        field(16; "GRN Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(17; "Rec. Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            DecimalPlaces = 4 :;
        }

        field(18; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "AccNo.", "Line No")
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
