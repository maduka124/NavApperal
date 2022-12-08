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
                field("No."; rec."No.")
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

                field("Job Card No"; rec."Job Card No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        jobcreaationRec: Record JobCreationLine;
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


                        jobcreaationRec.Reset();
                        jobcreaationRec.SetRange("Job Card (Prod Order)", rec."JoB Card No");

                        if jobcreaationRec.FindSet() then begin
                            rec.CustomerCode := jobcreaationRec.BuyerCode;
                            rec.CustomerName := jobcreaationRec.BuyerName;
                            rec."Req Date" := jobcreaationRec."Req Date";
                            rec."Line No" := jobcreaationRec."Line No";
                            rec."Sample Req No" := jobcreaationRec.No;
                            rec."Split No" := jobcreaationRec."Split No";
                            rec."QC AW Date" := WorkDate();
                        end
                        else
                            Error('Invalid Job Card no.');
                    end;
                }

                field("Sample Req No"; rec."Sample Req No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(CustomerName; rec.CustomerName)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Customer';
                }

                field("Req date"; rec."Req date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("QC AW Date"; rec."QC AW Date")
                {
                    ApplicationArea = All;
                }

                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = true;
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
                field("Pass Qty"; rec."Pass Qty")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        intermidiateRec: Record IntermediateTable;
                        "Total Pass Qty": Integer;
                        "Total Fail Qty": Integer;
                    begin
                        intermidiateRec.Reset();
                        intermidiateRec.SetRange(No, rec."Sample Req No");
                        intermidiateRec.SetRange("Line no", rec."Line No");
                        intermidiateRec.SetRange("Split No", rec."Split No");

                        if intermidiateRec.FindSet() then begin
                            if rec."Pass Qty" > intermidiateRec."Split Qty" then
                                Error('Pass qty must be less than or equal to job card qty');

                            if rec."Pass Qty" <= intermidiateRec."Split Qty" then begin
                                rec."Fail Qty" := intermidiateRec."Split Qty" - rec."Pass Qty";

                                "Total Pass Qty" := intermidiateRec."AW QC Pass Qty " + rec."Pass Qty";
                                "Total Fail Qty" := intermidiateRec."AW QC Fail Qty" + rec."Fail Qty";

                                if "Total Pass Qty" > intermidiateRec."Split Qty" then
                                    Error('Total pass qty should be less than or equal to job card Qty');

                                if "Total Fail Qty" > intermidiateRec."Split Qty" then
                                    Error('Total fail qty should be less than or equal to job card Qty');

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
                    //QCLine2AWRec: Record AWQualityCheckLine;
                    intermediateRec: Record IntermediateTable;
                    washSampleReqLineRec: Record "Washing Sample Requsition Line";
                    //Total: Integer;
                    QUantity: Integer;
                    "Total Pass Qty": Integer;
                    "Total Fail Qty": Integer;
                begin

                    if rec.Status = rec.Status::Posted then
                        Error('Entry already posted.');

                    // QCLine2AWRec.Reset();
                    // QCLine2AWRec.SetRange(No, "No.");

                    // if QCLine2AWRec.FindSet() then begin

                    intermediateRec.Reset();
                    intermediateRec.SetRange(No, rec."Sample Req No");
                    intermediateRec.SetRange("Line No", rec."Line No");
                    intermediateRec.SetRange("Split No", rec."Split No");

                    if intermediateRec.FindSet() then begin
                        // repeat
                        //     Total += QCLine2AWRec.Qty;
                        // until (QCLine2AWRec.Next() = 0);

                        // if Total > intermediateRec."Split Qty" then
                        //     Error('Total Defects quantity must be equal to the job card Qty.');

                        "Total Pass Qty" := intermediateRec."AW QC Pass Qty " + rec."Pass Qty";
                        "Total Fail Qty" := intermediateRec."AW QC Fail Qty" + rec."Fail Qty";

                        if "Total Pass Qty" > intermediateRec."Split Qty" then
                            Error('Total pass qty should be less than or equal to job card Qty');

                        if "Total Fail Qty" > intermediateRec."Split Qty" then
                            Error('Total fail qty should be less than or equal to job card Qty');

                        WashsamplereqlineRec.Reset();
                        WashsamplereqlineRec.SetRange("No.", rec."Sample Req No");
                        WashsamplereqlineRec.SetRange("Line no.", rec."Line No");

                        if WashsamplereqlineRec.FindSet() then begin
                            WashsamplereqlineRec."QC Pass Qty (AW)" := WashsamplereqlineRec."QC Pass Qty (AW)" + rec."Pass Qty";
                            WashsamplereqlineRec."QC Fail Qty (AW)" := WashsamplereqlineRec."QC Fail Qty (AW)" + rec."Fail Qty";
                        end;

                        WashsamplereqlineRec."QC Date (AW)" := rec."QC AW Date";
                        WashsamplereqlineRec.Modify();

                        intermediateRec."AW QC Pass Qty " := intermediateRec."AW QC Pass Qty " + rec."Pass Qty";
                        intermediateRec."AW QC Fail Qty" := intermediateRec."AW QC Fail Qty" + rec."Fail Qty";
                        intermediateRec.Modify();

                        rec.Status := rec.Status::Posted;
                        CurrPage.Editable(false);
                        CurrPage.Update();
                        Message('Quality checking posted.');
                    end
                    else
                        Error('Cannot find Job Card details.');
                    //end
                    // else
                    //     Error('Cannot find pass/fail entries.');
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
        IF NoSeriesMngment.SelectSeries(NavAppSetup."QC AW No", xRec."No.", rec."No.") THEN BEGIN
            NoSeriesMngment.SetSeries(rec."No.");
            EXIT(TRUE);
        END;
    end;


    trigger OnDeleteRecord(): Boolean
    var
        AWQualityCheckLineRec: Record AWQualityCheckLine;
    begin
        AWQualityCheckLineRec.Reset();
        AWQualityCheckLineRec.SetRange(No, rec."No.");
        if AWQualityCheckLineRec.FindSet() then
            AWQualityCheckLineRec.DeleteAll();
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