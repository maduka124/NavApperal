
table 50773 "StyleMaster_StyleMasterPO_T"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Style_No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "No"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "BPCD"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Lot_No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "PONo"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sea,Air,"Sea-Air","Air-Sea","By Road";
            OptionCaption = 'Sea,Air,"Sea-Air","Air-Sea","By Road"';
        }

        field(9; "Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "ShipDate"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "SID"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "UnitPrice"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Confirm,Projection,"Projection Confirm";
            OptionCaption = 'Confirm,Projection,Projection Confirm';
        }

        field(14; "ConfirmDate"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "PlannedStatus"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Buyer"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Production File Handover Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        //Done By sachith on 27/03/23
        field(18; Brand; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        //Done By sachith on 27/03/23
        field(19; "Sewing Out Qty"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        //Done By sachith on 27/03/23
        field(20; Amount; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(21; PlannedQty; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(22; OutputQty; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No", Lot_No)
        {
            Clustered = true;
        }
    }

}
