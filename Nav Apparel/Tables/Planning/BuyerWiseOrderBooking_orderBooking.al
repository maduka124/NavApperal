
table 51163 BuyerWiseOdrBooking_OdrBooking
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

        field(3; "Factory Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Factory Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Buyer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Buyer Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "JAN"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "FEB"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "MAR"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "APR"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "MAY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "JUN"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "JUL"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "AUG"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "SEP"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "OCT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(17; "NOV"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "DEC"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Year, "Factory Name")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
