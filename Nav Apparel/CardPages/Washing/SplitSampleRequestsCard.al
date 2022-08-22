page 50720 "Split Sample Requests Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Split Sample Requests';
    SourceTable = "Washing Sample Requsition Line";
    SourceTableView = where("Split Status" = filter(Yes));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Req. No';
                }

                field(Select; Select)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        WashingSampleReqRec: Record "Washing Sample Requsition Line";
                        CountRec: Integer;
                    begin
                        CurrPage.Update();
                        CountRec := 0;
                        WashingSampleReqRec.Reset();
                        WashingSampleReqRec.SetFilter(Select, '=%1', true);

                        if WashingSampleReqRec.FindSet() then
                            CountRec := WashingSampleReqRec.Count;

                        if CountRec > 1 then
                            Error('You cannot select multiple lines.');

                    end;
                }

                field(Type; Type)
                {
                    ApplicationArea = All;
                }

                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Color';
                }

                field("Order Qty"; "Order Qty")
                {
                    ApplicationArea = All;
                }

                field("Gament Type"; "Gament Type")
                {
                    ApplicationArea = All;
                }

                field(SampleType; SampleType)
                {
                    ApplicationArea = All;
                    Caption = 'Sample Type';
                }

                field("Wash Type"; "Wash Type")
                {
                    ApplicationArea = All;
                }

                field(Size; Size)
                {
                    ApplicationArea = All;
                }

                field("Req Date"; "Req Date")
                {
                    ApplicationArea = All;
                }

                field(RemarkLine; RemarkLine)
                {
                    ApplicationArea = All;
                    Caption = 'Remark';
                }

                field("Split Status"; "Split Status")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("View Splits")
            {
                ApplicationArea = All;
                Image = ViewDetails;

                trigger OnAction()
                var
                    Splits: Page "Job Creation Card";
                    WashSampleReqLineRec: Record "Washing Sample Requsition Line";
                begin
                    WashSampleReqLineRec.Reset();
                    WashSampleReqLineRec.SetRange("No.", "No.");
                    WashSampleReqLineRec.SetRange("Line no.", "Line no.");
                    WashSampleReqLineRec.SetFilter(Select, '=%1', true);

                    if WashSampleReqLineRec.FindSet() then begin
                        if WashSampleReqLineRec."Split Status" = WashSampleReqLineRec."Split Status"::No then
                            Error('Sample request has not been split.');

                        Clear(Splits);
                        //Splits.PassParameters("No.", "Line no.", Editeble::No);
                        Splits.RunModal();
                    end
                    else
                        Error('Please select an entry.');
                end;
            }

            action("Split Sample Request")
            {
                ApplicationArea = all;
                Image = Split;

                trigger OnAction()
                var
                    Splits: Page "Job Creation Card";
                    WashSampleReqLineRec: Record "Washing Sample Requsition Line";
                begin
                    WashSampleReqLineRec.Reset();
                    WashSampleReqLineRec.SetRange("No.", "No.");
                    WashSampleReqLineRec.SetRange("Line no.", "Line no.");
                    WashSampleReqLineRec.SetFilter(Select, '=%1', true);

                    if WashSampleReqLineRec.FindSet() then begin
                        if WashSampleReqLineRec."Split Status" = WashSampleReqLineRec."Split Status"::Yes then
                            Error('Sample request has been already split before.');

                        if (WashSampleReqLineRec."Req Qty BW QC Fail" + WashSampleReqLineRec."Req Qty BW QC Pass") = 0 then begin
                            if (Dialog.CONFIRM('"Befor Wash Quality Check has not been performed on this sample request. Do you want continue?', true) = true) then begin
                                Clear(Splits);
                                Splits.LookupMode(true);
                                // Splits.PassParameters("No.", "Line no.", Editeble::Yes);
                                Splits.RunModal();
                            end;
                        end
                        else begin
                            Clear(Splits);
                            Splits.LookupMode(true);
                            //Splits.PassParameters("No.", "Line no.", Editeble::Yes);
                            Splits.RunModal();
                        end;
                    end
                    else
                        Error('Please select an entry.');
                end;
            }

            action("Assgin Recipe/Job Card")
            {
                ApplicationArea = All;
                Image = CreateJobSalesInvoice;

                trigger OnAction()
                var
                    Split: Page "Job Creation Card";
                    WashSampleReqLineRec: Record "Washing Sample Requsition Line";
                begin
                    WashSampleReqLineRec.Reset();
                    WashSampleReqLineRec.SetRange("No.", "No.");
                    WashSampleReqLineRec.SetRange("Line no.", "Line no.");
                    WashSampleReqLineRec.SetFilter(Select, '=%1', true);

                    if WashSampleReqLineRec.FindSet() then begin
                        if WashSampleReqLineRec."Split Status" = WashSampleReqLineRec."Split Status"::No then
                            Error('Sample request has not been split.');

                        Clear(Split);
                        Split.LookupMode(true);
                        //  Split.PassParameters("No.", "Line no.", Editeble::Yes);
                        Split.RunModal();
                    end
                    else
                        Error('Please select an entry.');
                end;
            }
        }
    }
}