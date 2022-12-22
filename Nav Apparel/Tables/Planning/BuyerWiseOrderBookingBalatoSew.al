
table 51168 BuyerWiseOrderBookinBalatoSew
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

        field(3; "Buyer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Buyer Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }

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

        field(18; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Buyer Name")
        {
            Clustered = true;
        }

        key(SK; "Buyer Name")
        {

        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Year, "Buyer Name")
        {

        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
