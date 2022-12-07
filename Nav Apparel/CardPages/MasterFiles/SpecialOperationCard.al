page 50977 "Special Operation Card"
{
    PageType = Card;
    SourceTable = "Special Operation";
    Caption = 'Special Operation';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Special Operation No';
                }

                field("SpecialOperation Name"; rec."SpecialOperation Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SpecialOperationRec: Record "Special Operation";
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        SpecialOperationRec.Reset();
                        SpecialOperationRec.SetRange("SpecialOperation Name", rec."SpecialOperation Name");

                        if SpecialOperationRec.FindSet() then
                            Error('Special Operation Name already exists.');

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