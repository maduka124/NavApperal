page 51041 "Dependency"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Dependency;
    CardPageId = "Dependency Card";
    SourceTableView = sorting("No.") order(descending);
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Buyer No."; rec."Buyer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field(Dependency; rec.Dependency)
                {
                    ApplicationArea = All;
                    Caption = 'Dependency Group Name';
                }
            }
        }
    }


    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UserSetupRec: Record "User Setup";
    begin
        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();
        end;


        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);

        if UserSetupRec.FindSet() then begin
            if UserSetupRec."Merchandizer Group Name" = '' then
                Error('Merchandizer Group Name has not set up for the user : %1', UserId)
            else
                rec.SetFilter("Merchandizer Group Name", '=%1', UserSetupRec."Merchandizer Group Name")
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
            if rec."Merchandizer Group Name" <> '' then begin
                if rec."Merchandizer Group Name" <> UserSetupRec."Merchandizer Group Name" then
                    Error('You are not authorized to view other Merchandizer Group information.');
            end;
        end;
    end;
}