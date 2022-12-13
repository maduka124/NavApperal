
table 50552 SupplierPayments
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Suppler Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "January"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "February"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "March"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "April"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(7; "May"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "June"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "July"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "August"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "September"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "October"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "November"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "December"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Suppler No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }


    }

    keys
    {
        key(PK; Year, "Suppler Name")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var

    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
