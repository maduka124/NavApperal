page 50970 "Shade Card"
{
    PageType = Card;
    SourceTable = Shade;
    Caption = 'Shade/LOT';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Shade No';
                }

                field(Shade; rec.Shade)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ShadeRec: Record Shade;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        ShadeRec.Reset();
                        ShadeRec.SetRange(Shade, rec.Shade);

                        if ShadeRec.FindSet() then
                            Error('Shade Name already exists.');

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