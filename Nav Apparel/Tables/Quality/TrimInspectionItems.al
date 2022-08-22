
table 50574 "TrimInspectionLine"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "PurchRecNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "StyleNo"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "StyleName"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "BPCD"; date)
        {
            DataClassification = ToBeClassified;
            //TableRelation = Item."No.";
        }

        field(6; "Main Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Main Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Item No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Item Name"; text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item.Description;
            ValidateTableRelation = false;
        }

        field(10; "Color No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Color Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Colour."Colour Name";
            ValidateTableRelation = false;
        }

        field(12; "Size"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "ArticleNo"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "DimensionNo"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Unit No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Unit Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
            ValidateTableRelation = false;
        }

        field(17; "GRN Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(18; "Sample Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(19; "Accept"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(20; "Reject"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            //DecimalPlaces = 4 :;
        }

        field(21; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Blank,Pass,Fail;
            OptionCaption = 'Blank,Pass,Fail';
        }

        field(22; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Show"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Article"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(26; "Dimension"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "RejectLevel"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "PurchRecNo.", "Line No")
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
