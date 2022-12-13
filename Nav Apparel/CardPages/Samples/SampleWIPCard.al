page 50426 "Sample WIP Card"
{
    PageType = Card;
    SourceTable = WIP;
    Caption = 'Sample WIP';
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            group(" ")
            {
            }

            group("Sample Request")
            {
                part("Sample Request Header ListPart"; "Sample Request Header ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                }
            }

            group("Sample Request Details")
            {
                part("SampleReqLineListPartWIP"; SampleReqLineListPartWIP)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("Req No.");
                }
            }

            group("Style Documents")
            {
                part(SampleReqDocListPartWIP; SampleReqDocListPartWIP)
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("Req No.");
                }
            }
        }
    }



    trigger OnOpenPage()
    var
        LoginSessionsRec: Record LoginSessions;
        LoginRec: Page "Login Card";
    begin
        if not rec.get() then begin

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
            end;

            rec.INIT();
            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
            rec.INSERT();
        end;
    end;
}