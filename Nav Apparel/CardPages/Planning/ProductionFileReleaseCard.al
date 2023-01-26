page 51221 ProductionFileReleaseCard
{
    PageType = Card;
    SourceTable = ProductionFileReleaseHeader;
    Caption = 'Production File Release';
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(" ")
            {
            }

            group("Style / PO Plan Details")
            {
                part(ProductionFileReleaseListPart; ProductionFileReleaseListPart)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
    begin
        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            LoginSessionsRec.Reset();
            LoginSessionsRec.SetRange(SessionID, SessionId());
            LoginSessionsRec.FindSet();
        end;

        if not rec.get() then begin
            rec.INIT();
            rec."Release No." := '1';
            rec.INSERT();
        end;
    end;
}