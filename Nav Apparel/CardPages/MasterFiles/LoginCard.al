page 50959 "Login Card"
{
    PageType = Card;
    Caption = 'Login';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(UseridPara; UseridPara)
                {
                    ApplicationArea = All;
                    Caption = 'User Name';

                    trigger OnValidate()
                    var
                        LoginDetails: Record LoginDetails;
                    begin
                        LoginDetails.Reset();
                        LoginDetails.SetRange("UserID Secondary", UseridPara);

                        if not LoginDetails.FindSet() then
                            Error('Invalid User Name');
                    end;
                }

                field(PwPara; PwPara)
                {
                    ApplicationArea = All;
                    Caption = 'Password';
                    ExtendedDatatype = Masked;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        LoginDetails: Record LoginDetails;
        LoginSessionDetails: Record LoginSessions;
    begin

        if UseridPara = '' then
            Error('Invalid Username');

        if PwPara = '' then
            Error('Invalid Password');

        LoginDetails.Reset();
        LoginDetails.SetRange("UserID Secondary", UseridPara);
        LoginDetails.SetRange(Pw, PwPara);

        if not LoginDetails.FindSet() then
            Error('Invalid User Name or Password')
        else
            if LoginDetails.Active = false then
                Error('Inactive User. Cannot login.')
            else begin

                //Clear if session number already exists
                if IsSessionActive(SessionId()) then begin

                    //Delete old session data for the user
                    LoginSessionDetails.Reset();
                    LoginSessionDetails.SetRange("Secondary UserID", UseridPara);
                    LoginSessionDetails.SetFilter("Created Date", '<%1', WorkDate());
                    if LoginSessionDetails.FindSet() then
                        LoginSessionDetails.DeleteAll();

                    //Check for duplicate sessonid in other users
                    LoginSessionDetails.Reset();
                    LoginSessionDetails.SetFilter("Secondary UserID", '<>%1', UseridPara);
                    LoginSessionDetails.SetRange(SessionID, SessionId());
                    if LoginSessionDetails.FindSet() then
                        LoginSessionDetails.DeleteAll();

                    //Check sessionid record already exists
                    LoginSessionDetails.Reset();
                    LoginSessionDetails.SetRange("Secondary UserID", UseridPara);
                    LoginSessionDetails.SetRange(SessionID, SessionId());
                    if not LoginSessionDetails.FindSet() then begin

                        LoginSessionDetails.Init();
                        LoginSessionDetails."Created Date" := WorkDate();
                        LoginSessionDetails."Created DateTime" := CurrentDateTime;
                        LoginSessionDetails."Created User" := UserId;
                        LoginSessionDetails."Secondary UserID" := UseridPara;
                        LoginSessionDetails.SessionID := SessionId();
                        LoginSessionDetails.Insert();

                    end;

                    //Update last login time of the user
                    LoginDetails.Reset();
                    LoginDetails.SetRange("UserID Secondary", UseridPara);
                    if LoginDetails.FindSet() then begin
                        LoginDetails.LastLoginDateTime := CurrentDateTime;
                        LoginSessionDetails.Modify();
                    end;

                end
                else
                    Error('Invalid session ID. Close the browser and login again.');

            end;
    end;

    var
        UseridPara: Text[20];
        PwPara: text[50];
}