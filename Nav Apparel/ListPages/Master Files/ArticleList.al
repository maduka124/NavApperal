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

    trigger OnAfterGetCurrRecord()
    var
        LoginRec: Page "Login Card";
        LoginDetailsRec: Record LoginDetails;
    begin

        LoginDetailsRec.Reset();
        LoginDetailsRec.SetRange(SessionID, SessionId());

        if not LoginDetailsRec.FindSet() then begin
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;

    end;
}