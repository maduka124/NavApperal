table 51160 AwaitingPOs
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Contract No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Amount Including VAT"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Purchase Line"."Amount Including VAT" WHERE("Document No." = FIELD("PO No")));
            FieldClass = FlowField;
        }

        field(4; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        // field(5; "Style No"; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        // }

        // field(6; "Style Name"; Text[100])
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(7; "Buy-from Vendor Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "PO No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Buy-from Vendor No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Pk1; "Contract No", "PO No")
        {
            Clustered = true;
        }
    }
}