page 50679 RTCBWCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = RTCBWHeader;
    Caption = 'Return to Customer (Before Wash)';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Caption = 'Document No';
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Req No"; "Req No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        SampleReqLine: Record "Washing Sample Requsition Line";
                    begin
                        SampleReqLine.Reset();
                        SampleReqLine.SetRange("No.", "Req No");

                        if SampleReqLine.FindSet() then begin

                            if SampleReqLine."Req Qty BW QC Fail" = 0 then
                                Error('Before wash quality checking has not been performed for this request.');

                            "Req Line" := SampleReqLine."Line no.";
                            "CusTomer Code" := SampleReqLine."Buyer No";
                            "CusTomer Name" := SampleReqLine."Buyer";
                            "Req Date" := SampleReqLine."Req Date";
                        end;

                        CurrPage.Update();
                    end;
                }

                field("CusTomer Name"; "CusTomer Name")
                {
                    Caption = 'Customer';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Req Date"; "Req Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Gate Pass"; "Gate Pass")
                {
                    Caption = 'Gate Pass';
                    ApplicationArea = All;
                }
            }

            group(" ")
            {
                part(RTCBWListPart; RTCBWListPart)
                {
                    ApplicationArea = All;
                    Caption = 'Return Qty';
                    SubPageLink = "No." = field("No."), "Req No" = field("Req No");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Mark as Return")
            {
                ApplicationArea = All;
                Image = Return;

                trigger OnAction()
                var
                    Samplereqline: Record "Washing Sample Requsition Line";
                    ReturnTocustomerLine: Record RTCBWLine;
                    QtyFail: Integer;
                    QtyRet: Integer;
                begin
                    Samplereqline.Reset();
                    Samplereqline.SetRange("No.", "Req No");

                    if Samplereqline.FindSet() then begin

                        QtyFail := Samplereqline."Req Qty BW QC Fail";
                        QtyRet := Samplereqline."Return Qty (BW)";

                        ReturnTocustomerLine.Reset();
                        ReturnTocustomerLine.SetRange("No.", "No.");

                        if ReturnTocustomerLine.FindSet() then begin
                            if QtyFail < (QtyRet + ReturnTocustomerLine.Qty) then
                                Error('total return qty is greater than the quality failed qty');

                            Samplereqline."Return Qty (BW)" += ReturnTocustomerLine.Qty;
                            Samplereqline.Modify();
                            Message('Return qty updated');
                        end
                        else
                            Error('Cannot find return qty.');
                    end
                    else
                        Error('Cannot find request details.');
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."TRCBW No", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        RTCBWLineRec: Record RTCBWLine;
        Samplereqline: Record "Washing Sample Requsition Line";
    begin
        Samplereqline.Reset();
        Samplereqline.SetRange("No.", "Req No");

        if Samplereqline.FindSet() then
            if Samplereqline."Return Qty (BW)" > 0 then
                Error('Returned quantity updated. Cannot delete.');

        RTCBWLineRec.Reset();
        RTCBWLineRec.SetRange("No.", "No.");
        if RTCBWLineRec.FindSet() then
            RTCBWLineRec.DeleteAll();
    end;
}