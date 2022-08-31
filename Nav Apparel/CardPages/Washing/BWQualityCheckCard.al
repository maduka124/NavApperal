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
                field("Pass Qty"; "Pass Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        "Total Qty": Integer;
                        "Total Fail Qty": Integer;
                        WashsamplereqlineRec: Record "Washing Sample Requsition Line";
                    begin
                        WashsamplereqlineRec.Reset();
                        WashsamplereqlineRec.SetRange("No.", "Sample Req No");
                        WashsamplereqlineRec.SetRange("Line no.", "Line No");

                        if WashsamplereqlineRec.FindSet() then begin
                            if WashsamplereqlineRec."Req Qty" < "Pass Qty" then
                                Error('Pass quantity must be less then or equal to Req qty');

                            if WashsamplereqlineRec."Req Qty" >= "Pass Qty" then begin
                                "Fail Qty" := WashsamplereqlineRec."Req Qty" - "Pass Qty";

                                "Total Qty" := WashsamplereqlineRec."Req Qty BW QC Pass" + "Pass Qty";
                                "Total Fail Qty" := WashsamplereqlineRec."Req Qty BW QC Fail" + "Fail Qty";

                                if WashsamplereqlineRec."Req Qty" < "Total Qty" then
                                    Error('Total Pass Qty Should be less than qual to Req qty');

                                if WashsamplereqlineRec."Req Qty" < "Total Fail Qty" then
                                    Error('Total Fail Qty Should be less than qual to Req qty');

                                CurrPage.Update();
                            end;
                        end;
                    end;
                }

                field("Fail Qty"; "Fail Qty")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Remarks; Remarks)
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
                    BWQualityCheckline2: Record BWQualityLine2;
                    WashsamplereqlineRec: Record "Washing Sample Requsition Line";
                    Total: Integer;
                    "Total Qty": Integer;
                    "Total Fail Qty": Integer;
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

                            if Total > WashSampleReqlineRec."Req Qty" then
                                Error('Total defects quantity should be less than sample requested qty.');
                        end;

                        WashsamplereqlineRec."Req Qty BW QC Pass" := "Pass Qty" + WashsamplereqlineRec."Req Qty BW QC Pass";
                        WashsamplereqlineRec."Req Qty BW QC Fail" := "Fail Qty" + WashsamplereqlineRec."Req Qty BW QC Fail";

                        "Total Qty" := WashsamplereqlineRec."Req Qty BW QC Pass" + "Pass Qty";
                        "Total Fail Qty" := WashsamplereqlineRec."Req Qty BW QC Fail" + "Fail Qty";

                        if WashsamplereqlineRec."Req Qty" < "Total Qty" then
                            Error('Total Pass Qty Should be less than  or qual to Req qty');

                        if WashsamplereqlineRec."Req Qty" < "Total Fail Qty" then
                            Error('Total Fail Qty Should be less than Or qual to Req qty');

                        WashsamplereqlineRec."BW QC Date" := "BW QC Date";
                        WashsamplereqlineRec.Modify();

                        Status := Status::Posted;
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."BW Wash Quality", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        BWQualityCheckLineRec: Record BWQualityLine2;
    begin

        if Status = Status::Posted then
            Error('Entry already posted. Cannot delete.');

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