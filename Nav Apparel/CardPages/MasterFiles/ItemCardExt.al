pageextension 71012736 ItemCardExt extends "Item Card"
{
    layout
    {
        addafter("Common Item No.")
        {
            group("Apperal Settings")
            {
                field("Sub Category Name"; "Sub Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sub Category';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        CategoryRec: Record "Sub Category";
                        MainCatRec: Record "Main Category";
                    begin
                        CategoryRec.Reset();
                        CategoryRec.SetRange("Sub Category Name", "Sub Category Name");
                        if CategoryRec.FindSet() then begin
                            "Sub Category No." := CategoryRec."No.";
                            "Main Category No." := CategoryRec."Main Category No.";
                            "Main Category Name" := CategoryRec."Main Category Name";

                            //Article
                            if ("Main Category Name" = 'SPAIR PARTS') or ("Main Category Name" = 'CHEMICAL')
                                or ("Main Category Name" = 'STATIONARY') or ("Main Category Name" = 'IT ACESSORIES')
                                or ("Main Category Name" = 'ELETRICAL') then
                                CaptionA := 'Brand'
                            else
                                CaptionA := 'Article';

                            //Size                            
                            if ("Main Category Name" = 'SPAIR PARTS') then
                                CaptionB := 'Type of Machine'
                            else
                                if ("Main Category Name" = 'CHEMICAL') then
                                    CaptionB := 'Chemical Type'
                                else
                                    CaptionB := 'Size';

                            //Color                            
                            if ("Main Category Name" = 'SPAIR PARTS') then
                                CaptionC := 'Model'
                            else
                                if ("Main Category Name" = 'CHEMICAL') then
                                    CaptionC := 'Batch'
                                else
                                    CaptionC := 'Color';

                            //remarks                            
                            if ("Main Category Name" = 'SPAIR PARTS') then
                                CaptionD := 'Part No'
                            else
                                if ("Main Category Name" = 'CHEMICAL') then
                                    CaptionD := 'Lot'
                                else
                                    CaptionD := 'Other';

                            MainCatRec.Reset();
                            MainCatRec.SetRange("No.", CategoryRec."Main Category No.");
                            if MainCatRec.FindSet() then begin
                                Validate("Gen. Prod. Posting Group", MainCatRec."Prod. Posting Group Code");
                                Validate("Inventory Posting Group", MainCatRec."Inv. Posting Group Code");
                            end;
                        end;
                    end;
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionC;

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                        ModelRec: Record Model;
                    begin

                        if ("Main Category Name" = 'SPAIR PARTS') then begin
                            ModelRec.Reset();
                            ModelRec.SetRange("Model Name", "Color Name");
                            if ModelRec.FindSet() then
                                "Color No." := ModelRec."No.";
                        end
                        else
                            if ("Main Category Name" = 'ELETRICAL') or ("Main Category Name" = 'STATIONARY') or ("Main Category Name" = 'IT ACESSORIES') then begin
                                ColourRec.Reset();
                                ColourRec.SetRange("Colour Name", "Color Name");
                                if ColourRec.FindSet() then
                                    "Color No." := ColourRec."No.";
                            end
                            else
                                if ("Main Category Name" = 'CHEMICAL') then begin

                                end
                                else begin
                                    ColourRec.Reset();
                                    ColourRec.SetRange("Colour Name", "Color Name");
                                    if ColourRec.FindSet() then
                                        "Color No." := ColourRec."No.";
                                end;
                    end;
                }

                field("Size Range No."; "Size Range No.")
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionB;

                    // trigger OnValidate()
                    // var
                    //     // ChemicalTypeRec: Record ChemicalType;
                    //     ServiceItemRec: Record "Service Item";
                    // begin
                    //     if ("Main Category Name" = 'SPAIR PARTS') then begin
                    //         ServiceItemRec.Reset();
                    //         ServiceItemRec.SetRange(Description, "Size Range No.");
                    //         if ServiceItemRec.FindSet() then
                    //             "Article No." := ServiceItemRec."No.";
                    //     end
                    //     else
                    //         if ("Main Category Name" = 'CHEMICAL') then begin
                    //             ChemicalTypeRec.Reset();
                    //             ChemicalTypeRec.SetRange("Chemical Type Name", "Size Range No.");
                    //             if ChemicalTypeRec.FindSet() then
                    //                 "Article No." := ChemicalTypeRec."No.";
                    //         end
                    // end;
                }

                field(Article; Article)
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionA;

                    trigger OnValidate()
                    var
                        ArticleRec: Record Article;
                        BrandRec: Record Brand;
                    begin
                        if ("Main Category Name" = 'SPAIR PARTS') or ("Main Category Name" = 'CHEMICAL')
                        or ("Main Category Name" = 'STATIONARY') or ("Main Category Name" = 'IT ACESSORIES')
                        or ("Main Category Name" = 'ELETRICAL') then begin
                            BrandRec.Reset();
                            BrandRec.SetRange("Brand Name", Article);
                            if BrandRec.FindSet() then
                                "Article No." := BrandRec."No.";
                        end
                        else begin
                            ArticleRec.Reset();
                            ArticleRec.SetRange(Article, Article);
                            if ArticleRec.FindSet() then
                                "Article No." := ArticleRec."No.";
                        end;
                    end;

                    // trigger OnValidate()
                    // var
                    //     ArticleRec: Record Article;
                    // begin
                    //     ArticleRec.Reset();
                    //     ArticleRec.SetRange(Article, Article);
                    //     if ArticleRec.FindSet() then
                    //         "Article No." := ArticleRec."No.";
                    // end;
                }


                field("Dimension Width"; "Dimension Width")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DimensionWidthRec: Record DimensionWidth;
                    begin
                        DimensionWidthRec.Reset();
                        DimensionWidthRec.SetRange("Dimension Width", "Dimension Width");
                        if DimensionWidthRec.FindSet() then
                            "Dimension Width No." := DimensionWidthRec."No.";
                    end;
                }


                // field("Type of Machine"; "Type of Machine")
                // {
                //     ApplicationArea = All;
                // }

                // field("Model Name"; "Model Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Model';

                //     trigger OnValidate()
                //     var
                //         ModelRec: Record Model;
                //     begin
                //         ModelRec.Reset();
                //         ModelRec.SetRange("Model Name", "Model Name");
                //         if ModelRec.FindSet() then
                //             "Model Code" := ModelRec."No.";
                //     end;
                // }

                // field("Brand Name"; "Brand Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Brand';

                //     trigger OnValidate()
                //     var
                //         BrandRec: Record Brand;
                //     begin
                //         BrandRec.Reset();
                //         BrandRec.SetRange("Brand Name", "Brand Name");
                //         if BrandRec.FindSet() then
                //             "Brand Code" := BrandRec."No.";
                //     end;
                // }

                // field("Part No"; "Part No")
                // {
                //     ApplicationArea = All;
                // }

                // field("Ref Page in Catelog"; "Ref Page in Catelog")
                // {
                //     ApplicationArea = All;
                // }

                // field("Chemical Type Name"; "Chemical Type Name")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Chemical Type';

                //     trigger OnValidate()
                //     var
                //         ChemicalTypeRec: Record "ChemicalType";
                //     begin
                //         ChemicalTypeRec.Reset();
                //         ChemicalTypeRec.SetRange("Chemical Type Name", "Chemical Type Name");
                //         if ChemicalTypeRec.FindSet() then
                //             "Chemical Type Code" := ChemicalTypeRec."No.";
                //     end;
                // }

                // field(Batch; Batch)
                // {
                //     ApplicationArea = All;
                // }

                // field(Lot; Lot)
                // {
                //     ApplicationArea = All;
                // }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                    CaptionClass = CaptionD;

                }

                field("EstimateBOM Item"; "EstimateBOM Item")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    var
        CaptionA: Text[100];
        CaptionB: Text[100];
        CaptionC: Text[100];
        CaptionD: Text[100];
}