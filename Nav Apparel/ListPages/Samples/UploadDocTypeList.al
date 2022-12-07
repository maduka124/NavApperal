page 50416 "Upload Document Type"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Upload Document Type";
    CardPageId = "Upload Document Type Card";
    SourceTableView = sorting("Doc No.") order(descending);


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Doc No."; rec."Doc No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type No';
                }

                field("Doc Name"; rec."Doc Name")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type Name';
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