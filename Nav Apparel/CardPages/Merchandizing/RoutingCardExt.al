pageextension 50998 "RoutingCard Extension" extends Routing
{
    layout
    {
        addafter("Last Date Modified")
        {

            field("Sample Router"; rec."Sample Router")
            {
                ApplicationArea = All;
            }

            field("Bulk Router"; rec."Bulk Router")
            {
                ApplicationArea = All;
            }

            field("Washing Router"; rec."Washing Router")
            {
                ApplicationArea = All;
            }

            field("With Wash Router"; rec."With Wash Router")
            {
                ApplicationArea = All;
            }

            field("Without Wash Router"; rec."Without Wash Router")
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