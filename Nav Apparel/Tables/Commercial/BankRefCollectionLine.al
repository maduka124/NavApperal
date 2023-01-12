
table 50768 BankRefCollectionLine
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "BankRefNo."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "LineNo."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Reference Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "AirwayBillNo"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Airway Bill Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Exchange Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Release Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Margin A/C Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Release Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Bank Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Currier Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(14; "FC A/C Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Current A/C Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Invoice No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(20; "Invoice Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Transferred To Cash Receipt"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Payment Posted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "BankRefNo.", "LineNo.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "BankRefNo.", "Invoice No", "Invoice Date", "Invoice Amount", "Release Amount", "Margin A/C Amount", "Release Date", "Exchange Rate")
        {

        }
    }


    trigger OnInsert()
    var
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;
}
