
table 51172 BuyerWiseOrderBookinGRWiseBook
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; BigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        // field(3; "Buyer Name"; Text[100])
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(4; "Buyer Code"; code[50])
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(5; "JAN"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "FEB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "MAR"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "APR"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "MAY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "JUN"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "JUL"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "AUG"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "SEP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "OCT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "NOV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "DEC"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Total"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "JAN_FOB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "FEB_FOB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "MAR_FOB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "APR_FOB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "MAY_FOB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(23; "JUN_FOB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(24; "JUL_FOB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(25; "AUG_FOB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(26; "SEP_FOB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(27; "OCT_FOB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(28; "NOV_FOB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(29; "DEC_FOB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Total_FOB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(31; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(32; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(33; "Group Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(34; "Group Head"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(35; "Group Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(36; "Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        //Done By Sachith on 16/02/23
        field(37; "Brand No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        //Done By Sachith on 16/02/23
        field(38; "Brand Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Group Name")
        {
            Clustered = true;
        }

        key(SK; "Group Name")
        {

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Year, "Group Name")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
