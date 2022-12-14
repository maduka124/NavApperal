
table 50897 "BOM Line Estimate"
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
            TableRelation = Item.Description where("Main Category No." = field("Main Category No."), "EstimateBOM Item" = filter(true));
            ValidateTableRelation = false;
            
        }

        field(71012584; "Main Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012585; "Main Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Main Category"."Main Category Name" where("Main Category Name" = filter(<> 'ALL CATEGORIES'), "Style Related" = filter(1));
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
            OptionMembers = Doz,Pcs;
            OptionCaption = 'Doz,Pcs';
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

        field(710126001; "Created User"; Code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(710126002; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(71012603; "Stock Bal"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012604; "Size Sensitive"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012605; "Color Sensitive"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012606; "Country Sensitive"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012607; "PO Sensitive"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(71012608; "Reconfirm"; Boolean)
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

        field(71012611; "GMT Qty"; Integer)
        {
            DataClassification = ToBeClassified;
        }

        field(71012612; "Included in PO"; Boolean)
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

}
