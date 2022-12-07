page 50963 "Model Card"
{
    PageType = Card;
    SourceTable = Model;
    Caption = 'Model';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Model No';
                }

                field("Model Name"; rec."Model Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ModelRec: Record Model;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        ModelRec.Reset();
                        ModelRec.SetRange("Model Name", rec."Model Name");
                        if ModelRec.FindSet() then
                            Error('Model name already exists.');

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