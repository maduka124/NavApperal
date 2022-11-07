
table 50533 "GITBaseonPILine"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "GITPINo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "PINo"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Main Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Main Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Main Category"."Main Category Name" where("Main Category Name" = filter(<> 'ALL CATEGORIES'), "Style Related" = filter(1));
            ValidateTableRelation = false;
        }

        field(6; "Item No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Item Name"; text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item.Description;
            ValidateTableRelation = false;
        }

        field(8; "Unit No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Unit Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Description;
            ValidateTableRelation = false;
        }

        field(10; "Unit Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Currency No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Currency Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency.Description;
            ValidateTableRelation = false;
        }

        field(13; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(14; "Total Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            DecimalPlaces = 4 :;
        }

        field(15; "GRN Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(16; "Rec. Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            DecimalPlaces = 4 :;
        }

        field(17; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Req Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

    }

    keys
    {
        key(PK; "GITPINo.", "Line No")
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
