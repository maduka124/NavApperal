pageextension 50807 ServiceItemListExt extends "Service Item List"
{
    layout
    {
        addafter("Customer No.")
        {
            field(Brand; rec.Brand)
            {
                ApplicationArea = ALL;
            }

            field(Model; rec.Model)
            {
                ApplicationArea = ALL;
            }

            field("Purchase Year"; rec."Purchase Year")
            {
                ApplicationArea = ALL;
            }

            field(Factory; rec.Factory)
            {
                ApplicationArea = ALL;
            }

            field(Location; rec.Location)
            {
                ApplicationArea = All;
            }

            field("Machine Category"; rec."Machine Category")
            {
                ApplicationArea = All;
            }

            field(Ownership; rec.Ownership)
            {
                ApplicationArea = All;
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