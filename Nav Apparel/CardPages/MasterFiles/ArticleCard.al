page 50944 "Article Card"
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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Article No';
                }

                field("Main Category No."; rec."Main Category No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Main Category"."No." where("Main Category Name" = filter(<> 'ALL CATEGORIES'));
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        MainCategoryRec.get(rec."Main Category No.");
                        rec."Main Category Name" := MainCategoryRec."Main Category Name";


                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;
                    end;
                }

                field("Main Category Name"; rec."Main Category Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field(Article; rec.Article)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ArticleRec: Record Article;
                    begin
                        ArticleRec.Reset();
                        ArticleRec.SetRange(Article, rec.Article);
                        if ArticleRec.FindSet() then
                            Error('Article name already exists.');
                    end;
                }
            }
        }
    }
}