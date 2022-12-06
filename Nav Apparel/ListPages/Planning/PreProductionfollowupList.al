page 50839 "PreProductionfollowupList"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = PreProductionFollowUpHeader;
    CardPageId = PreProductionfollowup;
    Caption = 'Pre-Production Follow Up';
    //SourceTableView = where();

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

                field("Factory Name"; rec."Factory Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnOpenPage()
    var
        UserSetupRec: Record "User Setup";
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

        UserSetupRec.Reset();
        UserSetupRec.SetRange("User ID", UserId);
        if UserSetupRec.FindSet() then
            rec.SetFilter("Factory Code", UserSetupRec."Factory Code");
    end;


    trigger OnDeleteRecord(): Boolean
    var
        PreProductionFollowUplineRec: Record PreProductionFollowUpline;
    begin

        PreProductionFollowUplineRec.Reset();
        PreProductionFollowUplineRec.SetRange("Line No", Rec."No.");

        if PreProductionFollowUplineRec.FindSet() then
            PreProductionFollowUplineRec.DeleteAll();
    end;
}