table 50104 "Style Transfer Line"
{
    Caption = 'Style Transfer Line';
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
            TableRelation = "Main Category";
            trigger OnValidate()
            var
                MainCatRec: Record "Main Category";
                StyleHed: Record "Style transfer Header";
            begin
                MainCatRec.Get("Main Category");
                "Main Category Name" := MainCatRec."Main Category Name";

                StyleHed.Get("Document No.");
                "From Prod. Order No." := StyleHed."From Prod. Order No.";
                "To Prod. Order No." := StyleHed."To Prod. Order No.";
            end;
        }
        field(4; "Item Code"; Code[20])
        {
            Caption = 'Item Code';
            DataClassification = ToBeClassified;
            TableRelation = "Prod. Order Component"."Item No." where("Item Cat. Code" = field("Main Category"), "Prod. Order No." = field("From Prod. Order No."));
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                ItemLeRec: Record "Item Journal Line";
                ItemRec: Record Item;
                FromProdHedd: Record "Production Order";
                PositiveTotal: Decimal;
                NegativeTotal: Decimal;
                ItemQty: Decimal;
            begin
                ItemQty := 0;

                if "Item Code" <> '' then
                    ItemRec.Get("Item Code");
                Description := ItemRec.Description;
                "Unit of Measure" := ItemRec."Base Unit of Measure";

                // FromProdHedd.Get(FromProdHedd.Status::Released, "From Prod. Order No.");
                ItemRec.Reset();
                ItemRec.SetRange("No.", "Item Code");
                ItemRec.SetFilter("Global Dimension 1 Filter", FromProdHedd."Shortcut Dimension 1 Code");
                ItemRec.SetFilter("Location Filter", FromProdHedd."Location Code");
                if ItemRec.FindFirst() then begin
                    ItemRec.CalcFields(Inventory);
                    // "Available Inventory" := ItemRec.Inventory;
                    ItemQty := ItemRec.Inventory;
                end;

                // "Available Inventory" := 0;
                // NegativeTotal := 0;
                // ItemLeRec.Reset();
                // ItemLeRec.SetRange("Item No.", "Item Code");
                // // ItemLeRec.SetRange("Journal Template Name", 'ITEM');
                // // ItemLeRec.SetRange("Journal Batch Name", 'DEFAULT');
                // ItemLeRec.SetRange("Entry Type", ItemLeRec."Entry Type"::"Negative Adjmt.");
                // if ItemLeRec.FindSet() then begin
                //     ItemLeRec.CalcSums(Quantity);
                //     NegativeTotal := ItemLeRec.Quantity;
                // end;

                PositiveTotal := 0;
                ItemLeRec.Reset();
                ItemLeRec.SetRange("Item No.", "Item Code");
                // ItemLeRec.SetFilter("Journal Template Name", '<>%1', 'ITEM');
                // ItemLeRec.SetFilter("Journal Batch Name", '<>%1', 'DEFAULT');
                ItemLeRec.SetFilter("Document No.", '<>%1', "Document No.");
                ItemLeRec.SetFilter("Entry Type", '<>%1', ItemLeRec."Entry Type"::"Negative Adjmt.");
                ItemLeRec.SetFilter("Entry Type", '<>%1', ItemLeRec."Entry Type"::"Positive Adjmt.");
                if ItemLeRec.FindSet() then begin
                    ItemLeRec.CalcSums(Quantity);
                    PositiveTotal := ItemLeRec.Quantity;
                end;

                // "Available Inventory" := PositiveTotal - (NegativeTotal * -1);
                "Available Inventory" := ItemQty - (NegativeTotal * -1);
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Required Quantity"; Decimal)
        {
            Caption = 'Required Quantity';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ItemLeRec: Record "Item Ledger Entry";
                PositiveTotal: Decimal;
            begin
                ItemLeRec.Reset();
                ItemLeRec.SetRange("Item No.", "Item Code");
                ItemLeRec.SetFilter("Document No.", '<>%1', "Document No.");
                ItemLeRec.SetFilter("Entry Type", '<>%1', ItemLeRec."Entry Type"::"Negative Adjmt.");
                ItemLeRec.SetFilter("Entry Type", '<>%1', ItemLeRec."Entry Type"::"Positive Adjmt.");
                if ItemLeRec.FindSet() then begin
                    ItemLeRec.CalcSums(Quantity);
                    PositiveTotal := ItemLeRec.Quantity;
                end;

                if Rec."Required Quantity" > PositiveTotal then
                    Error('Required total higher than the available total');
            end;
        }
        field(7; "Unit of Measure"; Code[20])
        {
            Caption = 'Unit of Measure';
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(8; "Main Category Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "From Prod. Order No."; Code[20])
        {
            Caption = 'From Prod. Order No.';
            DataClassification = ToBeClassified;
            TableRelation = "Production Order"."No." where(Status = filter(Released));
        }
        field(10; "To Prod. Order No."; Code[20])
        {
            Caption = 'From Prod. Order No.';
            DataClassification = ToBeClassified;
            TableRelation = "Production Order"."No." where(Status = filter(Released));
        }
        field(11; "Available Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
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
