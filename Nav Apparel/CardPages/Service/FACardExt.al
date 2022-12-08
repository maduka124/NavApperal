pageextension 50733 FACardExt extends "Fixed Asset Card"
{
    layout
    {
        addafter("Last Date Modified")
        {
            field("Machine category"; rec."Machine category")
            {
                ApplicationArea = All;
            }

            field("Model number"; rec."Model number")
            {
                ApplicationArea = All;
            }

            field("RPM/Machine type"; rec."RPM/Machine type")
            {
                ApplicationArea = All;
            }

            field("Motor number"; rec."Motor number")
            {
                ApplicationArea = All;
            }

            field("Features "; rec."Features ")
            {
                ApplicationArea = All;
            }
        }

        modify(Description)
        {
            trigger OnAfterValidate()
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
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end
                else begin   //logged in
                    rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                end;
            end;
        }

    }
}