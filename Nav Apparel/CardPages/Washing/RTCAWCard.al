page 50682 RTCAWCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = RTCAWHeader;
    Caption = 'Return To Customer (After Wash)';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }

                field(Lot; Lot)
                {
                    ApplicationArea = all;
                    Caption = 'Return Full Lot';

                    trigger OnValidate()
                    var
                    begin
                        if lot = true then begin
                            J := true;
                        end
                        else begin
                            J := false;
                        end;

                        CurrPage.Update();
                    end;
                }

                field("JoB Card No"; "JoB Card No")
                {
                    ApplicationArea = All;
                    Editable = Not J;

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
                            "Slipt No" := jobcreaationRec."Split No";
                            "Req No" := jobcreaationRec.No;
                            CurrPage.Update();
                        end;
                    end;
                }

                field("Req No"; "Req No")
                {
                    ApplicationArea = all;
                    Editable = J;

                    trigger OnValidate()
                    var
                        jobcreaationRec: Record JobCreationLine;
                    begin
                        jobcreaationRec.Reset();
                        jobcreaationRec.SetRange(No, "Req No");

                        if jobcreaationRec.FindSet() then begin
                            CustomerCode := jobcreaationRec.BuyerCode;
                            CustomerName := jobcreaationRec.BuyerName;
                            "Req Date" := jobcreaationRec."Req Date";
                            "Line No" := jobcreaationRec."Line No";
                            //"Slipt No" := jobcreaationRec."Split No";
                            //"Req No" := jobcreaationRec.No;

                            //Delete existing items in the list part and Insert All Job card FG Items



                            CurrPage.Update();
                        end;
                    end;
                }

                field(CustomerName; CustomerName)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Caption = 'Customer';
                }

                field("Req Date"; "Req Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Gate Pass No"; "Gate Pass No")
                {
                    ApplicationArea = All;
                }

                field(Status; Status)
                {
                    Caption = 'Status';
                    ApplicationArea = all;
                    Enabled = false;
                }
            }

            group(" ")
            {
                part("RTCAWListPart1"; RTCAWListPart)
                {
                    Visible = Not j;
                    ApplicationArea = All;
                    Caption = 'Return Details';
                    SubPageLink = "No." = field("No."), "Req No" = field("Req No"), "Header Line No " = field("Line No"), "Split No" = field("Slipt No");
                }
            }


            group("  ")
            {
                part("RTCAWListPart2"; RTCAWListPart)
                {
                    Visible = j;
                    ApplicationArea = All;
                    Caption = 'Return Details';
                    SubPageLink = "No." = field("No."), "Req No" = field("Req No"), "Header Line No " = field("Line No");
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

                trigger OnAction();
                var
                    interMediRec: Record IntermediateTable;
                    sampleReqline: Record "Washing Sample Requsition Line";
                    RTCAWLineRec: Record RTCAWLine;
                    RTCAWHeaderRec: Record RTCAWHeader;
                begin

                    if "Req No" = '' then
                        Error('Invalid request No');

                    RTCAWHeaderRec.Reset();
                    RTCAWHeaderRec.SetRange("No.", "No.");
                    RTCAWHeaderRec.SetRange("Line No", "Line No");
                    RTCAWHeaderRec.SetFilter(Status, '=%1', RTCAWHeaderRec."Status"::Pending);

                    if RTCAWHeaderRec.FindSet() then begin

                        if Lot = false then begin  //Return only a Job Card

                            RTCAWLineRec.Reset();
                            RTCAWLineRec.SetRange("No.", "No.");
                            RTCAWLineRec.SetRange("Header Line No ", "Line No");

                            if RTCAWLineRec.FindSet() then begin
                                repeat
                                    interMediRec.Reset();
                                    interMediRec.SetRange(No, "Req No");
                                    interMediRec.SetRange("Line No", RTCAWLineRec."Header Line No ");
                                    interMediRec.SetRange("Split No", RTCAWLineRec."Split No");

                                    if interMediRec.FindSet() then begin

                                        if interMediRec."Split Qty" < (interMediRec."Return Qty (AW)" + RTCAWLineRec.Qty) then
                                            Error('Return Qty is greater than the Job Card Qty.');

                                        interMediRec."Return Qty (AW)" += RTCAWLineRec.Qty;
                                        interMediRec.Modify();

                                        sampleReqline.Reset();
                                        sampleReqline.SetRange("No.", "Req No");
                                        sampleReqline.SetRange("Line no.", "Line No");

                                        if sampleReqline.FindSet() then begin
                                            sampleReqline."Return Qty (AW)" += RTCAWLineRec.Qty;
                                            sampleReqline.Modify();
                                        end;

                                        Message('Return qty updated');
                                    end
                                    else
                                        Error('Cannot find split entries.');

                                until RTCAWLineRec.Next() = 0;
                            end
                            else
                                Error('Cannot find Pass/Fail entries.');
                        end
                        else begin  //Return Full Lot



                        end;
                    end
                    else
                        Error('Already marke as returned.');
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
        RTCAWLineRec: Record RTCAWLine;
    begin
        RTCAWLineRec.Reset();
        RTCAWLineRec.SetRange("No.", "No.");
        if RTCAWLineRec.FindSet() then
            RTCAWLineRec.DeleteAll();

    end;

    trigger OnOpenPage()
    var
    begin
        if Status = Status::Posted then
            CurrPage.Editable(false)
        else
            CurrPage.Editable(true);
    end;


    trigger OnInit()
    var
    begin
        j := false;
    end;


    var
        Lot: Boolean;
        J: Boolean;

}
