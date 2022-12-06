page 51010 TableList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = TableMaster;
    CardPageId = TableCard;
    Caption = 'Cutting Table';
    SourceTableView = sorting("Table No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Table No."; Rec."Table No.")
                {
                    ApplicationArea = All;
                }

                field("Table Name"; Rec."Table Name")
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