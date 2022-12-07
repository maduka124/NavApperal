page 50746 RTCBWList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = RTCBWHeader;
    CardPageId = RTCBWCard;
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    Caption = 'Document No';
                    ApplicationArea = All;
                }

                field("Req No"; rec."Req No")
                {
                    ApplicationArea = all;
                    Caption = 'Req. No';
                }

                field("CusTomer Name"; rec."CusTomer Name")
                {
                    Caption = 'Customer';
                    ApplicationArea = all;
                }

                field("Gate Pass"; rec."Gate Pass")
                {
                    ApplicationArea = all;
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
        RTCBWLineRec: Record RTCBWLine;
        Samplereqline: Record "Washing Sample Requsition Line";
    begin
        Samplereqline.Reset();
        Samplereqline.SetRange("No.", rec."Req No");

        if Samplereqline.FindSet() then
            if Samplereqline."Return Qty (BW)" > 0 then
                Error('Returned quantity updated. Cannot delete.');

        RTCBWLineRec.Reset();
        RTCBWLineRec.SetRange("No.", rec."No.");
        if RTCBWLineRec.FindSet() then
            RTCBWLineRec.DeleteAll();
    end;
}