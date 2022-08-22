
table 50349 ProductionOutHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(2; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Cut,Saw,Wash,Emb,Print,Ship,Fin;
            OptionCaption = 'Cut,Saw,Wash,Emb,Print,Ship,Fin';
        }

        field(3; "Prod Date"; Date)
        {
            DataClassification = ToBeClassified;
            //InitValue := WorkDate();
        }

        field(4; "Resource No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Resource Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Work Center".Name where("Work Center Group Code" = const('PAL'));
            ValidateTableRelation = false;
        }

        field(6; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "PO No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Output Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(10; "Input Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(11; "Ref Line No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Prod Updated"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(13; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Out Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Out Style Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "OUT PO No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Out Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
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
