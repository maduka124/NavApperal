table 50106 "General Issue Line"
{
    Caption = 'General Issue Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Main Category"; Code[20])
        {
            Caption = 'Main Category';
            DataClassification = ToBeClassified;
            TableRelation = "Main Category" where("General Issuing" = const(true));
            trigger OnValidate()
            var
                MainCatRec: Record "Main Category";
            begin
                MainCatRec.Get("Main Category");
                "Main Category Name" := MainCatRec."Main Category Name";
            end;
        }
        field(4; "Item Code"; Code[20])
        {
            Caption = 'Item Code';
            DataClassification = ToBeClassified;
            TableRelation = Item where("Main Category No." = field("Main Category"));
            // ValidateTableRelation = false;
            trigger OnValidate()
            var
                ItemRec: Record Item;
                FromProdHedd: Record "Production Order";
            begin
                if "Item Code" <> '' then
                    ItemRec.Get("Item Code");
                Description := ItemRec.Description;
                "Unit of Measure" := ItemRec."Base Unit of Measure";
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Unit of Measure"; Code[20])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(7; "Main Category Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Location Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(9; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        //Added by Maduka on 9/1/2023
        field(10; "Quantity In Stock"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
