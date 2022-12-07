page 50949 "Defects Card"
{
    PageType = Card;
    SourceTable = Defects;
    Caption = 'Defects';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Defects No';
                }

                field(Defects; rec.Defects)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        DefectsRec: Record Defects;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        DefectsRec.Reset();
                        DefectsRec.SetRange(Defects, rec.Defects);
                        if DefectsRec.FindSet() then
                            Error('Defects name already exists.');


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