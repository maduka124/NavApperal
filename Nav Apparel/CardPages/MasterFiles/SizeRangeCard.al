page 50976 "Size Range Card"
{
    PageType = Card;
    SourceTable = SizeRange;
    Caption = 'Size Range';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Size Range No';
                }

                field("Size Range"; rec."Size Range")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SizeRangeRec: Record SizeRange;
                        LoginSessionsRec: Record LoginSessions;
                        LoginRec: Page "Login Card";
                    begin
                        SizeRangeRec.Reset();
                        SizeRangeRec.SetRange("Size Range", rec."Size Range");

                        if SizeRangeRec.FindSet() then
                            Error('Size Range already exists.');

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