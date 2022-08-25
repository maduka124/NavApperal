page 50754 BWQualityCheck
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = BWQualityCheckHeader;
    Caption = 'Before Wash Quality Check';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'BW Quality Check No';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field("Sample Req No"; "Sample Req No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashingSampleReqLine: Record "Washing Sample Requsition Line";
                    begin

                        WashingSampleReqLine.Reset();
                        WashingSampleReqLine.SetRange("No.", "Sample Req No");

                        if WashingSampleReqLine.Findset() then begin
                            if WashingSampleReqLine."Split Status" = WashingSampleReqLine."Split Status"::Yes then
                                Error('Sample request has been split. You cannot perform BW Quality Check.');

                            "Line No" := WashingSampleReqLine."Line no.";
                            "BW QC Date" := WorkDate();
                            CurrPage.Update();
                        end;
                    end;
                }

                field("BW QC Date"; "BW QC Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group("BW Details")
            {
                part("BWQualityline1"; BWQualityCheckline1)
                {
                    ApplicationArea = All;
                    Caption = 'Sample Item Details';
                    SubPageLink = "No." = field("Sample Req No");
                }
            }

            group("BW Quality Status")
            {
                part("BW Quality Status1"; BWQualityCheckLine2)
                {
                    ApplicationArea = All;
                    Caption = '  ';
                    SubPageLink = No = field("No.");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Post")
            {
                ApplicationArea = All;
                Image = Post;

                trigger OnAction();
                var
                    BWQualityCheckline2: Record BWQualityLine2;
                    WashsamplereqlineRec: Record "Washing Sample Requsition Line";
                    Total: Integer;
                begin

                    if Status = Status::Posted then
                        Error('Entry already posted.');

                    WashsamplereqlineRec.Reset();
                    WashsamplereqlineRec.SetRange("No.", "Sample Req No");
                    WashsamplereqlineRec.SetRange("Line no.", "Line No");

                    if WashsamplereqlineRec.FindSet() then begin

                        Total := 0;
                        BWQualityCheckline2.Reset();
                        BWQualityCheckline2.SetRange("No", "No.");

                        if BWQualityCheckline2.FindSet() then begin
                            repeat
                                Total += BWQualityCheckline2.Qty;
                            until BWQualityCheckline2.Next() = 0;

                            if Total <> WashSampleReqlineRec."Req Qty" then
                                Error('Total pass/fail quantity must be equal to the sample requested qty.');
                        end
                        else
                            Error('Cannot find pass/fail entries.');

                        if Total = WashSampleReqlineRec."Req Qty" then begin

                            BWQualityCheckline2.Reset();
                            BWQualityCheckline2.SetRange("No", "No.");
                            BWQualityCheckline2.SetFilter(Status, '%1', BWQualityCheckline2.Status::Pass);

                            if BWQualityCheckline2.FindSet() then begin
                                WashsamplereqlineRec."Req Qty BW QC Pass" := WashsamplereqlineRec."Req Qty BW QC Pass" + BWQualityCheckline2.Qty;
                                WashsamplereqlineRec."Req Qty BW QC Fail" := WashsamplereqlineRec."Req Qty BW QC Fail" + Total - BWQualityCheckline2.Qty;
                            end
                            else begin
                                WashsamplereqlineRec."Req Qty BW QC Pass" := WashsamplereqlineRec."Req Qty BW QC Pass" + 0;
                                WashsamplereqlineRec."Req Qty BW QC Fail" := WashsamplereqlineRec."Req Qty BW QC Fail" + Total;
                            end;

                            WashsamplereqlineRec."BW QC Date" := "BW QC Date";
                            WashsamplereqlineRec.Modify();

                            Status := Status::Posted;
                            CurrPage.Editable(false);
                            CurrPage.Update();

                            Message('Quality checking posted.');

                        end;
                    end
                    else
                        Error('Cannot find sample request details.');
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."BW Wash Quality", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        BWQualityCheckLineRec: Record BWQualityLine2;
    begin

        BWQualityCheckLineRec.Reset();
        BWQualityCheckLineRec.SetRange("No", "No.");
        if BWQualityCheckLineRec.FindSet() then
            BWQualityCheckLineRec.DeleteAll();

    end;

    trigger OnOpenPage()
    var

    begin
        if Status = Status::Posted then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);
    end;
}