page 71012739 "Login Card"
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
        LoginDetails1: Record LoginDetails;
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
                LoginDetails1.Reset();
                LoginDetails1.SetRange(SessionID, SessionId());
                if LoginDetails1.FindSet() then
                    LoginDetails1.ModifyAll(SessionID, 0);

                //Update new session id
                LoginDetails.SessionID := SessionId();
                LoginDetails.LastLoginDateTime := CurrentDateTime;
                LoginDetails.Modify();
            end;
    end;

    var
        UseridPara: Text[20];
        PwPara: text[50];
}