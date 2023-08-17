
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
        field(26; "Target_Hour 01"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(27; "Target_Hour 02"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(28; "Target_Hour 03"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(29; "Target_Hour 04"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(30; "Target_Hour 05"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(31; "Target_Hour 06"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(32; "Target_Hour 07"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(33; "Target_Hour 08"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(34; "Target_Hour 09"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(35; "Target_Hour 10"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(36; "Target_Hour 11"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(37; "Target_Hour 12"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(38; "Target_Hour 13"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(39; "Target"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
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
