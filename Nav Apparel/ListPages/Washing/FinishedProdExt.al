pageextension 51160 FinishedProdExt extends "Finished Production Orders"
{
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
        end;

    end;
}