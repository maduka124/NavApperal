page 50848 MerchandizingGroupPage
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = MerchandizingGroupTable;
    CardPageId = MerchandizingGroupCard;
    Caption = 'Merchandising Group';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Group Id"; rec."Group Id")
                {
                    ApplicationArea = All;
                }

                field("Group Name"; rec."Group Name")
                {
                    ApplicationArea = All;
                }

                field("Group Head"; rec."Group Head")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

    end;
}