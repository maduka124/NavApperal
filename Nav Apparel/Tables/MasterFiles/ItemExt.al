tableextension 71012614 "Item Extension" extends Item
{
    fields
    {
        field(71012581; "Sub Category No."; Code[20])
        {
        }

        field(71012582; "Sub Category Name"; Text[50])
        {
            TableRelation = "Sub Category"."Sub Category Name";
            ValidateTableRelation = false;
        }

        field(71012583; "Main Category No."; Code[20])
        {
        }

        field(71012584; "Main Category Name"; Text[50])
        {
        }

        field(71012585; "Color No."; Code[20])
        {
        }

        field(71012586; "Color Name"; Text[50])
        {
            TableRelation = Colour."Colour Name";
            ValidateTableRelation = false;
        }

        field(71012587; "Size Range No."; code[20])
        {
        }

        field(71012588; "Article No."; code[20])
        {
        }

        field(71012589; "Article"; text[100])
        {
            TableRelation = Article.Article;
            ValidateTableRelation = false;
        }

        field(71012590; "Dimension Width No."; code[20])
        {
        }

        field(71012591; "Dimension Width"; text[100])
        {
            TableRelation = DimensionWidth."Dimension Width";
            ValidateTableRelation = false;
        }

        field(71012592; "Remarks"; Text[100])
        {
        }

        field(71012593; "EstimateBOM Item"; Boolean)
        {
        }
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

