page 50847 MerchandizingGroupCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = MerchandizingGroupTable;
    Caption = 'Merchandizing Group';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Group Id"; rec."Group Id")
                {
                    ApplicationArea = All;
                    Editable = Editbale;

                    trigger OnValidate()
                    var
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
                    end;
                }

                field("Group Name"; rec."Group Name")
                {
                    ApplicationArea = All;
                    Editable = Editbale;
                }

                field("Group Head"; rec."Group Head")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    var
    begin
        if rec."Group Id" <> '' then
            Editbale := false
        else
            Editbale := true;
    end;


    var
        Editbale: Boolean;
}