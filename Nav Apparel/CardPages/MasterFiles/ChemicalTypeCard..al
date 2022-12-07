page 50946 "Chemical Type Card"
{
    PageType = Card;
    SourceTable = ChemicalType;
    Caption = 'Chemical Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Chemical Type No';
                }

                field("Chemical Type Name"; rec."Chemical Type Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        ChemicalTypeRec: Record ChemicalType;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        ChemicalTypeRec.Reset();
                        ChemicalTypeRec.SetRange("Chemical Type Name", rec."Chemical Type Name");
                        if ChemicalTypeRec.FindSet() then
                            Error('Chemical Type name already exists.');

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