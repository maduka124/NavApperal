tableextension 50795 "Component Line Extension" extends "Prod. Order Component"
{
    fields
    {
        field(71012581; "Quantity In Stock"; Decimal)
        {
        }

        field(50100; "Item Cat. Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = ToBeClassified;
            TableRelation = "Item Category";
        }
        field(50101; "Invent. Posting Group"; Code[20])
        {
            Caption = 'Inventory Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Inventory Posting Group";
        }
        field(50102; "Transfer Order Created"; Boolean)
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

