
table 50592 SewingJobCreationLine3
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "SJCNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Lot No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Style Master PO"."Lot No." where("Style No." = field("Style No."));
        }

        field(5; "SubLotNo."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "1"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "2"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "3"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "4"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "5"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "6"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "7"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "8"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "9"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "10"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "11"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "12"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "13"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(21; "14"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "15"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "16"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(24; "17"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(25; "18"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(26; "19"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "20"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(28; "21"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(29; "22"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(30; "23"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(31; "24"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(32; "25"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(33; "26"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(34; "27"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(35; "28"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(36; "29"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(37; "30"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(38; "31"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(39; "32"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(40; "33"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(41; "34"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(42; "35"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(43; "36"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(44; "37"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(45; "38"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(46; "39"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(47; "40"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(48; "41"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(49; "42"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50; "43"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(51; "44"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(52; "45"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(53; "46"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(54; "47"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(55; "48"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(56; "49"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(57; "50"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "51"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "52"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "53"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "54"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "55"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "56"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(64; "57"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "58"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "59"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "60"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "61"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "62"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "63"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(71; "64"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(72; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(73; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(74; "Color Total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(77; "Country Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(78; "Country Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(79; "Colour No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(80; "Colour Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = AssorColorSizeRatio."Colour Name" where("Style No." = field("Style No."), "Lot No." = field("Lot No."));
            ValidateTableRelation = false;
        }

        field(81; "Record Type"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(82; "ShipDate"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(83; "LineNo"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(84; "Resource No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(85; "Resource Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "Work Center"."No." where("Work Center Group Code" = filter('PAL'));
            TableRelation = "NavApp Planning Lines"."Resource Name" where("Style No." = field("Style No."), "Lot No." = field("Lot No."));
            ValidateTableRelation = false;
        }

    }

    keys
    {
        key(PK; "SJCNo.", "Style No.", "lot No.", LineNo)
        {
            Clustered = true;
        }
    }


    fieldgroups
    {
        fieldgroup(DropDown; "lot No.", "SubLotNo.", "Resource No.", "Colour Name", Qty)
        {

        }
    }


    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;   
}
