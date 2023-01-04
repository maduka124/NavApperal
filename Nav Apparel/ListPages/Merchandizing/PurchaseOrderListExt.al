pageextension 51151 PurchasOrderListExt extends "Purchase Order List"
{

    trigger OnOpenPage()
    var
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
        UserSetupRec: Record "User Setup";
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


        // UserSetup.Get(UserId);
        // if UserSetup."Global Dimension Code" <> '' then
        //     rec.SetRange("Shortcut Dimension 1 Code", UserSetup."Global Dimension Code");

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if UserSetupRec.FindSet() then begin

            if UserSetupRec."Global Dimension Code" <> '' then
                rec.SetRange("Shortcut Dimension 1 Code", UserSetupRec."Global Dimension Code");

            if UserSetupRec."Merchandizer All Group" = false then begin
                if UserSetupRec."Merchandizer Group Name" = '' then
                    Error('Merchandiser Group Name has not set up for the user : %1', UserId)
                else
                    rec.SetFilter("Merchandizer Group Name", '=%1', UserSetupRec."Merchandizer Group Name");
            end
        end
        else
            Error('Cannot find user details in user setup table');

    end;


    trigger OnAfterGetRecord()
    var
        UserSetupRec: Record "User Setup";
    begin
        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);

        if UserSetupRec.FindSet() then begin
            if UserSetupRec."Merchandizer All Group" = false then begin
                if rec."Merchandizer Group Name" <> '' then begin
                    if rec."Merchandizer Group Name" <> UserSetupRec."Merchandizer Group Name" then
                        Error('You are not authorized to view other Merchandiser Group information.');
                END;
            END;
        end;
    end;
}