
table 71012829 "Gate Pass Line"
{
    DataClassification = ToBeClassified;
    // LookupPageId = "Gate Pass List";
    // DrillDownPageId = "Gate Pass List";

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Seq No"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(71012583; "Item No."; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012584; "Description"; Text[200])
        {
            DataClassification = ToBeClassified;

            TableRelation =
            if ("Consignment Type" = CONST("Inventory")) Item.Description
            else
            if ("Consignment Type" = CONST("Fixed Assets")) "Fixed Asset".Description;

            ValidateTableRelation = false;
        }

        field(71012585; Qty; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012586; "UOM Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "UOM"; text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Description;
            ValidateTableRelation = false;
        }

        field(71012588; "Remarks"; text[200])
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Consignment Type"; Enum "Consignment Type")
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "No.", "Seq No")
        {
            Clustered = true;
        }
    }
}
