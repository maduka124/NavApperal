page 50430 "Sample Room Card"
{
    PageType = Card;
    SourceTable = "Sample Room";
    Caption = 'Sample Room';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Sample Room No."; rec."Sample Room No.")
                {
                    ApplicationArea = All;
                    Caption = 'Sample Room No';
                }

                field("Sample Room Name"; rec."Sample Room Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SampleRoomRec: Record "Sample Room";
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



                        SampleRoomRec.Reset();
                        SampleRoomRec.SetRange("Sample Room Name", rec."Sample Room Name");
                        if SampleRoomRec.FindSet() then
                            Error('Sample Room name already exists.');
                    end;
                }

                field("Global Dimension Code"; rec."Global Dimension Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}