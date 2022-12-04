
table 50871 SAH_MerchGRPWiseBalance
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "JAN"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "FEB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "MAR"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "APR"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "MAY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "JUN"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "JUL"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "AUG"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "SEP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "OCT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "NOV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "DEC"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "JAN_Utilized"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "FEB_Utilized"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "MAR_Utilized"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "APR_Utilized"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "MAY_Utilized"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "JUN_Utilized"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "JUL_Utilized"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "AUG_Utilized"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "SEP_Utilized"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(23; "OCT_Utilized"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(24; "NOV_Utilized"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(25; "DEC_Utilized"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(26; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(28; "Group Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(29; "Group Head"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(30; "Group Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Year, "Group Id")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Year, "Group Name")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
