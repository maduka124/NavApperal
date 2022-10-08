page 50751 WashingSampleListpart
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Washing Sample Requsition Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line no."; "Line no.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';

                    // trigger OnValidate()
                    // var
                    //     SampleReqRec: Record "Washing Sample Requsition Line";
                    // begin
                    //     SampleReqRec.Reset();
                    //     SampleReqRec.SetRange("No.", "No.");
                    //     SampleReqRec.SetRange("Line no.", "Line no.");
                    // end;
                }

                // field("Select Item"; "Select Item")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Select';
                //     //Select Item On SampleRequetion Page

                //     trigger OnValidate()
                //     var
                //         WashingSampleReqRec: Record "Washing Sample Requsition Line";
                //         CountRec: Integer;
                //     begin

                //         CurrPage.Update();
                //         CountRec := 0;
                //         WashingSampleReqRec.Reset();
                //         WashingSampleReqRec.SetRange("No.", "No.");
                //         WashingSampleReqRec.SetFilter("Select Item", '=%1', true);

                //         if WashingSampleReqRec.FindSet() then
                //             CountRec := WashingSampleReqRec.Count;

                //         if CountRec > 1 then
                //             Error('You can select only one item');
                //     end;
                // }

                // field("Sample No."; "Sample No.")
                // {
                //     ApplicationArea = All;
                //     Visible = false;
                //     trigger OnValidate()
                //     var
                //         SampleTyprRec: Record "Sample Type";
                //         SampleReqHrdRec: Record "Washing Sample Header";
                //     begin
                //         // SampleTyprRec.Get("Sample No.");
                //         // //SampleType := SampleTyprRec."Sample Type Name";

                //         CurrPage.Update();
                //         SampleReqHrdRec.Get("No.");
                //         "Style No." := SampleReqHrdRec."Style No.";
                //         "Style Name" := SampleReqHrdRec."Style Name";
                //         "Wash Plant Name" := SampleReqHrdRec."Wash Plant Name";
                //         Buyer := SampleReqHrdRec."Buyer Name";
                //         "Gament Type" := SampleReqHrdRec."Garment Type Name";
                //         "Factory Name" := SampleReqHrdRec."Wash Plant Name";
                //         "Location Code" := SampleReqHrdRec."Wash Plant No.";

                //         CurrPage.Update();
                //     end;
                // }

                field(SampleType; SampleType)
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type';

                    trigger OnValidate()
                    var
                        SampleTyprRec: Record "Sample Type";
                        SampleReqHrdRec: Record "Washing Sample Header";
                    begin

                        SampleTyprRec.Reset();
                        SampleTyprRec.SetRange("Sample Type Name", SampleType);

                        if SampleTyprRec.FindSet() then
                            "Sample No." := SampleTyprRec."No.";

                        SampleReqHrdRec.Get("No.");
                        "Style No." := SampleReqHrdRec."Style No.";
                        "Style Name" := SampleReqHrdRec."Style Name";
                        "Wash Plant Name" := SampleReqHrdRec."Wash Plant Name";
                        Buyer := SampleReqHrdRec."Buyer Name";
                        "Buyer No" := SampleReqHrdRec."Buyer No.";
                        "Gament Type" := SampleReqHrdRec."Garment Type Name";
                        "Factory Name" := SampleReqHrdRec."Wash Plant Name";
                        "Location Code" := SampleReqHrdRec."Wash Plant No.";
                        "Req Date" := SampleReqHrdRec."Req Date";

                        CurrPage.Update();

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field("Wash Type"; "Wash Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashtypeRec: record "Wash Type";
                    begin
                        WashtypeRec.Reset();
                        WashtypeRec.SetRange("Wash Type Name", "Wash Type");
                        if WashtypeRec.FindSet() then
                            "Wash Type No." := WashtypeRec."No.";

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');

                    end;
                }

                field("Fabric Description"; "Fabric Description")
                {
                    ApplicationArea = All;
                    Caption = 'Fabrication';

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, "Fabric Description");
                        if ItemRec.FindSet() then begin
                            "Fabrication No." := ItemRec."No.";
                        end;

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Colour';

                    trigger OnLookup(var text: Text): Boolean
                    var
                        ColorRec: Record Colour;
                        StyleColorRec: Record StyleColor;
                    begin

                        StyleColorRec.Reset();
                        StyleColorRec.SetRange("User ID", UserId);
                        if StyleColorRec.FindSet() then begin
                            if Page.RunModal(71012840, StyleColorRec) = Action::LookupOK then begin
                                "Color Code" := StyleColorRec."Color No.";
                                "Color Name" := StyleColorRec.Color;
                            end;
                        end
                        else begin
                            ColorRec.Reset();
                            ColorRec.FindSet();
                            if Page.RunModal(71012841, ColorRec) = Action::LookupOK then begin
                                "Color Code" := ColorRec."No.";
                                "Color Name" := ColorRec."Colour Name";
                            end;
                        end;
                    end;

                }

                field(Size; Size)
                {
                    ApplicationArea = All;
                }

                field("Req Qty"; "Req Qty")
                {
                    ApplicationArea = All;

                    Caption = 'Req Qty';
                    trigger OnValidate()
                    var
                    begin
                        Value := "Unite Price" * "Req Qty";
                    end;
                }

                field("Req Date"; "Req Date")
                {
                    ApplicationArea = All;
                }

                // field("BW QC Date"; "BW QC Date")
                // {
                //     ApplicationArea = all;
                // }

                // field("Req Qty BW QC Pass"; "Req Qty BW QC Pass")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Req Qty (BW QC Pass)';
                //     Editable = false;
                // }

                // field("Req Qty BW QC Fail"; "Req Qty BW QC Fail")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Req Qty (BW QC Fail)';
                //     Editable = false;
                // }

                field("Unite Price"; "Unite Price")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        Value := "Unite Price" * "Req Qty";
                    end;
                }

                field(Value; Value)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("BW QC Date"; "BW QC Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Req Qty BW QC Pass"; "Req Qty BW QC Pass")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'BW QC Pass Qty';
                }

                field("Req Qty BW QC Fail"; "Req Qty BW QC Fail")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'BW QC Failed Qty';
                }

                field("Return Qty (BW)"; "Return Qty (BW)")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'BW Returned Qty';
                }

                field("AW QC Date"; "QC Date (AW)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("QC Pass Qty (AW)"; "QC Pass Qty (AW)")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'AW QC Pass Qty';
                }

                field("QC Fail Qty (AW)"; "QC Fail Qty (AW)")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'AW QC Failed Qty';
                }

                field("Return Qty (AW)"; "Return Qty (AW)")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'AW Returned Qty';
                }

                field("Dispatch Qty"; "Dispatch Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Final Dispatch Qty';
                }

                field(RemarkLine; RemarkLine)
                {
                    Caption = 'Remark';
                    ApplicationArea = All;
                }
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
        if "Split Status" = "Split Status"::Yes then
            Error('You cannot delete a Split Sample request.');

        SampleWasLineRec.Reset();
        SampleWasLineRec.SetRange("No.", "No.");
        SampleWasLineRec.SetRange("Line no.", "Line no.");
        if SampleWasLineRec.FindSet() then
            SampleWasLineRec.DeleteAll();
    end;

    var
        SOLineNo: Code[50];

    procedure Get_Count(): Integer
    var
        SampleReqLineRec: Record "Washing Sample Requsition Line";
    begin
        SampleReqLineRec.Reset();
        SampleReqLineRec.SetRange("No.", "No.");
        SampleReqLineRec.SetFilter("Line No.", '<>%1', "Line No.");

        if SampleReqLineRec.FindSet() then
            exit(SampleReqLineRec.Count)
        else
            exit(0);
    end;

}