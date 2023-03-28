
table 50514 "Hourly Production Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Prod Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Factory No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sewing,Finishing;
            OptionCaption = 'Sewing,Finishing';
        }

        field(5; "Work Center No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Work Center"."No.";
        }

        field(6; "Work Center Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Item"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Hour 01"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(9; "Hour 02"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(10; "Hour 03"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(11; "Hour 04"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(12; "Hour 05"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(13; "Hour 06"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(14; "Hour 07"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(15; "Hour 08"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(16; "Hour 09"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(17; "Hour 10"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(18; "Hour 11"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(19; "Hour 12"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(20; "Hour 13"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(21; "Total"; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(22; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(24; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Work Center Seq No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Line No.")
        {
            Clustered = true;
        }
        key(SK; "Work Center Seq No")
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
