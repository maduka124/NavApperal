page 50417 "Upload Document Type Card"
{
    PageType = Card;
    SourceTable = "Upload Document Type";
    Caption = 'Upload Document Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Doc No."; rec."Doc No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type No';
                }

                field("Doc Name"; rec."Doc Name")
                {
                    ApplicationArea = All;
                    Caption = 'Document Type';

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
            }
        }
    }
}