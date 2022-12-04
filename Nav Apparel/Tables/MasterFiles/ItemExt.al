tableextension 51098 "Item Extension" extends Item
{
    fields
    {
        field(71012581; "Sub Category No."; Code[20])
        {
        }

        field(71012582; "Sub Category Name"; Text[50])
        {
            TableRelation = "Sub Category"."Sub Category Name" where("Main Category No." = field("Main Category No."));
            ValidateTableRelation = false;
        }

        field(71012583; "Main Category No."; Code[20])
        {
        }

        field(71012584; "Main Category Name"; Text[50])
        {
            TableRelation = "Main Category"."Main Category Name" where("Main Category Name" = filter(<> 'ALL CATEGORIES'));
            ValidateTableRelation = false;
        }

        field(71012585; "Color No."; Code[20])
        {
        }

        field(71012586; "Color Name"; Text[50])
        {
            TableRelation = if ("Main Category Name" = filter('SPAIR PARTS'))
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

            // TableRelation = Colour."Colour Name";
            // ValidateTableRelation = false;
        }

        field(71012587; "Size Range No."; code[20])
        {
            TableRelation = if ("Main Category Name" = filter('SPAIR PARTS'))
                    "Service Item".Description
            else
            if ("Main Category Name" = filter('CHEMICAL'))
                    ChemicalType."Chemical Type Name";
            // else
            // Article.Article;

            ValidateTableRelation = false;
        }

        field(71012588; "Article No."; code[20])
        {
        }

        field(71012589; "Article"; text[100])
        {
            //TableRelation = Article.Article;
            // ValidateTableRelation = false;

            TableRelation = if ("Main Category Name" = filter('SPAIR PARTS'))
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

        field(71012590; "Dimension Width No."; code[20])
        {
        }

        field(71012591; "Dimension Width"; text[100])
        {
            //     TableRelation = if ("Main Category Name" = filter('SPAIR PARTS'))
            //    else
            //     if ("Main Category Name" = filter('CHEMICAL'))
            //             Brand."Brand Name"
            //     else
            //     if ("Main Category Name" = filter('STATIONARY'))
            //             Brand."Brand Name"
            //     else
            //     if ("Main Category Name" = filter('IT ACESSORIES'))
            //             Brand."Brand Name"
            //     else
            //     if ("Main Category Name" = filter('ELETRICAL'))
            //             Brand."Brand Name"
            //     else
            //     DimensionWidth."Dimension Width";

            //     ValidateTableRelation = false;

            TableRelation = DimensionWidth."Dimension Width" where("Main Category No." = field("Main Category No."));
            ValidateTableRelation = false;
        }

        field(71012592; "Remarks"; Text[100])
        {
        }

        field(71012593; "EstimateBOM Item"; Boolean)
        {
        }

        // field(71012594; "Type of Machine"; Code[100])
        // {
        // }

        // field(71012595; "Model Code"; Code[20])
        // {
        // }

        // field(71012596; "Model Name"; text[100])
        // {
        //     TableRelation = Model."Model Name";
        //     ValidateTableRelation = false;
        // }

        // field(71012597; "Brand Code"; Code[20])
        // {

        // }

        // field(71012598; "Brand Name"; text[100])
        // {
        //     TableRelation = Brand."Brand Name";
        //     ValidateTableRelation = false;
        // }

        // field(71012599; "Part No"; Code[100])
        // {
        // }

        // field(71012600; "Ref Page in Catelog"; Code[100])
        // {
        // }

        // field(71012601; "Chemical Type Code"; Code[20])
        // {
        // }


        // field(71012602; "Chemical Type Name"; text[100])
        // {
        //     TableRelation = ChemicalType."Chemical Type Name";
        //     ValidateTableRelation = false;
        // }

        // field(71012603; "Batch"; Code[100])
        // {
        // }

        // field(71012604; "Lot"; Code[100])
        // {
        // }
    }

    trigger OnBeforeDelete()
    var
        BOMestRec: Record "BOM Estimate Line";
    begin
        //Check for Exsistance
        BOMestRec.Reset();
        BOMestRec.SetRange("Item No.", "No.");
        if BOMestRec.FindSet() then
            Error('Item : %1 already used in operations. Cannot delete.', Description);

    end;
}

