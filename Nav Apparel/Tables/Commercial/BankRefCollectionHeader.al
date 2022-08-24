
table 50767 BankRefCollectionHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "BankRefNo."; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Release Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Release Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Margin A/C Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Exchange Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Bank Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(7; "Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Currier Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "FC A/C Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Current A/C Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "BankRefNo.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "BankRefNo.", "Release Amount", "Margin A/C Amount", "Release Date", "Exchange Rate")
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
