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
                    begin
                        CategoryRec.Reset();
                        CategoryRec.SetRange("Sub Category Name", "Sub Category Name");
                        if CategoryRec.FindSet() then begin
                            "Sub Category No." := CategoryRec."No.";
                            "Main Category No." := CategoryRec."Main Category No.";
                            "Main Category Name" := CategoryRec."Main Category Name";
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
                    Caption = 'Color';

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                    begin
                        ColourRec.Reset();
                        ColourRec.SetRange("Colour Name", "Color Name");
                        if ColourRec.FindSet() then
                            "Color No." := ColourRec."No.";
                    end;
                }

                field("Size Range No."; "Size Range No.")
                {
                    ApplicationArea = All;
                    Caption = 'Size Range';
                }

                field(Article; Article)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ArticleRec: Record Article;
                    begin
                        ArticleRec.Reset();
                        ArticleRec.SetRange(Article, Article);
                        if ArticleRec.FindSet() then
                            "Article No." := ArticleRec."No.";
                    end;
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

                field("EstimateBOM Item"; "EstimateBOM Item")
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}