
table 50873 SAH_MerchGRPWiseSAHUsed
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No"; bigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Month No"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Month Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Group Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Group Head"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Group Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Allocated Lines"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Allocated SAH"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Used SAH"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Difference Hrs"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Avg SMV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Capacity Pcs"; bigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Booked Pcs"; bigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Difference Pcs"; bigInteger)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; No)
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
}
