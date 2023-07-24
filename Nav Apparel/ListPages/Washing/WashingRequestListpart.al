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
                field("Line no."; rec."Line no.")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
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

                field(SampleType; rec.SampleType)
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type';

                    trigger OnValidate()
                    var
                        SampleTyprRec: Record "Sample Type";
                        SampleReqHrdRec: Record "Washing Sample Header";
                    begin

                        SampleTyprRec.Reset();
                        SampleTyprRec.SetRange("Sample Type Name", rec.SampleType);

                        if SampleTyprRec.FindSet() then
                            rec."Sample No." := SampleTyprRec."No."
                        else
                            Error('Invalid Sample No');

                        SampleReqHrdRec.Get(rec."No.");
                        rec."Style No." := SampleReqHrdRec."Style No.";
                        rec."Style_PO No" := SampleReqHrdRec."PO No";
                        rec."Style Name" := SampleReqHrdRec."Style Name";
                        rec."Wash Plant Name" := SampleReqHrdRec."Wash Plant Name";
                        rec.Buyer := SampleReqHrdRec."Buyer Name";
                        rec."Buyer No" := SampleReqHrdRec."Buyer No.";
                        rec."Gament Type" := SampleReqHrdRec."Garment Type Name";
                        rec."Factory Name" := SampleReqHrdRec."Wash Plant Name";
                        rec."Location Code" := SampleReqHrdRec."Wash Plant No.";
                        rec."Req Date" := SampleReqHrdRec."Req Date";

                        CurrPage.Update();

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field("Wash Type"; rec."Wash Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashtypeRec: record "Wash Type";
                    begin
                        WashtypeRec.Reset();
                        WashtypeRec.SetRange("Wash Type Name", rec."Wash Type");
                        if WashtypeRec.FindSet() then
                            rec."Wash Type No." := WashtypeRec."No."
                        else
                            Error('Invalid Wash Type');

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');

                    end;
                }

                field("Fabric Description"; rec."Fabric Description")
                {
                    ApplicationArea = All;
                    Caption = 'Fabrication';

                    trigger OnValidate()
                    var
                        ItemRec: Record Item;
                    begin
                        ItemRec.Reset();
                        ItemRec.SetRange(Description, rec."Fabric Description");
                        if ItemRec.FindSet() then begin
                            rec."Fabrication No." := ItemRec."No.";
                        end
                        else
                            Error('Invalid Fabrication');

                        if Get_Count() = 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field("Color Name"; rec."Color Name")
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
                            if Page.RunModal(51065, StyleColorRec) = Action::LookupOK then begin
                                rec."Color Code" := StyleColorRec."Color No.";
                                rec."Color Name" := StyleColorRec.Color;
                            end;
                        end
                        else begin
                            ColorRec.Reset();
                            ColorRec.FindSet();
                            if Page.RunModal(51036, ColorRec) = Action::LookupOK then begin
                                rec."Color Code" := ColorRec."No.";
                                rec."Color Name" := ColorRec."Colour Name";
                            end;
                        end;
                    end;

                    trigger OnValidate()
                    var
                        StyleColorRec: Record StyleColor;
                    begin

                        StyleColorRec.Reset();
                        StyleColorRec.SetRange(Color, Rec."Color Name");

                        if not StyleColorRec.FindSet() then
                            Error('Invalid Color');

                    end;

                }

                field(Size; rec.Size)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        AssortmentDetailsInseamRec: Record AssortmentDetailsInseam;
                    begin

                        AssortmentDetailsInseamRec.Reset();
                        AssortmentDetailsInseamRec.SetRange("GMT Size", Rec.Size);

                        if not AssortmentDetailsInseamRec.FindSet() then
                            Error('Invalid Size');

                    end;
                }

                field("Req Qty"; rec."Req Qty")
                {
                    ApplicationArea = All;

                    Caption = 'Req Qty';
                    trigger OnValidate()
                    var
                    begin
                        rec.Value := rec."Unite Price" * rec."Req Qty";
                    end;
                }

                field("Req Date"; rec."Req Date")
                {
                    ApplicationArea = All;
                    Editable = false;
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

                field("Unite Price"; rec."Unite Price")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        rec.Value := rec."Unite Price" * rec."Req Qty";
                    end;
                }

                field(Value; rec.Value)
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("BW QC Date"; rec."BW QC Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Req Qty BW QC Pass"; rec."Req Qty BW QC Pass")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'BW QC Pass Qty';
                }

                field("Req Qty BW QC Fail"; rec."Req Qty BW QC Fail")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'BW QC Failed Qty';
                }

                field("Return Qty (BW)"; rec."Return Qty (BW)")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'BW Returned Qty';
                }

                field("AW QC Date"; rec."QC Date (AW)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("QC Pass Qty (AW)"; rec."QC Pass Qty (AW)")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'AW QC Pass Qty';
                }

                field("QC Fail Qty (AW)"; rec."QC Fail Qty (AW)")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'AW QC Failed Qty';
                }

                field("Return Qty (AW)"; rec."Return Qty (AW)")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'AW Returned Qty';
                }

                field("Dispatch Qty"; rec."Dispatch Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Final Dispatch Qty';
                }

                field(RemarkLine; rec.RemarkLine)
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."Wash Sample Nos.", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        SampleWasLineRec: Record "Washing Sample Requsition Line";
    begin
        if rec."Split Status" = rec."Split Status"::Yes then
            Error('You cannot delete a Split Sample request.');

        SampleWasLineRec.Reset();
        SampleWasLineRec.SetRange("No.", rec."No.");
        SampleWasLineRec.SetRange("Line no.", rec."Line no.");
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
        SampleReqLineRec.SetRange("No.", rec."No.");
        SampleReqLineRec.SetFilter("Line No.", '<>%1', rec."Line No.");

        if SampleReqLineRec.FindSet() then
            exit(SampleReqLineRec.Count)
        else
            exit(0);
    end;

}