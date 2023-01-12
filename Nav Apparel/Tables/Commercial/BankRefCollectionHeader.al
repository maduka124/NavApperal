
table 50767 BankRefCollectionHeader
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "BankRefNo."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = BankReferenceHeader."BankRefNo.";
            ValidateTableRelation = false;
        }

        field(2; "Exchange Rate"; Decimal)
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

        field(5; "Release Amount"; Decimal)
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

        field(9; "FC A/C Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "Current A/C Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Secondary UserID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(14; "Cash Receipt Bank No"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Cash Receipt Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(16; "Cash Receipt Bank Account No"; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."Bank Account No.";
            ValidateTableRelation = false;
        }

        field(17; "Journal Template"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Template"."Name";
        }

        field(18; "Journal Batch"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template"));
        }

        field(19; "Cash Rece. Updated"; Boolean)
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
        fieldgroup(DropDown; "BankRefNo.", "Release Amount", "Margin A/C Amount", "FC A/C Amount", "Current A/C Amount")
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
