page 50965 "Pack Card"
{
    PageType = Card;
    SourceTable = Pack;
    Caption = 'Pack';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Pack No';
                }

                field(Pack; rec.Pack)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        PackRec: Record Pack;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        PackRec.Reset();
                        PackRec.SetRange(Pack, rec.Pack);
                        if PackRec.FindSet() then
                            Error('Pack already exists.');

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
            }
        }
    }
}