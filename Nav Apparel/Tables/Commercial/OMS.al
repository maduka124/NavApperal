table 51327 OMS
{
    DataClassification = ToBeClassified;

    fields
    {
        // field(1; No; Code[20])
        // {
        //     DataClassification = ToBeClassified;

        // }
        field(2; "Lc Contract No"; Text[35])
        {
            DataClassification = ToBeClassified;

        }
        field(3; Store; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(4; Season; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(5; Brand; text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(6; Department; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(7; Buyer; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(8; "Style No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(9; "Style Des"; Text[100])
        {
            DataClassification = ToBeClassified;

        }
        field(10; "Order Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(11; Lot; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(12; "PO No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(13; Mode; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sea,Air,"Sea-Air","Air-Sea","By Road";
            OptionCaption = 'Sea,Air,"Sea-Air","Air-Sea","By Road"';

        }
        field(14; "Po Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(15; "Cut Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(16; "EMB OUT"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(17; "EMB IN"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(18; "Print IN"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(19; "Print OUT"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(20; "Line IN"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(21; "Line OUT"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(22; "Wash IN"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(23; "Wash OUT"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(24; "Poly OUT"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(25; "Ship Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(26; "Ship Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(27; "FOB"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(28; "EXP QTY"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(29; "EX Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(30; "EX Short"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(31; "Ship Value"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(32; "Comm Cash"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(33; "Comm Lc"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(34; "Seq No"; BigInteger)
        {
            DataClassification = ToBeClassified;

        }
        field(35; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(36; Factory; Code[20])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "Seq No")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;


}