page 51185 "Style Master Lookup"
{
    PageType = List;
    SourceTable = "Style Master";
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style No';
                }

                field("Style No."; Rec."Style No.")
                {
                    ApplicationArea = All;
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
        end;

    end;
}