page 50943 "AQL Card"
{
    PageType = Card;
    SourceTable = AQL;
    Caption = 'AQL';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("From Qty"; rec."From Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        //Check whether user logged in or not
                        LoginSessionsRec.Reset();
                        LoginSessionsRec.SetRange(SessionID, SessionId());

                        if not LoginSessionsRec.FindSet() then begin  //not logged in
                            Clear(LoginRec);
                            LoginRec.LookupMode(true);
                            LoginRec.RunModal();

                            LoginSessionsRec.Reset();
                            LoginSessionsRec.SetRange(SessionID, SessionId());
                            if LoginSessionsRec.FindSet() then
                                rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end
                        else begin   //logged in
                            rec."Secondary UserID" := LoginSessionsRec."Secondary UserID";
                        end;
                    end;
                }

                field("To Qty"; rec."To Qty")
                {
                    ApplicationArea = All;
                }

                field("SMPL Qty"; rec."SMPL Qty")
                {
                    ApplicationArea = All;
                }

                field("Reject Qty"; rec."Reject Qty")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}