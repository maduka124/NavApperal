
table 51203 BankRefDistribution
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

        field(3; "Document No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Description"; text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(6; "Debit Bank Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
            ValidateTableRelation = false;
        }

        field(7; "Debit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Credit Bank Account No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No.";
            ValidateTableRelation = false;
        }

        field(9; "Credit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Transferred To Gen. Jrnl."; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Payment Posted"; Boolean)
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
}
