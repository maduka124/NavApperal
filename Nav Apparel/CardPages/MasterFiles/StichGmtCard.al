page 50972 "Stich Gmt Card"
{
    PageType = Card;
    SourceTable = "Stich Gmt";
    Caption = 'Stich Gmt';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Stich Gmt No';
                }

                field("Stich Gmt Name"; rec."Stich Gmt Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        StichGmtRec: Record "Stich Gmt";
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        StichGmtRec.Reset();
                        StichGmtRec.SetRange("Stich Gmt Name", rec."Stich Gmt Name");

                        if StichGmtRec.FindSet() then
                            Error('Stich Gmt Name already exists.');

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