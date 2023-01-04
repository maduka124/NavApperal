page 51186 WashingSampleHistryMerchand
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Washing Sample Header";
    CardPageId = WashingSampleRequestMerchCard;
    Caption = 'History of Sample Requests';
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
                    Caption = 'No';
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("PO No"; rec."PO No")
                {
                    ApplicationArea = All;
                }

                field("Sample/Bulk"; rec."Sample/Bulk")
                {
                    ApplicationArea = All;
                }

                field("Sample Req. No"; rec."Sample Req. No")
                {
                    ApplicationArea = All;
                }

                field("Request From"; rec."Request From")
                {
                    ApplicationArea = All;
                    Caption = 'Requisition From';
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                }

                field("Wash Plant Name"; rec."Wash Plant Name")
                {
                    ApplicationArea = All;
                    Caption = 'Washing Plant';
                }

                field(Comment; rec.Comment)
                {
                    ApplicationArea = All;
                }

                field("Req Date"; rec."Req Date")
                {
                    ApplicationArea = All;
                }

                // field("Washing Status"; "Washing Status")
                // {
                //     ApplicationArea = All;
                // }
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
        UserSetupRec: Record "User Setup";
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

        if UserSetupRec.FindSet() then begin
            if UserSetupRec."Merchandizer All Group" = false then begin
                if UserSetupRec."Merchandizer Group Name" = '' then
                    Error('Merchandiser Group Name has not set up for the user : %1', UserId)
                else
                    rec.SetFilter("Merchandizer Group Name", '=%1', UserSetupRec."Merchandizer Group Name");
            end
        end
        else
            Error('Cannot find user details in user setup table');

    end;


    trigger OnDeleteRecord(): Boolean
    var
        SampleWasLineRec: Record "Washing Sample Requsition Line";
        Inter1Rec: Record IntermediateTable;
    begin

        //Check whether request has been processed
        SampleWasLineRec.Reset();
        SampleWasLineRec.SetRange("No.", rec."No.");

        if SampleWasLineRec.FindSet() then begin
            if SampleWasLineRec."Return Qty (BW)" > 0 then
                Error('(BW) Returned quantity updated. Cannot delete the request.');

            if SampleWasLineRec."Req Qty BW QC Pass" > 0 then
                Error('BW quality check has been conpleted. Cannot delete the request.');

            if SampleWasLineRec."Req Qty BW QC Fail" > 0 then
                Error('BW quality check has been conpleted. Cannot delete the request.');

            if SampleWasLineRec."Split Status" = SampleWasLineRec."Split Status"::Yes then
                Error('Request has been split. Cannot delete.');
        end;
    end;


}