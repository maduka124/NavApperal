
table 51356 "PIPODetails1"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "PI No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; Qty; BigInteger)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }

        field(71012584; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "Select"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "PO Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;
        }
        field(71012588; "Buy-from Vendor No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(71012589; "Assigned PI No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012590; Status; Enum "Purchase Document Status")
        {
            DataClassification = ToBeClassified;
        }
        field(71012591; "Line No"; BigInteger)
        {
            DataClassification = ToBeClassified;
        }
        field(71012592; "Merchandizer Group Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(71012593; "Proforma Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(71012594; "Amount Including VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }




    }

    keys
    {
        key(PK; "Line No", "PO No.")
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
