page 51438 WashDeleveryListpart
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

                field(SampleType; rec.SampleType)
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type';

                    trigger OnValidate()
                    var
                        SampleTyprRec: Record "Sample Type";
                        SampleReqHrdRec: Record "Washing Sample Header";
                    begin

                        if Rec.SampleType = 'BULK' then
                            EditableGB := false;

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

                        if Rec.SampleType = 'BULK' then
                            EditableGB := false;

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
                    Editable = EditableGB;

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
                                Rec."Order Type" := Rec."Order Type"::Received;
                            end;
                        end
                        else begin
                            ColorRec.Reset();
                            ColorRec.FindSet();
                            if Page.RunModal(51036, ColorRec) = Action::LookupOK then begin
                                rec."Color Code" := ColorRec."No.";
                                rec."Color Name" := ColorRec."Colour Name";
                                Rec."Order Type" := Rec."Order Type"::Received;
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

                field("Delivery Qty"; Rec."Delivery Qty")
                {
                    ApplicationArea = All;

                }

                field(RemarkLine; rec.RemarkLine)
                {
                    Caption = 'Remark';
                    ApplicationArea = All;
                }
            }
        }
    }

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
        EditableGB: Boolean;

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

    trigger OnAfterGetRecord()
    var
        WashReqHeaderRec: Record WashDeliveryHeaderTbl;
    begin

        WashReqHeaderRec.Reset();
        WashReqHeaderRec.SetRange("No.", Rec."No.");

        if WashReqHeaderRec.FindSet() then
            if WashReqHeaderRec."Sample/Bulk" <> WashReqHeaderRec."Sample/Bulk"::Sample then
                EditableGB := false
            else
                EditableGB := true;
    end;

    trigger OnOpenPage()
    var
        WashReqHeaderRec: Record WashDeliveryHeaderTbl;
        WashSampleLineRec: Record "Washing Sample Requsition Line";
    begin

        WashReqHeaderRec.Reset();
        WashReqHeaderRec.SetRange("No.", Rec."No.");

        if WashReqHeaderRec.FindSet() then
            if WashReqHeaderRec."Sample/Bulk" <> WashReqHeaderRec."Sample/Bulk"::Sample then
                EditableGB := false
            else
                EditableGB := true;
    end;
}