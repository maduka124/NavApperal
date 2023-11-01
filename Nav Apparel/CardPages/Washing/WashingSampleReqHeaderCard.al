page 50701 "Washing Sample Request Card"
{
    PageType = Card;
    SourceTable = "Washing Sample Header";
    Caption = 'Washing Requisition';

    layout
    {

        area(Content)
        {

            group(General)
            {
                Editable = EditableUser;
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Requisition No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Sample/Bulk"; rec."Sample/Bulk")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashSMReqLineRec: Record "Washing Sample Requsition Line";
                    begin
                        if rec."Sample/Bulk" = rec."Sample/Bulk"::Sample then begin
                            EditableGB := true;
                        end
                        else begin
                            EditableGB := false;
                            rec."Sample Req. No" := '';

                            WashSMReqLineRec.Reset();
                            WashSMReqLineRec.SetRange("No.", rec."No.");
                            if WashSMReqLineRec.FindSet() then
                                WashSMReqLineRec.ModifyAll("Sample Req. No", '');
                        end;

                        if rec."Sample/Bulk" <> Rec."Sample/Bulk"::Sample then begin

                            WashSMReqLineRec.Reset();
                            WashSMReqLineRec.SetRange("No.", Rec."No.");
                            if WashSMReqLineRec.FindSet() then
                                WashSMReqLineRec.DeleteAll(true);

                            WashSMReqLineRec.Init();
                            WashSMReqLineRec."No." := Rec."No.";
                            WashSMReqLineRec."Line no." := 1;
                            WashSMReqLineRec.SampleType := 'Bulk';
                            WashSMReqLineRec.Insert();

                        end
                        else begin
                            WashSMReqLineRec.Reset();
                            WashSMReqLineRec.SetRange("No.", Rec."No.");

                            if WashSMReqLineRec.FindSet() then
                                WashSMReqLineRec.Delete()
                        end;
                    end;
                }

                field("Buyer Name"; rec."Buyer Name")
                {
                    ApplicationArea = All;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                        UsersRec: Record "User Setup";
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


                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, rec."Buyer Name");
                        if CustomerRec.FindSet() then begin
                            rec."Buyer No." := CustomerRec."No.";
                            rec."Req Date" := WorkDate();
                            CurrPage.Update();
                        end;

                        //Get user location
                        UsersRec.Reset();
                        UsersRec.SetRange("User ID", UserId());

                        if UsersRec.FindSet() then begin
                            rec."Request From" := UsersRec."Factory Code";
                            CurrPage.Update();
                        end;
                    end;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';

                    trigger OnValidate()
                    var
                        StyleRec: Record "Style Master";
                        StyleColorRec: Record StyleColor;
                        WorkCenterRec: Record "Work Center";
                        AssoRec: Record AssorColorSizeRatio;
                        WashSMReqLineRec: Record "Washing Sample Requsition Line";
                        Color: Code[20];
                    begin
                        StyleRec.Reset();
                        StyleRec.SetRange("Style No.", rec."Style Name");
                        if StyleRec.FindSet() then begin
                            rec."Style No." := StyleRec."No.";
                            rec."Garment Type No." := StyleRec."Garment Type No.";
                            rec."Garment Type Name" := StyleRec."Garment Type Name";
                            CurrPage.Update();
                        end;

                        //Delete old record
                        StyleColorRec.Reset();
                        StyleColorRec.SetRange("User ID", UserId);
                        if StyleColorRec.FindSet() then
                            StyleColorRec.DeleteAll();


                        //Get Colors for the style
                        AssoRec.Reset();
                        AssoRec.SetCurrentKey("Style No.", "Colour Name");
                        AssoRec.SetRange("Style No.", StyleRec."No.");
                        AssoRec.SetFilter("Colour Name", '<>%1', '*');

                        if AssoRec.FindSet() then begin
                            repeat
                                if Color <> AssoRec."Colour No" then begin
                                    StyleColorRec.Init();
                                    StyleColorRec."User ID" := UserId;
                                    StyleColorRec."Color No." := AssoRec."Colour No";
                                    StyleColorRec.Color := AssoRec."Colour Name";
                                    StyleColorRec.Insert();
                                    Color := AssoRec."Colour No";
                                end;
                            until AssoRec.Next() = 0;
                        end;

                        WashSMReqLineRec.Reset();
                        WashSMReqLineRec.SetRange("No.", Rec."No.");

                        if WashSMReqLineRec.FindSet() then begin
                            WashSMReqLineRec."Style No." := Rec."Style No.";
                            WashSMReqLineRec."Style Name" := Rec."Style Name";
                            WashSMReqLineRec.Modify(true);
                        end;
                    end;
                }

                field("Sample Req. No"; rec."Sample Req. No")
                {
                    ApplicationArea = All;
                    Editable = EditableGB;
                    Visible = EditableGB;

                    trigger OnValidate()
                    var
                        SMReqHeaderRec: Record "Sample Requsition Header";
                        SMReqLineRec: Record "Sample Requsition Line";
                        WashSMReqLineRec: Record "Washing Sample Requsition Line";
                    begin

                        if rec."Sample/Bulk" = rec."Sample/Bulk"::Sample then begin

                            SMReqHeaderRec.Reset();
                            SMReqHeaderRec.SetRange("No.", rec."Sample Req. No");
                            if SMReqHeaderRec.FindSet() then begin
                                rec."Wash Plant No." := SMReqHeaderRec."Wash Plant No.";
                                rec."Wash Plant Name" := SMReqHeaderRec."Wash Plant Name";
                            end;

                            if rec."Sample Req. No" <> '' then begin
                                //Insert request line
                                SMReqLineRec.Reset();
                                SMReqLineRec.SetRange("No.", rec."Sample Req. No");
                                if SMReqLineRec.FindSet() then begin

                                    //Delete old records
                                    WashSMReqLineRec.Reset();
                                    WashSMReqLineRec.SetRange("No.", rec."No.");
                                    if WashSMReqLineRec.FindSet() then
                                        WashSMReqLineRec.DeleteAll();

                                    WashSMReqLineRec.Init();
                                    WashSMReqLineRec."No." := rec."No.";
                                    WashSMReqLineRec."Style No." := rec."Style No.";
                                    WashSMReqLineRec."Style_PO No" := rec."PO No";
                                    WashSMReqLineRec."Style Name" := rec."Style Name";
                                    WashSMReqLineRec."Wash Plant Name" := rec."Wash Plant Name";
                                    WashSMReqLineRec.Buyer := rec."Buyer Name";
                                    WashSMReqLineRec."Buyer No" := rec."Buyer No.";
                                    WashSMReqLineRec."Gament Type" := rec."Garment Type Name";
                                    WashSMReqLineRec."Factory Name" := rec."Wash Plant Name";
                                    WashSMReqLineRec."Location Code" := rec."Wash Plant No.";
                                    WashSMReqLineRec."Req Date" := WorkDate();
                                    WashSMReqLineRec.SampleType := SMReqLineRec."Sample Name";
                                    WashSMReqLineRec."Sample No." := SMReqLineRec."Sample No.";
                                    WashSMReqLineRec."Wash Type No." := SMReqHeaderRec."Wash Type No.";
                                    WashSMReqLineRec."Wash Type" := SMReqHeaderRec."Wash Type Name";
                                    WashSMReqLineRec."Fabric Description" := SMReqLineRec."Fabrication Name";
                                    WashSMReqLineRec."Fabrication No." := SMReqLineRec."Fabrication No.";
                                    WashSMReqLineRec."Color Code" := SMReqLineRec."Color No";
                                    WashSMReqLineRec."Color Name" := SMReqLineRec."Color Name";
                                    WashSMReqLineRec.Size := SMReqLineRec.Size;
                                    WashSMReqLineRec."Req Qty" := SMReqLineRec.Qty;
                                    WashSMReqLineRec."Sample Req. No" := rec."Sample Req. No";
                                    WashSMReqLineRec.Insert();

                                    CurrPage.Update();
                                end;
                            end
                            else begin
                                WashSMReqLineRec.Reset();
                                WashSMReqLineRec.SetRange("No.", rec."No.");
                                if WashSMReqLineRec.FindSet() then
                                    WashSMReqLineRec.ModifyAll("Sample Req. No", '');

                            end;

                        end;

                        CurrPage.Update();

                    end;
                }

                field("Request From"; rec."Request From")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Requisition From';
                }

                field("Garment Type No."; rec."Garment Type No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Garment Type"."No.";
                    Visible = false;
                }

                field("Garment Type Name"; rec."Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';
                    Editable = false;

                    trigger OnValidate()
                    var
                        GarmentTypeRec: Record "Garment Type";
                    begin
                        GarmentTypeRec.Reset();
                        GarmentTypeRec.SetRange("Garment Type Description", rec."Garment Type Name");
                        if GarmentTypeRec.FindSet() then
                            rec."Garment Type No." := GarmentTypeRec."No."
                    end;

                }

                field("Wash Plant No."; rec."Wash Plant No.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Plant No';
                    Visible = false;
                }

                field("Lot No"; Rec."Lot No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        StyleMasterPORec: Record "Style Master PO";
                        WashingMasterRec: Record WashingMaster;
                        WashSMReqLineRec: Record "Washing Sample Requsition Line";
                        WashType: Code[200];
                    begin

                        StyleMasterPORec.Reset();
                        StyleMasterPORec.SetRange("Style No.", Rec."Style No.");
                        StyleMasterPORec.SetRange("Lot No.", Rec."Lot No");

                        if StyleMasterPORec.FindSet() then begin
                            Rec."PO No" := StyleMasterPORec."PO No.";

                            WashingMasterRec.Reset();
                            WashingMasterRec.SetRange("Style No", Rec."Style No.");
                            WashingMasterRec.SetRange("PO No", Rec."PO No");
                            WashingMasterRec.SetRange(Lot, Rec."Lot No");

                            if WashingMasterRec.FindFirst() then begin
                                rec."Wash Plant Name" := WashingMasterRec."Washing Plant";
                                WashType := WashingMasterRec."Wash Type";
                            end;

                            WashSMReqLineRec.Reset();
                            WashSMReqLineRec.SetRange("No.", Rec."No.");

                            if WashSMReqLineRec.FindSet() then begin
                                WashSMReqLineRec."PO No" := Rec."PO No";
                                WashSMReqLineRec."Lot No" := Rec."Lot No";
                                WashSMReqLineRec."Wash Type" := WashType;
                                WashSMReqLineRec.Modify(true);
                            end;

                        end;


                    end;
                }

                field("PO No"; rec."PO No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Wash Plant Name"; rec."Wash Plant Name")
                {
                    ApplicationArea = All;
                    Caption = 'Washing Plant';

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin
                        LocationRec.Reset();
                        LocationRec.SetRange(Name, rec."Wash Plant Name");
                        if LocationRec.FindSet() then
                            rec."Wash Plant No." := LocationRec.Code;
                    end;
                }

                field(Comment; rec.Comment)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Req Date"; rec."Req Date")
                {
                    ApplicationArea = All;
                    Caption = 'Requisition Date';
                    Editable = false;
                }

                field("Posted/Not"; rec."Posted/Not")
                {
                    ApplicationArea = All;
                }

            }

            group("Sample Details")
            {
                part(WashingSampleListpart; WashingSampleListpart)
                {
                    ApplicationArea = All;
                    Editable = EditableUser;
                    Caption = ' ';
                    SubPageLink = "No." = FIELD("No.");
                }
            }
        }

        area(FactBoxes)
        {
            part(MyFactBox; WashSampleReqPictureFactBox)
            {
                ApplicationArea = all;
                SubPageLink = "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {

                ApplicationArea = All;
                Image = Allocations;

                trigger OnAction()
                var
                    WashingMasterRec: Record WashingMaster;
                    WashinReqHeaderRec: Record "Washing Sample Header";
                    WashinReqHeader2Rec: Record "Washing Sample Header";
                    WashingReqLineRec: Record "Washing Sample Requsition Line";
                    WashingReqLine2Rec: Record "Washing Sample Requsition Line";
                    StyleMasterPORec: Record "Style Master PO";
                    Total: BigInteger;
                    UserRec: Record "User Setup";
                begin

                    UserRec.Reset();
                    UserRec.Get(UserId);

                    if UserRec.UserRole <> 'SEWING RECORDER' then
                        Error('You are not authorized to post.');

                    if Rec."Posted/Not" = true then
                        Error('This record Already Posted');

                    Total := 0;

                    WashingReqLineRec.Reset();
                    WashingReqLineRec.SetRange("No.", Rec."No.");

                    if WashingReqLineRec.FindSet() then begin

                        if WashingReqLineRec."Req Qty" <> 0 then begin

                            WashingMasterRec.Reset();
                            WashingMasterRec.SetRange("Style No", WashingReqLineRec."Style No.");
                            WashingMasterRec.SetRange("PO No", WashingReqLineRec."PO No");
                            WashingMasterRec.SetRange(Lot, WashingReqLineRec."Lot No");
                            WashingMasterRec.SetRange("Color Name", WashingReqLineRec."Color Name");

                            if WashingMasterRec.FindSet() then begin

                                if WashingMasterRec."Color Qty" < WashingReqLineRec."Req Qty" then
                                    Message('Req qty greater than color qty');

                                WashingReqLine2Rec.Reset();
                                WashingReqLine2Rec.SetRange("Style No.", WashingReqLineRec."Style No.");
                                WashingReqLine2Rec.SetRange("PO No", WashingReqLineRec."PO No");
                                WashingReqLine2Rec.SetRange("Lot No", WashingReqLineRec."Lot No");
                                WashingReqLine2Rec.SetRange("Color Code", WashingReqLineRec."Color Code");

                                if WashingReqLine2Rec.FindSet() then begin
                                    repeat

                                        WashinReqHeader2Rec.SetRange("No.", WashingReqLine2Rec."No.");

                                        if WashinReqHeader2Rec.FindSet() then begin
                                            if Rec."No." = WashinReqHeader2Rec."No." then
                                                Total += WashingReqLine2Rec."Req Qty";
                                            if WashinReqHeader2Rec."Posted/Not" = true then
                                                Total += WashingReqLine2Rec."Req Qty";
                                        end;

                                    until WashingReqLine2Rec.Next() = 0;

                                    if Total > WashingMasterRec."Color Qty" then
                                        Error('Wash qty greater than color qty');

                                    WashingMasterRec."Received Qty" := Total;
                                    WashingMasterRec.Modify(true);

                                    Rec."Posted/Not" := true;
                                    Rec."Posting Date" := WorkDate();
                                    Rec.Modify(true);

                                end;

                                WashingReqLine2Rec.Reset();
                                WashingReqLine2Rec.SetRange("Style No.", WashingReqLineRec."Style No.");
                                WashingReqLine2Rec.SetRange("PO No", WashingReqLineRec."PO No");
                                WashingReqLine2Rec.SetRange("Lot No", WashingReqLineRec."Lot No");
                                WashingReqLine2Rec.SetRange("Color Code", WashingReqLineRec."Color Code");
                                WashingReqLine2Rec.SetRange("Order Type", WashingReqLine2Rec."Order Type"::Send);
                                WashingReqLine2Rec.SetCurrentKey("No.");
                                WashingReqLine2Rec.Ascending(true);

                                if WashingReqLine2Rec.FindFirst() then begin
                                    WashinReqHeaderRec.Reset();
                                    WashinReqHeaderRec.SetRange("No.", WashingReqLine2Rec."No.");

                                    if WashinReqHeaderRec.FindFirst() then begin
                                        WashingMasterRec."First Received Date" := WashinReqHeaderRec."Posting Date";
                                        WashingMasterRec.Modify(true);
                                    end;

                                end;

                                WashingReqLine2Rec.Reset();
                                WashingReqLine2Rec.SetRange("Style No.", WashingReqLineRec."Style No.");
                                WashingReqLine2Rec.SetRange("PO No", WashingReqLineRec."PO No");
                                WashingReqLine2Rec.SetRange("Lot No", WashingReqLineRec."Lot No");
                                WashingReqLine2Rec.SetRange("Color Code", WashingReqLineRec."Color Code");
                                WashingReqLine2Rec.SetRange("Order Type", WashingReqLine2Rec."Order Type"::Send);
                                WashingReqLine2Rec.SetCurrentKey("No.");
                                WashingReqLine2Rec.Ascending(true);

                                if WashingReqLine2Rec.FindLast() then begin
                                    WashinReqHeaderRec.Reset();
                                    WashinReqHeaderRec.SetRange("No.", WashingReqLine2Rec."No.");

                                    if WashinReqHeaderRec.FindFirst() then begin
                                        WashingMasterRec."Last Received Date" := WashinReqHeaderRec."Posting Date";
                                        WashingMasterRec.Modify(true);
                                    end;
                                end;

                                Message('Requesest Posted');

                            end
                            else
                                Error('This color not in allocated list');
                        end
                        else
                            Error('Req qty Should be greater than 0');
                    end;
                end;
            }
        }
    }


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Wash Sample Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        SampleWasLineRec: Record "Washing Sample Requsition Line";
        Inter1Rec: Record IntermediateTable;
        WashingMasterRec: Record WashingMaster;
        WashinReqHeaderRec: Record "Washing Sample Header";
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


        //Check for split lines
        Inter1Rec.Reset();
        Inter1Rec.SetRange(No, rec."No.");
        if Inter1Rec.FindSet() then
            Error('Request has been split. Cannot delete.');

        SampleWasLineRec.Reset();
        SampleWasLineRec.SetRange("No.", Rec."No.");
        SampleWasLineRec.SetRange("Order Type", SampleWasLineRec."Order Type"::Send);

        if SampleWasLineRec.FindSet() then begin

            WashingMasterRec.Reset();
            WashingMasterRec.SetRange("PO No", SampleWasLineRec."PO No");
            WashingMasterRec.SetRange("Style No", SampleWasLineRec."Style No.");
            WashingMasterRec.SetRange(Lot, SampleWasLineRec."Lot No");
            WashingMasterRec.SetRange("Color Name", SampleWasLineRec."Color Name");

            if WashingMasterRec.FindSet() then begin

                WashinReqHeaderRec.Reset();
                WashinReqHeaderRec.SetRange("No.", SampleWasLineRec."No.");

                if WashinReqHeaderRec.FindSet() then begin

                    if WashinReqHeaderRec."Posted/Not" = true then begin

                        WashingMasterRec."Received Qty" := WashingMasterRec."Received Qty" - SampleWasLineRec."Req Qty";
                        WashingMasterRec.Modify(true);

                    end;
                end;
            end;
        end;

        //Delete lines
        SampleWasLineRec.Reset();
        SampleWasLineRec.SetRange("No.", rec."No.");
        if SampleWasLineRec.FindSet() then
            SampleWasLineRec.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        WashSampleReqLineRec: Record "Washing Sample Requsition Line";
        UserRec: Record "User Setup";
    begin

        EditableGB := true;

        UserRec.Reset();
        UserRec.Get(UserId);

        if Rec."No." <> '' then
            if UserRec.UserRole = 'SEWING RECORDER' then
                EditableUser := true
            else
                EditableUser := false
        else
            if UserRec.UserRole = 'SEWING RECORDER' then
                EditableUser := true
            else
                EditableUser := false;

        WashSampleReqLineRec.Reset();
        WashSampleReqLineRec.SetRange("No.", rec."No.");

        if WashSampleReqLineRec.FindSet() then begin
            if (WashSampleReqLineRec."Split Status" = WashSampleReqLineRec."Split Status"::Yes) or
            (WashSampleReqLineRec."Req Qty BW QC Pass" + WashSampleReqLineRec."Req Qty BW QC Fail" > 0) then
                CurrPage.Editable(false)
            else
                CurrPage.Editable(true);
        end;


    end;


    trigger OnAfterGetCurrRecord()
    var
    begin
        if rec."Sample/Bulk" = rec."Sample/Bulk"::Sample then begin
            EditableGB := true;

        end
        else begin
            EditableGB := false;
            rec."Sample Req. No" := '';
        end;
    end;

    var
        EditableGB: Boolean;
        EditableUser: Boolean;
}