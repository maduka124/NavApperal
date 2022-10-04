tableextension 50656 WashingBOMLineExt extends "Production BOM Line"
{
    fields
    {
        field(46; Step; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "WashingStep".Description;
            ValidateTableRelation = false;
        }

        field(47; "Water(L)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(48; "Temperature"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(49; Time; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50; "Weight(Kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(60; "Remark"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(61; "Main Category Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(62; "Main Category Name"; text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Main Category"."Main Category Name";
            ValidateTableRelation = false;
        }

        modify("No.")
        {
            TableRelation = if ("Main Category Name" = filter('CHEMICAL')) Item where("Main Category No." = field("Main Category Code"))
            else
            Item;

            
        }
        
    }
}