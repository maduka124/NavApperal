page 50947 "Colour Card"
{
    PageType = Card;
    SourceTable = Colour;
    Caption = 'Colour';
    //Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Colour No';
                }

                field("Colour Name"; rec."Colour Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ColourRec: Record Colour;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                        AssoColorRec: Record AssortmentDetails;
                    begin
                        ColourRec.Reset();
                        ColourRec.SetRange("Colour Name", rec."Colour Name");
                        if ColourRec.FindSet() then
                            Error('Colour name already exists.');

                        if xRec."Colour Name" <> '' then begin
                            AssoColorRec.Reset();
                            AssoColorRec.SetRange("Colour Name", xRec."Colour Name");
                            if AssoColorRec.FindSet() then
                                Error('Colour Name already used. Cannot change it.');
                        end;

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