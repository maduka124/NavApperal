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

            group("AW Defect ")
            {
                part(aWQualityChecklist2; aWQualityChecklist2)
                {
                    ApplicationArea = all;
                    Caption = '  ';
                    SubPageLink = No = field("No."), "Sample Req No" = field("Sample Req No"), "Line No. Header" = field("Line No");
                }

            }
            group("AW Quality Result")
            {
                field("Pass Qty"; "Pass Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        intermidiateRec: Record IntermediateTable;
                        "Total Pass Qty": Integer;
                        "Total Fail Qty": Integer;
                    begin
                        intermidiateRec.Reset();
                        intermidiateRec.SetRange(No, "Sample Req No");
                        intermidiateRec.SetRange("Line no", "Line No");
                        intermidiateRec.SetRange("Split No", "Split No");

                        if intermidiateRec.FindSet() then begin
                            if "Pass Qty" > intermidiateRec."Split Qty" then
                                Error('Pass qty must be less than or qual to split qty');

                            if "Pass Qty" <= intermidiateRec."Split Qty" then begin
                                "Fail Qty" := intermidiateRec."Split Qty" - "Pass Qty";

                                "Total Pass Qty" := intermidiateRec."AW QC Pass Qty " + "Pass Qty";
                                "Total Fail Qty" := intermidiateRec."AW QC Fail Qty" + "Fail Qty";

                                if "Total Pass Qty" > intermidiateRec."Split Qty" then
                                    Error('Total pass qty should be less than or equal to Split Qty');

                                if "Total Fail Qty" > intermidiateRec."Split Qty" then
                                    Error('Total fail qty should be less than or equal to Split Qty');

                                CurrPage.Update();
                            end;
                        end;

                    end;

                }

                field("Fail Qty"; "Fail Qty")
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
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

                trigger OnAction()
                var
                    QCLine2AWRec: Record AWQualityCheckLine;
                    intermediateRec: Record IntermediateTable;
                    QCLine2AWRec2: Record AWQualityCheckLine;
                    washSampleReqLineRec: Record "Washing Sample Requsition Line";
                    Total: Integer;
                    QUantity: Integer;
                    "Total Pass Qty": Integer;
                    "Total Fail Qty": Integer;
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

                            Message('=%1', Total);

                            if Total > intermediateRec."Split Qty" then
                                Error('Total Defect quantity must be equal to the Split Qty.');

                            "Total Pass Qty" := intermediateRec."AW QC Pass Qty " + "Pass Qty";
                            "Total Fail Qty" := intermediateRec."AW QC Fail Qty" + "Fail Qty";

                            if "Total Pass Qty" > intermediateRec."Split Qty" then
                                Error('Total pass qty should be less than or equal to Split Qty');

                            if "Total Fail Qty" > intermediateRec."Split Qty" then
                                Error('Total fail qty should be less than or equal to Split Qty');

                            WashsamplereqlineRec.Reset();
                            WashsamplereqlineRec.SetRange("No.", "Sample Req No");
                            WashsamplereqlineRec.SetRange("Line no.", "Line No");
                            WashsamplereqlineRec.FindSet();

                            if WashsamplereqlineRec.FindSet() then begin
                                WashsamplereqlineRec."QC Pass Qty (AW)" := WashsamplereqlineRec."QC Pass Qty (AW)" + "Pass Qty";
                                WashsamplereqlineRec."QC Fail Qty (AW)" := WashsamplereqlineRec."QC Pass Qty (AW)" + "Fail Qty";
                                intermediateRec."AW QC Pass Qty " := intermediateRec."AW QC Pass Qty " + "Pass Qty";
                                intermediateRec."AW QC Fail Qty" := intermediateRec."AW QC Fail Qty" + "Fail Qty";
                            end;

                            WashsamplereqlineRec."QC Date (AW)" := "QC AW Date";
                            WashsamplereqlineRec.Modify();
                            intermediateRec.Modify();

                            Status := Status::Posted;
                            CurrPage.Editable(false);
                            CurrPage.Update();
                            Message('Quality checking posted.');
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