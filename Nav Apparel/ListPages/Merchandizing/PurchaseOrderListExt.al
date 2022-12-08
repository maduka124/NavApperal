pageextension 51151 PurchasOrderListExt extends "Purchase Order List"
{

    trigger OnOpenPage()
    var
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
        UserSetup: Record "User Setup";
    begin
        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;


        UserSetup.Get(UserId);
        if UserSetup."Global Dimension Code" <> '' then
            rec.SetRange("Shortcut Dimension 1 Code", UserSetup."Global Dimension Code");

    end;
}