table 50820 DeptReqSheetLine
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Req No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            // AutoIncrement = true;
        }

        field(3; "Item No"; Code[60])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item."No." where("EstimateBOM Item" = filter(false), "Main Category No." = field("Main Category No."));
            ValidateTableRelation = false;
        }

        field(4; "Item Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Qty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "UOM"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Unit of Measure".Description;
            // ValidateTableRelation = false;
        }

        field(7; "Remarks"; text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(8; "Qty Received"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(9; "Qty to Received"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(10; "PO Raized"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(11; "Type of Machine"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(12; "Model Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(13; "Model Name"; text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Model."Model Name";
            ValidateTableRelation = false;
        }

        field(14; "Brand Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(15; "Brand Name"; text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Brand."Brand Name";
            ValidateTableRelation = false;
        }

        field(16; "Part No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(17; "Ref Page in Catelog"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(18; "Chemical Type Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(19; "Chemical Type Name"; text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = ChemicalType."Chemical Type Name";
            ValidateTableRelation = false;
        }

        field(20; "Batch"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(21; "Lot"; Code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(22; "Main Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(23; "Main Category Name"; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Main Category"."Main Category Name" where("Main Category Name" = filter(<> 'ALL CATEGORIES'));
            ValidateTableRelation = false;
        }

        field(24; "Article No."; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(25; "Article"; text[100])
        {
            DataClassification = ToBeClassified;

            TableRelation = if ("Main Category Name" = filter('SPAIR PARTS'))
                    Brand."Brand Name"
            else
            if ("Main Category Name" = filter('SPARE PARTS'))
                    Brand."Brand Name"
            else
            if ("Main Category Name" = filter('CHEMICAL'))
                    Brand."Brand Name"
            else
            if ("Main Category Name" = filter('STATIONARY'))
                    Brand."Brand Name"
            else
            if ("Main Category Name" = filter('IT ACESSORIES'))
                    Brand."Brand Name"
            else
            if ("Main Category Name" = filter('ELETRICAL'))
                    Brand."Brand Name"
            else
            Article.Article where("Main Category No." = field("Main Category No."));

            ValidateTableRelation = false;
        }

        field(26; "Dimension No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(27; "Dimension Name."; text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = DimensionWidth."Dimension Width" where("Main Category No." = field("Main Category No."));
            ValidateTableRelation = false;
        }

        field(28; "Color No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(29; "Color Name"; Text[50])
        {
            DataClassification = ToBeClassified;

            TableRelation = if ("Main Category Name" = filter('SPAIR PARTS'))
                    Model."Model Name"
            else
            if ("Main Category Name" = filter('SPARE PARTS'))
                    Model."Model Name"
            else
            if ("Main Category Name" = filter('STATIONARY'))
                    Colour."Colour Name"
            else
            if ("Main Category Name" = filter('IT ACESSORIES'))
                    Colour."Colour Name"
            else
            if ("Main Category Name" = filter('ELETRICAL'))
                    Colour."Colour Name"
            else
            if ("Main Category Name" = filter('CHEMICAL'))
                    Batch.Batch
            else
            Colour."Colour Name";

            ValidateTableRelation = false;
        }

        field(30; "Size Range No."; code[250])
        {
            DataClassification = ToBeClassified;

            TableRelation = if ("Main Category Name" = filter('SPAIR PARTS'))
                    "Service Item".Description
            else
            if ("Main Category Name" = filter('SPARE PARTS'))
                    "Service Item".Description
            else
            if ("Main Category Name" = filter('CHEMICAL'))
                    ChemicalType."Chemical Type Name";

            ValidateTableRelation = false;
        }

        field(31; "Other"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(32; "Sub Category No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(33; "Sub Category Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sub Category"."Sub Category Name" where("Main Category No." = field("Main Category No."));
            ValidateTableRelation = false;
        }

        field(34; "UOM Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure".Code;
        }
    }

    keys
    {
        key(PK; "Req No", "Line No")
        {
            Clustered = true;
        }
    }


    trigger OnDelete()
    var
    begin
        if "Qty Received" > 0 then
            Error('Cannot delete the Item as Qty already received.');

        if "PO Raized" then
            Error('Cannot delete the Item as PO already created by the central purchasing department.');
    end;
}