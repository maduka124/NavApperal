page 71012585 "Article Card"
{
    PageType = Card;
    SourceTable = Article;
    Caption = 'Article';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Article No';
                }

                field("Main Category No."; "Main Category No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Main Category"."No." where("Main Category Name" = filter(<> 'All Categories'));
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.get("Main Category No.");
                        "Main Category Name" := MainCategoryRec."Main Category Name";
                    end;
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Visible = false;
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
                            Error('Article name already exists.');
                    end;
                }
            }
        }
    }
}