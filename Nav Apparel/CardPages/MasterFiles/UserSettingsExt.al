pageextension 51421 UserSettingsExt extends "User Settings"
{

    layout
    {

    }
    trigger OnAfterGetCurrRecord()
    var
    begin
        if (UserId <> 'SSDEVELOPER') and (UserId <> 'SOLUTIONUSER') and (UserId <> 'SOFTSERVE') and (UserId <> 'SUPPORT1') then begin
            Error('User Settings has not set up for the this user');
        end;
    end;

}