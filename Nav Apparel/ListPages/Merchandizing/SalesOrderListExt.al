pageextension 51058 SalesOrderListExt extends "Sales Order List"
{
    layout
    {
        addlast(Control1)
        {
            field("Style Name"; Rec."Style Name")
            {
                ApplicationArea = ALL;
                Caption = 'Style';
            }

            field("PO No"; Rec."PO No")
            {
                ApplicationArea = ALL;
            }

            field(Lot; Rec.Lot)
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