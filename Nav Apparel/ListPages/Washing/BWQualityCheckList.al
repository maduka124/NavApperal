page 50742 BWQualityCheckList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = BWQualityCheckHeader;
    CardPageId = BWQualityCheck;
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'B/W Quality Check No';
                }

                field("Sample Req No"; rec."Sample Req No")
                {
                    ApplicationArea = All;

                }

                field("BW QC Date"; rec."BW QC Date")
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

    trigger OnDeleteRecord(): Boolean
    var
        BWqualityCheckLine2Rec: Record BWQualityLine2;
    begin
        BWqualityCheckLine2Rec.Reset();
        BWqualityCheckLine2Rec.SetRange(No, rec."No.");

        if BWqualityCheckLine2Rec.FindSet() then
            BWqualityCheckLine2Rec.DeleteAll();
    end;
}