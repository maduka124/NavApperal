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
                field("No."; rec."No.")
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

                field("Sample Req No"; rec."Sample Req No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashingSampleReqLine: Record "Washing Sample Requsition Line";
                    begin

                        WashingSampleReqLine.Reset();
                        WashingSampleReqLine.SetRange("No.", rec."Sample Req No");

                        if WashingSampleReqLine.Findset() then begin
                            if WashingSampleReqLine."Split Status" = WashingSampleReqLine."Split Status"::Yes then
                                Error('Sample request has been split. You cannot perform BW Quality Check.');

                            rec."Line No" := WashingSampleReqLine."Line no.";
                            rec."BW QC Date" := WorkDate();
                            CurrPage.Update();
                        end;
                    end;
                }

                field("BW QC Date"; rec."BW QC Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Status; rec.Status)
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

            group("BW Defect ")
            {
                part("BW Quality Status1"; BWQualityCheckLine2)
                {
                    ApplicationArea = All;
                    Caption = '  ';
                    SubPageLink = No = field("No.");
                }
            }

            group("BW Quality Result")
            {
                field("Pass Qty"; rec."Pass Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        "Total Pass Qty": Integer;
                        "Total Fail Qty": Integer;
                        WashsamplereqlineRec: Record "Washing Sample Requsition Line";
                    begin
                        WashsamplereqlineRec.Reset();
                        WashsamplereqlineRec.SetRange("No.", rec."Sample Req No");
                        WashsamplereqlineRec.SetRange("Line no.", rec."Line No");

                        if WashsamplereqlineRec.FindSet() then begin
                            if WashsamplereqlineRec."Req Qty" < rec."Pass Qty" then
                                Error('Pass quantity must be less then or equal to Req qty');

                            if WashsamplereqlineRec."Req Qty" >= rec."Pass Qty" then begin
                                rec."Fail Qty" := WashsamplereqlineRec."Req Qty" - rec."Pass Qty";

                                "Total Pass Qty" := WashsamplereqlineRec."Req Qty BW QC Pass" + rec."Pass Qty";
                                "Total Fail Qty" := WashsamplereqlineRec."Req Qty BW QC Fail" + rec."Fail Qty";

                                if WashsamplereqlineRec."Req Qty" < "Total Pass Qty" then
                                    Error('Total Pass Qty should be less than or equal to Req qty');

                                if WashsamplereqlineRec."Req Qty" < "Total Fail Qty" then
                                    Error('Total Fail Qty should be less than or equal to Req qty');

                                CurrPage.Update();
                            end;
                        end;
                    end;
                }

                field("Fail Qty"; rec."Fail Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Remarks; rec.Remarks)
                {
                    ApplicationArea = all;
                    Caption = 'Comment';
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
                    WashsamplereqlineRec: Record "Washing Sample Requsition Line";
                    Total: Integer;
                    "Total Pass Qty": Integer;
                    "Total Fail Qty": Integer;
                begin

                    if rec.Status = rec.Status::Posted then
                        Error('Entry already posted.');

                    WashsamplereqlineRec.Reset();
                    WashsamplereqlineRec.SetRange("No.", rec."Sample Req No");
                    WashsamplereqlineRec.SetRange("Line no.", rec."Line No");

                    if WashsamplereqlineRec.FindSet() then begin

                        Total := 0;
                        // BWQualityCheckline2.Reset();
                        // BWQualityCheckline2.SetRange("No", "No.");

                        // if BWQualityCheckline2.FindSet() then begin
                        //     repeat
                        //         Total += BWQualityCheckline2.Qty;
                        //     until BWQualityCheckline2.Next() = 0;

                        //     if Total > WashSampleReqlineRec."Req Qty" then
                        //         Error('Total defects quantity should be less than sample requested qty.');
                        // end;

                        "Total Pass Qty" := WashsamplereqlineRec."Req Qty BW QC Pass" + rec."Pass Qty";
                        "Total Fail Qty" := WashsamplereqlineRec."Req Qty BW QC Fail" + rec."Fail Qty";

                        WashsamplereqlineRec."Req Qty BW QC Pass" := rec."Pass Qty" + WashsamplereqlineRec."Req Qty BW QC Pass";
                        WashsamplereqlineRec."Req Qty BW QC Fail" := rec."Fail Qty" + WashsamplereqlineRec."Req Qty BW QC Fail";

                        if WashsamplereqlineRec."Req Qty" < "Total Pass Qty" then
                            Error('Total Pass Qty should be less than or equal to Req qty');

                        if WashsamplereqlineRec."Req Qty" < "Total Fail Qty" then
                            Error('Total Fail Qty should be less than or equal to Req qty');

                        WashsamplereqlineRec."BW QC Date" := rec."BW QC Date";
                        WashsamplereqlineRec.Modify();

                        rec.Status := rec.Status::Posted;
                        CurrPage.Editable(false);
                        CurrPage.Update();

                        Message('Quality checking posted.');
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."BW Wash Quality", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        BWQualityCheckLineRec: Record BWQualityLine2;
    begin

        if rec.Status = rec.Status::Posted then
            Error('Entry already posted. Cannot delete.');

        BWQualityCheckLineRec.Reset();
        BWQualityCheckLineRec.SetRange("No", rec."No.");
        if BWQualityCheckLineRec.FindSet() then
            BWQualityCheckLineRec.DeleteAll();

    end;

    trigger OnOpenPage()
    var

    begin
        if rec.Status = rec.Status::Posted then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);
    end;
}