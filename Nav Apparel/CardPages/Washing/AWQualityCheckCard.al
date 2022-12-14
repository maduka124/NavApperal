page 50687 QCHeaderCardAW
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = AWQualityCheckHeader;
    Caption = 'After Wash Quality Check';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'AW Quality Check No';
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }              

                field("Job Card No"; "Job Card No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        jobcreaationRec: Record JobCreationLine;
                    begin
                        jobcreaationRec.Reset();
                        jobcreaationRec.SetRange("Job Card (Prod Order)", "JoB Card No");

                        if jobcreaationRec.FindSet() then begin
                            CustomerCode := jobcreaationRec.BuyerCode;
                            CustomerName := jobcreaationRec.BuyerName;
                            "Req Date" := jobcreaationRec."Req Date";
                            "Line No" := jobcreaationRec."Line No";
                            "Sample Req No" := jobcreaationRec.No;
                            "Split No" := jobcreaationRec."Split No";
                            "QC AW Date" := WorkDate();
                        end
                        else
                            Error('Invalid Job Card no.');
                    end;
                }

                field("Sample Req No"; "Sample Req No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(CustomerName; CustomerName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Customer';
                }

                field("Req date"; "Req date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("QC AW Date"; "QC AW Date")
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    ApplicationArea = All;
                }

            }

            group("Request Details")
            {
                part("aWQualityChecklist1"; aWQualityChecklist1)
                {
                    ApplicationArea = all;
                    Caption = ' ';
                    SubPageLink = No = field("Sample Req No"), "Line No" = field("Line No"), "Split No" = field("Split No");
                }
            }

            group("AW Quality Status")
            {
                part(aWQualityChecklist2; aWQualityChecklist2)
                {
                    ApplicationArea = all;
                    Caption = '  ';
                    SubPageLink = No = field("No."), "Sample Req No" = field("Sample Req No"), "Line No. Header" = field("Line No");
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

                trigger OnAction()
                var
                    QCLine2AWRec: Record AWQualityCheckLine;
                    intermediateRec: Record IntermediateTable;
                    QCLine2AWRec2: Record AWQualityCheckLine;
                    washSampleReqLineRec: Record "Washing Sample Requsition Line";
                    Total: Integer;
                    QUantity: Integer;
                begin

                    if Status = Status::Posted then
                        Error('Entry already posted.');

                    QCLine2AWRec.Reset();
                    QCLine2AWRec.SetRange(No, "No.");

                    if QCLine2AWRec.FindSet() then begin

                        intermediateRec.Reset();
                        intermediateRec.SetRange(No, QCLine2AWRec."Sample Req No");
                        intermediateRec.SetRange("Line No", QCLine2AWRec."Line No. Header");
                        intermediateRec.SetRange("Split No", QCLine2AWRec."Split No");

                        if intermediateRec.FindSet() then begin
                            repeat
                                Total += QCLine2AWRec.Qty;
                            until (QCLine2AWRec.Next() = 0);

                            if Total <> intermediateRec."Split Qty" then
                                Error('Total pass/fail quantity must be equal to the Job Card Qty.');

                            if Total = intermediateRec."Split Qty" then begin

                                QCLine2AWRec2.Reset();
                                QCLine2AWRec2.SetRange(No, "No.");
                                QCLine2AWRec2.SetRange("Line No. Header", "Line No");
                                QCLine2AWRec.SetFilter(Status, '=%1', QCLine2AWRec2.Status::Pass);
                                QCLine2AWRec.FindSet();

                                WashsamplereqlineRec.Reset();
                                WashsamplereqlineRec.SetRange("No.", "Sample Req No");
                                WashsamplereqlineRec.SetRange("Line no.", "Line No");
                                WashsamplereqlineRec.FindSet();

                                if WashsamplereqlineRec.FindSet() then begin
                                    WashsamplereqlineRec."QC Pass Qty (AW)" := QCLine2AWRec.Qty;
                                    WashsamplereqlineRec."QC Fail Qty (AW)" := Total - QCLine2AWRec.Qty;
                                    intermediateRec."AW QC Pass Qty " := QCLine2AWRec2.Qty;
                                    intermediateRec."AW QC Fail Qty" := Total - QCLine2AWRec.Qty;
                                end
                                else begin
                                    WashsamplereqlineRec."QC Pass Qty (AW)" := 0;
                                    WashsamplereqlineRec."QC Fail Qty (AW)" := Total;
                                    intermediateRec."AW QC Pass Qty " := 0;
                                    intermediateRec."AW QC Fail Qty" := Total;
                                end;

                                WashsamplereqlineRec."QC Date (AW)" := "QC AW Date";
                                WashsamplereqlineRec.Modify();
                                intermediateRec.Modify();

                                Status := Status::Posted;
                                CurrPage.Editable(false);
                                CurrPage.Update();
                                Message('Quality checking posted.');

                            end;
                        end
                        else
                            Error('Cannot find Job Card details.');
                    end
                    else
                        Error('Cannot find pass/fail entries.');
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."QC AW No", xRec."No.", "No.") THEN BEGIN
            NoSeriesMngment.SetSeries("No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        AWQualityCheckLineRec: Record AWQualityCheckLine;
    begin
        AWQualityCheckLineRec.Reset();
        AWQualityCheckLineRec.SetRange(No, "No.");
        if AWQualityCheckLineRec.FindSet() then
            AWQualityCheckLineRec.DeleteAll();
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