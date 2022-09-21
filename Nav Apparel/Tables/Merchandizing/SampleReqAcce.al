
table 71012717 "Sample Requsition Acce"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(71012581; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012582; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012583; "Item Name"; Text[200])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item.Description where("Main Category No." = field("Main Category No."), "EstimateBOM Item" = const(false));
            ValidateTableRelation = false;
        }

        field(71012584; "Main Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Main Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Main Category"."Main Category Name" where("Main Category Name" = filter(<> 'ALL CATEGORIES'));
            ValidateTableRelation = false;
        }

        field(71012586; "Article No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012587; "Article Name."; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Article.Article where("Main Category No." = field("Main Category No."));
            ValidateTableRelation = false;
        }

        field(71012588; "Dimension No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012589; "Dimension Name."; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = DimensionWidth."Dimension Width" where("Main Category No." = field("Main Category No."));
            ValidateTableRelation = false;
        }

        field(71012590; "Unit N0."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }

        field(71012591; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pcs;
            OptionCaption = 'Pcs';
        }

        field(71012592; "Consumption"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 1 : 5;
        }

        field(71012593; "WST"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012594; "Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012595; "Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

        field(71012596; "Supplier No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012597; "Supplier Name."; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Main Category Vendor"."Vendor Name" where("No." = field("Main Category No."));
            ValidateTableRelation = false;
        }

        field(71012598; "Requirment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012599; "AjstReq"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(71012600; "Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012601; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012602; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012609; "Placement of GMT"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012610; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012611; "GMT Color No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012612; "GMT Color Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Colour."Colour Name";
            ValidateTableRelation = false;
        }

        field(71012613; "Item Color No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012614; "Item Color Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Colour."Colour Name";
            ValidateTableRelation = false;
        }

        field(71012615; "GMT Size Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012622; "Production BOM No."; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012623; "Sub Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012624; "Sub Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sub Category"."Sub Category Name";
            ValidateTableRelation = false;
        }

        field(71012627; "Remarks"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012628; "Si"; text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Item No.", "Line No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    begin
        "Created Date" := WorkDate();
        "Created User" := UserId;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
