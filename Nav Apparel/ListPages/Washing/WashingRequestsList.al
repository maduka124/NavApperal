page 50719 WashingSampleHistry
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Washing Sample Header";
    CardPageId = "Washing Sample Request Card";
    Caption = 'History of Sample Requests';
    SourceTableView = sorting("No.") order(descending);
    Editable = false;

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
        UserRec: Record "User Setup";
        LocationRec: Record Location;
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

        UserRec.Reset();
        UserRec.Get(UserId);

        if UserRec."Factory Code" <> '' then begin
            LocationRec.Reset();

            LocationRec.SetRange(Code, UserRec."Factory Code");

            if LocationRec.FindSet() then
                rec.SetFilter("Wash Plant Name", '=%1', LocationRec.Name);
        end;

    end;


    trigger OnDeleteRecord(): Boolean
    var
        SampleWasLineRec: Record "Washing Sample Requsition Line";
        Inter1Rec: Record IntermediateTable;
        WashingMasterRec: Record WashingMaster;
        UserRec: Record "User Setup";
    begin

        UserRec.Reset();
        UserRec.Get(UserId);

        if UserRec.UserRole <> 'SEWING RECORDER' then
            Error('You are not authorized to delete records.');

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

        SampleWasLineRec.Reset();
        SampleWasLineRec.SetRange("No.", Rec."No.");

        if SampleWasLineRec.FindSet() then begin

            WashingMasterRec.Reset();
            WashingMasterRec.SetRange("PO No", SampleWasLineRec."PO No");
            WashingMasterRec.SetRange("Style No", SampleWasLineRec."Style No.");
            WashingMasterRec.SetRange(Lot, SampleWasLineRec."Lot No");
            WashingMasterRec.SetRange("Color Name", SampleWasLineRec."Color Name");

            if WashingMasterRec.FindSet() then begin
                WashingMasterRec."Received Qty" := WashingMasterRec."Received Qty" - SampleWasLineRec."Req Qty";
                WashingMasterRec.Modify(true);
            end;
        end;

        //Delete lines
        SampleWasLineRec.Reset();
        SampleWasLineRec.SetRange("No.", rec."No.");
        if SampleWasLineRec.FindSet() then
            SampleWasLineRec.DeleteAll();
    end;


}