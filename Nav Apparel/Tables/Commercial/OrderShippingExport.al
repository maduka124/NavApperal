table 51323 "Order Shipping Export"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Invoice No"; Code[20])
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
        field(6; "BL No"; Code[20])
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
        field(22; "Margin Acc"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(23; "FC Acc"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(24; "Currant Account"; Text[100])
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

    }

    keys
    {
        key(Key1; SeqNo)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;


}