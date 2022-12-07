page 50966 "Plant Type Card"
{
    PageType = Card;
    SourceTable = "Plant Type";
    Caption = 'Plant Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Plant Type No."; rec."Plant Type No.")
                {
                    ApplicationArea = All;
                    Caption = 'Plant Type No';
                }

                field("Plant Type Name"; rec."Plant Type Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        PlantTypeRec: Record "Plant Type";
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        PlantTypeRec.Reset();
                        PlantTypeRec.SetRange("Plant Type Name", rec."Plant Type Name");
                        if PlantTypeRec.FindSet() then
                            Error('Plant Type Name already exists.');

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