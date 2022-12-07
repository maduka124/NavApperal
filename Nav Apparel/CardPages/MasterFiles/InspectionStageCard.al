page 50956 "Inspection Stage Card"
{
    PageType = Card;
    SourceTable = InspectionStage;
    Caption = 'Inspection Stage';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Inspection Stage No';
                }

                field("Inspection Stage"; rec."Inspection Stage")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        InspectionStageRec: Record InspectionStage;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        InspectionStageRec.Reset();
                        InspectionStageRec.SetRange("Inspection Stage", rec."Inspection Stage");
                        if InspectionStageRec.FindSet() then
                            Error('Inspection Stage already exists.');

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