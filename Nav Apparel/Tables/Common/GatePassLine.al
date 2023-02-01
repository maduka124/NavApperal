
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
            if ("Inventory Type" = const("Service Machine")) "Service Item".Description
            else
            if ("Inventory Type" = const("Finish Goods")) Item.Description where("Replenishment System" = filter("Prod. Order"))
            else
            if ("Inventory Type" = const(Sample)) "Sample Type"."Sample Type Name";

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
            if ("Inventory Type" = CONST("Fixed Assets")) "FA Class".Name;

            ValidateTableRelation = false;
        }

        field(71012592; "Sample Type No"; Code[20])
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
