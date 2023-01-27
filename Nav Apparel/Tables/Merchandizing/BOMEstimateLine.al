
table 50893 "BOM Estimate Line"
{
    DataClassification = ToBeClassified;
    LookupPageId = "BOM Estimate Line List part";
    DrillDownPageId = "BOM Estimate Line List part";

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
            // TableRelation = Item.Description where("Main Category No." = field("Main Category No."), "EstimateBOM Item" = const(true));
            // ValidateTableRelation = false;
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

        // field(11; "Unit Name."; text[50])
        // {
        //     DataClassification = ToBeClassified;
        // }

        field(71012591; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Pcs,Doz;
            OptionCaption = 'Pcs,Doz,';
        }

        field(71012592; "Consumption"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 4;
        }

        field(71012593; "WST"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }

        field(71012594; "Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }

        field(71012595; "Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            DecimalPlaces = 0 : 4;
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

        field(71012603; "Master Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(71012604; "Master Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
        }

        field(71012605; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.", "Line No.")
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
