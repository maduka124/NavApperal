pageextension 50999 SalesOrderCardExt extends "Sales Order"
{
    layout
    {
        addafter("Work Description")
        {

            field("Style Name"; rec."Style Name")
            {
                ApplicationArea = All;

                trigger OnValidate()
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

            field("PO No"; rec."PO No")
            {
                ApplicationArea = All;
            }

            field(Lot; rec.Lot)
            {
                ApplicationArea = All;
            }


        }

        modify("Order Date")
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

        modify("Posting Date")
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

        modify("Due Date")
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