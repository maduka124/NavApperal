page 50967 "Print Type Card"
{
    PageType = Card;
    SourceTable = "Print Type";
    Caption = 'Print Type';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Print Type No';
                }

                field("Print Type Name"; rec."Print Type Name")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        PrintTypeRec: Record "Print Type";
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        PrintTypeRec.Reset();
                        PrintTypeRec.SetRange("Print Type Name", rec."Print Type Name");

                        if PrintTypeRec.FindSet() then
                            Error('Print Type Name already exists.');

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