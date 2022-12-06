pageextension 50640 LocationListExt extends "Location List"
{
    layout
    {
        addlast(Control1)
        {
            field("Plant Type Name"; Rec."Plant Type Name")
            {
                ApplicationArea = ALL;
            }

            field("Sewing Unit"; Rec."Sewing Unit")
            {
                ApplicationArea = ALL;
            }

            field("Start Time"; Rec."Start Time")
            {
                ApplicationArea = ALL;
            }

            field("Finish Time"; Rec."Finish Time")
            {
                ApplicationArea = ALL;
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