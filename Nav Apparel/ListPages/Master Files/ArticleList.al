page 50625 Article
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Article;
    CardPageId = "Article Card";
    // SourceTableView = sorting("No.") order(descending);
    SourceTableView = sorting("Main Category Name", Article) order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Article No';
                }

                field(Article; Rec.Article)
                {
                    ApplicationArea = All;
                }

                field("Main Category Name"; Rec."Main Category Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}