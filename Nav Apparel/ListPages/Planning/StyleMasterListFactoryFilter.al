page 51224 NavAppPlanLineFilter
{
    PageType = List;
    SourceTable = "NavApp Planning Lines";
    SourceTableView = sorting("Style No.", "Lot No.", "Line No.") order(ascending);
    Caption = 'Planned Style Filter';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                Editable = false;

                field("Style No."; Rec."Style No.")
                {
                    ApplicationArea = All;
                    Caption = 'Style No';
                }

                field("Style Name"; Rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style Name';
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