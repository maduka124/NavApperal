page 51011 "User List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = LoginDetails;
    CardPageId = "Create User Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field("UserID Secondary"; Rec."Secondary UserID")
                {
                    ApplicationArea = All;
                    Caption = 'Secondary UserID';
                }

                field("User Name"; Rec."User Name")
                {
                    ApplicationArea = All;
                }

                // field(SessionID; Rec.SessionID)
                // {
                //     ApplicationArea = All;
                // }

                field(LastLoginDateTime; Rec.LastLoginDateTime)
                {
                    ApplicationArea = All;
                    Caption = 'Last Login Date Time';
                }

                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
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