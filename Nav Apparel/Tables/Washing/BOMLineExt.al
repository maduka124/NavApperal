tableextension 50656 WashingBOMLineExt extends "Production BOM Line"
{
    fields
    {
        field(50001; Step; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "WashingStep".Description;
            ValidateTableRelation = false;
        }

        field(50002; "Water(L)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50003; "Temperature"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50004; Time; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50005; "Weight(Kg)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50006; "Remark"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(50007; "Main Category Code"; code[50])
        {
            DataClassification = ToBeClassified;
        }

        field(50008; "Main Category Name"; text[100])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Main Category"."Main Category Name";
            // ValidateTableRelation = false;         

            trigger OnValidate()
            var
                MainCategoryRec: Record "Main Category";
            begin
                MainCategoryRec.Reset();
                MainCategoryRec.SetRange("Main Category Name", rec."Main Category Name");
                if MainCategoryRec.FindSet() then
                    "Main Category Code" := MainCategoryRec."No.";
            end;
        }

        field(50009; "Item No Washing"; code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "Item Name Washing"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        // modify("No.")
        // {
        //     TableRelation = if ("Main Category Name" = filter('CHEMICAL')) Item where("Main Category Name" = filter('CHEMICAL'))
        //     else
        //     Item;


        // }

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                MainCatRec: Record "Main Category";
            begin
                if Type = Type::Item then begin
                    if "Main Category Code" <> '' then begin
                        MainCatRec.Get("Main Category Code");
                        MainCatRec.TestField("Routing Link Code");
                        Validate("Routing Link Code", MainCatRec."Routing Link Code");
                    end;
                end;
            end;
        }

    }
}