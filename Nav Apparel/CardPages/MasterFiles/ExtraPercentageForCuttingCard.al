page 51394 ExtraPercentageForCuttingCard
{
    PageType = Card;
    SourceTable = ExtraPercentageForCutting;
    Caption = 'Qty Wise Extra % For Cutting';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Start Qty"; rec."Start Qty")
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

                field("Finish Qty"; rec."Finish Qty")
                {
                    ApplicationArea = All;
                }

                field(Percentage; rec.Percentage)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}