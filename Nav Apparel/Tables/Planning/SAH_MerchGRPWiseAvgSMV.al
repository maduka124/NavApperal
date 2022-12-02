
table 50872 SAH_MerchGRPWiseAvgSMV
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

        field(14; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Group Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Group Head"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Group Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Year, "Group Name")
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