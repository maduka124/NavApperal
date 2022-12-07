page 50974 "TableCard"
{
    PageType = Card;
    SourceTable = TableMaster;
    Caption = 'Cutting Tables';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Table No."; rec."Table No.")
                {
                    ApplicationArea = All;
                    Caption = 'Table No';
                }

                field("Table Name"; rec."Table Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        TableMasterRec: Record TableMaster;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        TableMasterRec.Reset();
                        TableMasterRec.SetRange("Table Name", rec."Table Name");

                        if TableMasterRec.FindSet() then
                            Error('Table Name already exists.');

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