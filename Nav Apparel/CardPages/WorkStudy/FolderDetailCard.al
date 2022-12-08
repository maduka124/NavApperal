page 50620 "Folder Detail Card"
{
    PageType = Card;
    SourceTable = "Folder Detail";
    Caption = 'Folder Detail';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Folder Detail No';
                }

                field("Folder Name"; rec."Folder Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        FolderDetailRec: Record "Folder Detail";
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


                        FolderDetailRec.Reset();
                        FolderDetailRec.SetRange("Folder Name", rec."Folder Name");
                        if FolderDetailRec.FindSet() then
                            Error('Folder Name already exists.');
                    end;
                }
            }
        }
    }
}