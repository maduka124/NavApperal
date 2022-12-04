
table 50548 AcceptanceLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50001; "AccNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50002; "Line No"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "PI No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50004; "Inv No"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50005; "Item No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50006; "Item Name"; text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item.Description;
            ValidateTableRelation = false;
        }

        field(50007; "Unit No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50008; "Unit Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
            ValidateTableRelation = false;
        }

        field(50009; "Color"; Code[50])
        {
            DataClassification = ToBeClassified;
        }


        field(50010; "Size"; Code[50])
        {
            DataClassification = ToBeClassified;
        }


        field(50011; "Article "; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50012; "Dimension"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50013; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50014; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            DecimalPlaces = 4 :;
        }

        field(50015; "Total Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            DecimalPlaces = 4 :;
        }

        field(50016; "GRN Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(50017; "Rec. Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
            DecimalPlaces = 4 :;
        }

        field(50018; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50019; "Created Date"; Date)
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
