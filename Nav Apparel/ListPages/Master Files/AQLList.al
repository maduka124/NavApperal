page 50624 "AQL"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = AQL;
    CardPageId = "AQL Card";
    //SourceTableView = sorting("From Qty") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("From Qty"; Rec."From Qty")
                {
                    ApplicationArea = All;
                }

                field("To Qty"; Rec."To Qty")
                {
                    ApplicationArea = All;
                }

                field("SMPL Qty"; Rec."SMPL Qty")
                {
                    ApplicationArea = All;
                }

                field("Reject Qty"; Rec."Reject Qty")
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