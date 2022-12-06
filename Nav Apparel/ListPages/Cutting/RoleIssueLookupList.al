page 50826 RoleIssueLookupList
{
    PageType = List;
    Caption = 'Role Issue No Lookup List';
    SourceTable = RoleIssuingNoteHeader;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("RoleIssuNo."; Rec."RoleIssuNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Roll Issue No';
                }

                field("Req No."; Rec."Req No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Fab Req No';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
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