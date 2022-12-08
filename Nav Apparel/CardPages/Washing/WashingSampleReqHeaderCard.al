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
                        if rec."Sample/Bulk" = rec."Sample/Bulk"::Sample then
                            EditableGB := true
                        else begin
                            EditableGB := false;
                            rec."Sample Req. No" := '';

                            WashSMReqLineRec.Reset();
                            WashSMReqLineRec.SetRange("No.", rec."No.");
                            if WashSMReqLineRec.FindSet() then
                                WashSMReqLineRec.ModifyAll("Sample Req. No", '');

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

                    end;
                }

                field("Sample Req. No"; rec."Sample Req. No")
                {
                    ApplicationArea = All;
                    Editable = EditableGB;

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

                field("PO No"; rec."PO No")
                {
                    ApplicationArea = All;
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

                // field("Washing Status"; "Washing Status")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
            }

            group("Sample Details")
            {
                part(WashingSampleListpart; WashingSampleListpart)
                {
                    ApplicationArea = All;
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


        //Check for split lines
        Inter1Rec.Reset();
        Inter1Rec.SetRange(No, rec."No.");
        if Inter1Rec.FindSet() then
            Error('Request has been split. Cannot delete.');


        //Delete lines
        SampleWasLineRec.Reset();
        SampleWasLineRec.SetRange("No.", rec."No.");
        if SampleWasLineRec.FindSet() then
            SampleWasLineRec.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        WashSampleReqLineRec: Record "Washing Sample Requsition Line";
    begin
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
        if rec."Sample/Bulk" = rec."Sample/Bulk"::Sample then
            EditableGB := true
        else begin
            EditableGB := false;
            rec."Sample Req. No" := '';
        end;
    end;


    var
        EditableGB: Boolean;

}