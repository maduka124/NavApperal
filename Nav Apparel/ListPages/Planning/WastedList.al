page 50369 "Wastage"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Wastage;
    CardPageId = "Wastage Card";
    Caption = 'Quantity Wise Extra %';
    //SourceTableView = sorting("Start Qty") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Start Qty"; rec."Start Qty")
                {
                    ApplicationArea = All;
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