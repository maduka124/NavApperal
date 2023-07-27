table 51370 FactoryAndLineMachine2Line
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; Year; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; Month; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; Factory; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Machine type"; text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Machine Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "1"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "2"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "3"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "4"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "5"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "6"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "7"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "8"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "9"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "10"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "11"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "12"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "13"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "14"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "15"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "16"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "17"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "18"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "19"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "20"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "21"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "22"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "23"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "24"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "25"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "26"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "27"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "28"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "29"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "30"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "31"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Resourse No"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Resource Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(42; "Record TYpe"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Line No", Factory)
        {
            Clustered = true;
        }
    }
}