table 51323 "Order Shipping Export"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Invoice No"; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(4; "No of CTN"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "CBM"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(6; "BL No"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(7; "BL Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Doc Sub Buyer Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Doc Sub Bank Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Exp No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(11; "Exp Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(12; Destination; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(13; "Bank Ref"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(14; "DHL No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(15; "DHL Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(16; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(17; "Realise Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(18; "Realise Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(19; "Exchange Rate"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(20; "Sundry Acc"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(21; Remarks; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Margin Acc"; Integer)    //Not using
        {
            DataClassification = ToBeClassified;
        }
        field(23; "FC Acc"; Integer)       //Not using
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Currant Ac Amount"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Excess/Short"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(26; Diff; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(27; "No of Stlye"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(28; "Lc Fty"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(29; Nbcmcsh; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(30; Nbcmlc; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(31; Bsub; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(32; CMRGP; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(33; Cgrphd; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(34; "SeqNo"; BigInteger)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(35; "Contract Lc No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(36; Season; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(37; Buyer; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Buyer No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Style Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Po No"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Po Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(43; "Order value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Ship Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Ship Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Ship value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Commission"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Discount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Ex FTY Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51; Mode; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sea,Air,"Sea-Air","Air-Sea","By Road";
            OptionCaption = 'Sea,Air,"Sea-Air","Air-Sea","By Road"';
        }
        field(52; "Bank Ref Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(53; "No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(54; "Currant Ac Amount1"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(55; "No of CTN1"; Decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(56; "Currant Account"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(57; "Order Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }

        field(58; "Factory Invoice No"; Code[35])
        {
            DataClassification = ToBeClassified;
        }

        field(59; "Margin Acc New"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(60; "FC Acc New"; Decimal)
        {
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(PK; SeqNo)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;


}