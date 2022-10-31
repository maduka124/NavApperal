page 50662 "Cutting Progress Card"
{
    PageType = Card;
    SourceTable = CuttingProgressHeader;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("CutProNo."; "CutProNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Cutting Progress No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field(LaySheetNo; LaySheetNo)
                {
                    ApplicationArea = All;
                    Caption = 'Lay Sheet No';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        LaySheetHeaderRec: Record LaySheetHeader;
                        FabricReqRec: Record FabricRequsition;
                        RoleIssuNoteHeadRec: Record RoleIssuingNoteHeader;
                        RoleIssuNoteLineRec: Record RoleIssuingNoteLine;
                        LaySheetLine2Rec: Record LaySheetLine2;
                        CuttProgLineRec: Record CuttingProgressLine;
                        LineNo: Integer;
                    begin

                        LaySheetHeaderRec.Reset();
                        LaySheetHeaderRec.SetRange("LaySheetNo.", LaySheetNo);

                        if LaySheetHeaderRec.FindSet() then begin
                            "FabReqNo." := LaySheetHeaderRec."FabReqNo.";
                            "Item No" := LaySheetHeaderRec."Item No.";
                            "Item Name" := LaySheetHeaderRec."Item Name";
                            "Cut No." := LaySheetHeaderRec."Cut No.";
                            "Created Date" := Today;
                            "Created User" := UserId;
                            "Style Name" := LaySheetHeaderRec."Style Name";
                            "Style No." := LaySheetHeaderRec."Style No.";
                            "PO No." := LaySheetHeaderRec."PO No.";
                        end;

                        CurrPage.Update();

                        FabricReqRec.Reset();
                        FabricReqRec.SetRange("FabReqNo.", "FabReqNo.");

                        if FabricReqRec.FindSet() then begin

                            "Marker Name" := FabricReqRec."Marker Name";
                            "UOM Code" := FabricReqRec."UOM Code";
                            "UOM" := FabricReqRec."UOM";

                            LaySheetLine2Rec.Reset();
                            LaySheetLine2Rec.SetRange("LaySheetNo.", LaySheetNo);

                            if LaySheetLine2Rec.FindSet() then
                                "Marker Length" := LaySheetLine2Rec.LayLength;

                        end;


                        //Delete old lines
                        CuttProgLineRec.Reset();
                        CuttProgLineRec.SetRange("CutProNo.");
                        if CuttProgLineRec.FindSet() then
                            CuttProgLineRec.DeleteAll();

                        //Get  Roll issue ID
                        RoleIssuNoteHeadRec.Reset();
                        RoleIssuNoteHeadRec.SetRange("Req No.", "FabReqNo.");

                        if RoleIssuNoteHeadRec.FindSet() then begin

                            //Get Roll Issue lines
                            RoleIssuNoteLineRec.Reset();
                            RoleIssuNoteLineRec.SetRange("RoleIssuNo.", RoleIssuNoteHeadRec."RoleIssuNo.");

                            if RoleIssuNoteLineRec.FindSet() then begin

                                repeat

                                    //insert cutting progress lines
                                    LineNo += 1;
                                    CuttProgLineRec.Init();
                                    CuttProgLineRec."CutProNo." := "CutProNo.";
                                    CuttProgLineRec."Actual Plies" := 0;
                                    CuttProgLineRec.InvoiceNo := RoleIssuNoteLineRec.InvoiceNo;
                                    CuttProgLineRec."Item No" := RoleIssuNoteLineRec."Item No";
                                    CuttProgLineRec."Length Act" := RoleIssuNoteLineRec."Length Act";
                                    CuttProgLineRec."Length Allocated" := RoleIssuNoteLineRec."Length Allocated";
                                    CuttProgLineRec."Length Tag" := RoleIssuNoteLineRec."Length Tag";
                                    CuttProgLineRec."Line No." := LineNo;
                                    CuttProgLineRec."Location Name" := RoleIssuNoteLineRec."Location Name";
                                    CuttProgLineRec."Location No" := RoleIssuNoteLineRec."Location No";
                                    if "Marker Length" <> 0 then
                                        CuttProgLineRec."Planned Plies" := RoleIssuNoteLineRec."Length Act" Div "Marker Length";
                                    CuttProgLineRec."Role ID" := RoleIssuNoteLineRec."Role ID";
                                    CuttProgLineRec.Shade := RoleIssuNoteLineRec.Shade;
                                    CuttProgLineRec."Shade No" := RoleIssuNoteLineRec."Shade No";
                                    CuttProgLineRec."Supplier Batch No." := RoleIssuNoteLineRec."Supplier Batch No.";
                                    CuttProgLineRec."Width Act" := RoleIssuNoteLineRec."Width Act";
                                    CuttProgLineRec."Width Tag" := RoleIssuNoteLineRec."Width Tag";
                                    CuttProgLineRec.Insert();

                                until RoleIssuNoteLineRec.Next() = 0;

                            end;
                        end;

                        CurrPage.Update();

                    end;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("PO No."; "PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'PO No';
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item';
                }

                field("Cut No."; "Cut No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Cut No';
                }

                field("Marker Name"; "Marker Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Marker';
                }

                field("Marker Length"; "Marker Length")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("Roll Details")
            {
                part("Cutting Progress ListPart"; "Cutting Progress ListPart")
                {
                    ApplicationArea = All;
                    Caption = ' ';
                    SubPageLink = "CutProNo." = FIELD("CutProNo.");
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        CuttingProgressLineRec: Record CuttingProgressLine;
    begin
        CuttingProgressLineRec.reset();
        CuttingProgressLineRec.SetRange("CutProNo.", "CutProNo.");
        CuttingProgressLineRec.DeleteAll();
    end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."CutPro Nos.", xRec."CutProNo.", "CutProNo.") THEN BEGIN
            NoSeriesMngment.SetSeries("CutProNo.");
            EXIT(TRUE);
        END;
    end;
}