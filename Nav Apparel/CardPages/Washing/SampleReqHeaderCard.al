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
                    begin
                        CustomerRec.Reset();
                        CustomerRec.SetRange(Name, "Buyer Name");
                        if CustomerRec.FindSet() then
                            "Buyer No." := CustomerRec."No.";
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
                        if StyleRec.FindSet() then
                            "Style No." := StyleRec."No.";

                        CurrPage.Update();

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

    actions
    {
        area(Processing)
        {
            // action("View Splits")
            // {
            //     ApplicationArea = All;

            //     trigger OnAction()
            //     var
            //         MyTaskRevise: Page "Job Creation Card";
            //         WashSampleReqLineRec: Record "Washing Sample Requsition Line";
            //     begin
            //         WashSampleReqLineRec.Reset();
            //         WashSampleReqLineRec.SetFilter("Split Status", '=%1', WashSampleReqLineRec."Split Status"::Yes);
            //         //WashSampleReqLineRec.SetFilter(WashSampleReqLineRec."Select Item", '=%1', true);

            //         if WashSampleReqLineRec.FindSet() then begin

            //             Clear(MyTaskRevise);
            //             MyTaskRevise.LookupMode(true);
            //             MyTaskRevise.PassParameters("No.", LineNo, Editeble::No);
            //             MyTaskRevise.RunModal();
            //         end
            //         else
            //             Error('Still you have not split the request.');
            //     end;
            // }

            action(ImportPictureFrontURL)
            {
                ApplicationArea = All;
                Caption = 'Import Front/Back Picture URL';
                Image = Import;
                ToolTip = 'Import Front/Back Picture URL';

                trigger OnAction()
                var
                    PictureURLDialog: Page "Washing Sample Picture URL";
                begin
                    PictureURLDialog.SetItemInfo("No.");
                    if PictureURLDialog.RunModal() = Action::OK then
                        PictureURLDialog.ImportItemPictureFromURL();
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Wash Sample Nos.", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        SampleWasLineRec: Record "Washing Sample Requsition Line";
    begin
        SampleWasLineRec.Reset();
        SampleWasLineRec.SetRange("No.", "No.");
        if SampleWasLineRec.FindSet() then
            SampleWasLineRec.DeleteAll();
    end;


    trigger OnClosePage()
    var
        WashSampleReqHdrRec: Record "Washing Sample Header";
    begin
        WashSampleReqHdrRec.Reset();
        WashSampleReqHdrRec.SetRange("No.", "No.");
        WashSampleReqHdrRec.SetRange(LineNo, LineNo);

        if WashSampleReqHdrRec.FindSet() then begin
            Clear(WashSampleReqHdrRec.PictureFront);
            Clear(WashSampleReqHdrRec.PictureBack);
            WashSampleReqHdrRec.Modify(true);
        end;
    end;

    // var
    //     SOLineNo: Code[50];
    //     No: code[20];
    //     LineNo: Integer;
    //     editable: Option;

    // procedure EditablePara(editblePara: Option);
    // var
    // begin
    //     editblePara := editblePara;
    //     Editeble := editable;
    // end;

    // procedure PassParameters(NoPara: Code[20]; LineNoPara: Integer);
    // var
    // begin
    //     No := NoPara;
    //     LineNo := LineNoPara;
    //     "No." := No;
    //     LineNo := LineNo;
    // end;

    trigger OnOpenPage()
    var
        WashSampleReqLineRec: Record "Washing Sample Requsition Line";
    begin
        // "No." := No;
        // LineNo := LineNo;
        // Editeble := editable;

        // if Editeble = Editeble::No then
        //     CurrPage.Editable := false

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