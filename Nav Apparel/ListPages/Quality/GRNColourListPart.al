page 50672 GRNColourListPart
{
    PageType = List;
    Caption = 'Colour List';
    SourceTable = "Purch. Rcpt. Line";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Colour No"; rec."Color No.")
                {
                    ApplicationArea = All;
                }

                field("Colour Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Editable = false;
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