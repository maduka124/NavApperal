tableextension 50795 "Component Line Extension" extends "Prod. Order Component"
{
    fields
    {
        field(50001; "Quantity In Stock"; Decimal)
        {
        }

        field(50002; "Item Cat. Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
        }
        field(50003; "Invent. Posting Group"; Code[20])
        {
            Caption = 'Inventory Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Inventory Posting Group";
        }
        field(50004; "Transfer Order Created"; Boolean)
        {
            DataClassification = ToBeClassified;
            // Editable = false;
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                ItemRec: Record Item;
            begin
                if "Item No." <> '' then
                    ItemRec.Get("Item No.");
                "Item Cat. Code" := ItemRec."Item Category Code";
                "Invent. Posting Group" := ItemRec."Inventory Posting Group";
            end;
        }
    }
}

