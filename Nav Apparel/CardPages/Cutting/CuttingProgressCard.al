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
                field("CutProNo."; rec."CutProNo.")
                {
                    ApplicationArea = All;
                    Caption = 'Cutting Progress No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field(LaySheetNo; rec.LaySheetNo)
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

                        LaySheetHeaderRec.Reset();
                        LaySheetHeaderRec.SetRange("LaySheetNo.", rec.LaySheetNo);

                        if LaySheetHeaderRec.FindSet() then begin
                            rec."FabReqNo." := LaySheetHeaderRec."FabReqNo.";
                            rec."Item No" := LaySheetHeaderRec."Item No.";
                            rec."Item Name" := LaySheetHeaderRec."Item Name";
                            rec."Cut No." := LaySheetHeaderRec."Cut No.";
                            rec."Created Date" := Today;
                            rec."Created User" := UserId;
                            rec."Style Name" := LaySheetHeaderRec."Style Name";
                            rec."Style No." := LaySheetHeaderRec."Style No.";
                            rec."PO No." := LaySheetHeaderRec."PO No.";
                        end;

                        CurrPage.Update();

                        FabricReqRec.Reset();
                        FabricReqRec.SetRange("FabReqNo.", rec."FabReqNo.");

                        if FabricReqRec.FindSet() then begin

                            rec."Marker Name" := FabricReqRec."Marker Name";
                            rec."UOM Code" := FabricReqRec."UOM Code";
                            rec."UOM" := FabricReqRec."UOM";

                            LaySheetLine2Rec.Reset();
                            LaySheetLine2Rec.SetRange("LaySheetNo.", rec.LaySheetNo);

                            if LaySheetLine2Rec.FindSet() then
                                rec."Marker Length" := LaySheetLine2Rec.LayLength;

                        end;


                        //Delete old lines
                        CuttProgLineRec.Reset();
                        CuttProgLineRec.SetRange("CutProNo.");
                        if CuttProgLineRec.FindSet() then
                            CuttProgLineRec.DeleteAll();

                        //Get  Roll issue ID
                        RoleIssuNoteHeadRec.Reset();
                        RoleIssuNoteHeadRec.SetRange("Req No.", rec."FabReqNo.");

                        if RoleIssuNoteHeadRec.FindSet() then begin

                            //Get Roll Issue lines
                            RoleIssuNoteLineRec.Reset();
                            RoleIssuNoteLineRec.SetRange("RoleIssuNo.", RoleIssuNoteHeadRec."RoleIssuNo.");
                            RoleIssuNoteLineRec.SetFilter(Selected, '=%1', true);

                            if RoleIssuNoteLineRec.FindSet() then begin

                                repeat

                                    //insert cutting progress lines
                                    LineNo += 1;
                                    CuttProgLineRec.Init();
                                    CuttProgLineRec."CutProNo." := rec."CutProNo.";
                                    CuttProgLineRec."Actual Plies" := 0;
                                    CuttProgLineRec.InvoiceNo := RoleIssuNoteLineRec.InvoiceNo;
                                    CuttProgLineRec."Item No" := RoleIssuNoteLineRec."Item No";
                                    CuttProgLineRec."Length Act" := RoleIssuNoteLineRec."Length Act";
                                    CuttProgLineRec."Length Allocated" := RoleIssuNoteLineRec."Length Allocated";
                                    CuttProgLineRec."Length Tag" := RoleIssuNoteLineRec."Length Tag";
                                    CuttProgLineRec."Line No." := LineNo;
                                    CuttProgLineRec."Location Name" := RoleIssuNoteLineRec."Location Name";
                                    CuttProgLineRec."Location No" := RoleIssuNoteLineRec."Location No";
                                    if rec."Marker Length" <> 0 then
                                        CuttProgLineRec."Planned Plies" := RoleIssuNoteLineRec."Length Act" Div rec."Marker Length";
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

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Style';
                }

                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'PO No';
                }

                field("Item Name"; rec."Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item';
                }

                field("Cut No."; rec."Cut No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Cut No';
                }

                field("Marker Name"; rec."Marker Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Marker';
                }

                field("Marker Length"; rec."Marker Length")
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
        CuttingProgressLineRec.SetRange("CutProNo.", rec."CutProNo.");
        CuttingProgressLineRec.DeleteAll();
    end;


    procedure AssistEdit(): Boolean
    var
        NavAppSetup: Record "NavApp Setup";
        NoSeriesMngment: Codeunit NoSeriesManagement;
    begin
        NavAppSetup.Get('0001');
        IF NoSeriesMngment.SelectSeries(NavAppSetup."CutPro Nos.", xRec."CutProNo.", rec."CutProNo.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."CutProNo.");
            EXIT(TRUE);
        END;
    end;
}