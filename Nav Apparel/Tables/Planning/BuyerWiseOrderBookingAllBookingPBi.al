
table 51178 BuyerWiseOdrBookingAllBookPBi1
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "MonthName"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "MonthNo"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Buyer Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Buyer Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        //Done By Sachith on 16/02/23
        field(9; "Brand No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        //Done By Sachith on 16/02/23
        field(10; "Brand Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Year, MonthName, "Buyer Name")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

}
