page 71012584 Article
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Article;
    CardPageId = "Article Card";
    // SourceTableView = sorting("No.") order(descending);
    SourceTableView = sorting("No.", Article, "Main Category Name") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Article No';
                }

                field(Article; Article)
                {
                    ApplicationArea = All;
                }

                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}