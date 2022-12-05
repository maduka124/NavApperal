
table 51081 "Gate Pass Line"
{
    DataClassification = ToBeClassified;

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
            if ("Inventory Type" = CONST("Inventory")) Item.Description where("Main Category No." = field("Main Category Code"))
            else
            if ("Inventory Type" = CONST("Fixed Assets")) "Fixed Asset".Description where("FA Class Code" = field("Main Category Code"))
            else
            if ("Inventory Type" = const("Service Machine")) "Service Item"."Item Description" where("Service Item Group Code" = field("Main Category Code"));

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

        field(71012589; "Inventory Type"; Enum "Inventory Type")
        {
            DataClassification = ToBeClassified;
        }

        field(71012590; "Main Category Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012591; "Main Category Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation =
            if ("Inventory Type" = CONST("Inventory")) "Main Category"."Main Category Name"
            else
            if ("Inventory Type" = CONST("Fixed Assets")) "FA Class".Name
            else
            if ("Inventory Type" = const("Service Machine")) "Service Item Group".Code;

            ValidateTableRelation = false;
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
