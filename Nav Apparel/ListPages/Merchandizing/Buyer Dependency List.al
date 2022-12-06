page 51035 "Buyer Dependency List"
{
    PageType = ListPart;
    SourceTable = "Dependency Buyer";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Dependency No."; rec."Dependency No.")
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }

                field(Dependency; rec.Dependency)
                {
                    ApplicationArea = All;
                    Caption = 'Dependency';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

    end;
}