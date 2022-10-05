page 50701 "Washing Sample Request Card"
{
    PageType = Card;
    SourceTable = "Washing Sample Header";
    Caption = 'Washing Sample Request';

    layout
    {

        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Request No';
                    //Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Buyer Name"; "Buyer Name")
                {
                    ApplicationArea = All;
                    //Editable = false;
                    Caption = 'Buyer';

                    trigger OnValidate()
                    var
                        CustomerRec: Record Customer;
                        Users: Record "User Setup";
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, "Buyer Name");
                        if CustomerRec.FindSet() then begin
                            "Buyer No." := CustomerRec."No.";
                            "Req Date" := WorkDate();
                            CurrPage.Update();
                        end;

                        //Get user location
                        Users.Reset();
                        Users.SetRange("User ID", UserId());

                        Users.FindSet();
                        begin
                            "Request From" := Users."Factory Code";
                            CurrPage.Update();
                        end;


                    end;
                }

                field("Style Name"; "Style Name")
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
                        StyleRec.SetRange("Style No.", "Style Name");
                        if StyleRec.FindSet() then begin
                            "Style No." := StyleRec."No.";
                            "Garment Type Name" := StyleRec."Garment Type Name";
                            CurrPage.Update();
                        end;

                        //Delete old record
                        StyleColorRec.Reset();
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
                                    StyleColorRec."Color No." := AssoRec."Colour No";
                                    StyleColorRec.Color := AssoRec."Colour Name";
                                    StyleColorRec.Insert();
                                    Color := AssoRec."Colour No";
                                end;
                            until AssoRec.Next() = 0;
                        end;

                    end;
                }

                field("Request From"; "Request From")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Garment Type No."; "Garment Type No.")
                {
                    ApplicationArea = All;
                    TableRelation = "Garment Type"."No.";
                    Visible = false;

                    // trigger OnValidate()
                    // var
                    //     GarmentTypeRec: Record "Garment Type";
                    // begin
                    //     GarmentTypeRec.get("Garment Type No.");
                    //     "Garment Type Name" := GarmentTypeRec."Garment Type Description";
                    // end;
                }

                field("Garment Type Name"; "Garment Type Name")
                {
                    ApplicationArea = All;
                    Caption = 'Garment Type';

                    trigger OnValidate()
                    var
                        GarmentTypeRec: Record "Garment Type";
                    begin
                        GarmentTypeRec.Reset();
                        GarmentTypeRec.SetRange("Garment Type Description", "Garment Type Name");
                        if GarmentTypeRec.FindSet() then
                            "Garment Type No." := GarmentTypeRec."No."
                    end;

                }

                field("Wash Plant No."; "Wash Plant No.")
                {
                    ApplicationArea = All;
                    Caption = 'Wash Plant No';
                    Visible = false;

                    // trigger OnValidate()
                    // var
                    //     LocationRec: Record Location;
                    // begin
                    //     LocationRec.get("Wash Plant No.");
                    //     "Wash Plant Name" := LocationRec.Name;
                    // end;
                }

                field("Wash Plant Name"; "Wash Plant Name")
                {
                    ApplicationArea = All;
                    Caption = 'Washing Plant';

                    trigger OnValidate()
                    var
                        LocationRec: Record Location;
                    begin
                        LocationRec.Reset();
                        LocationRec.SetRange(Name, "Wash Plant Name");
                        if LocationRec.FindSet() then
                            "Wash Plant No." := LocationRec.Code;
                    end;
                }

                field(Comment; Comment)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

                field("Req Date"; "Req Date")
                {
                    ApplicationArea = All;
                    Caption = 'Request Date';
                }

                field("Sample/Bulk"; "Sample/Bulk")
                {
                    ApplicationArea = All;
                }

                field("Washing Status"; "Washing Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Wash Sample Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
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
        SampleWasLineRec.SetRange("No.", "No.");

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
        Inter1Rec.SetRange(No, "No.");
        if Inter1Rec.FindSet() then
            Error('Request has been split. Cannot delete.');


        //Delete lines
        SampleWasLineRec.Reset();
        SampleWasLineRec.SetRange("No.", "No.");
        if SampleWasLineRec.FindSet() then
            SampleWasLineRec.DeleteAll();
    end;


    trigger OnOpenPage()
    var
        WashSampleReqLineRec: Record "Washing Sample Requsition Line";
    begin

        WashSampleReqLineRec.Reset();
        WashSampleReqLineRec.SetRange("No.", "No.");

        if WashSampleReqLineRec.FindSet() then begin
            if (WashSampleReqLineRec."Split Status" = WashSampleReqLineRec."Split Status"::Yes) or
            (WashSampleReqLineRec."Req Qty BW QC Pass" + WashSampleReqLineRec."Req Qty BW QC Fail" > 0) then
                CurrPage.Editable(false)
            else
                CurrPage.Editable(true);
        end;

    end;
}