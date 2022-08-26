page 50747 RTCBWListPart
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    AutoSplitKey = true;
    SourceTable = RTCBWLine;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No"; "Line No")
                {
                    Caption = 'Seq No';
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Item; Item)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if Get_Count() > 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field(UOM; UOM)
                {
                    ApplicationArea = All;
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        WashSampleReqRec: Record "Washing Sample Requsition Line";
                    begin
                        WashSampleReqRec.Reset();
                        WashSampleReqRec.SetRange("No.", "Req No");
                        WashSampleReqRec.SetRange("Line no.", "Request Line No");
                        if WashSampleReqRec.FindSet() then begin

                            if WashSampleReqRec."Req Qty BW QC Fail" < Qty then
                                Error('Return qty cannot be greater than requested qty.');
                        end;
                    end;
                }
            }
        }
    }

    // trigger OnNewRecord(BelowxRec: Boolean)
    // var
    //     inx: Integer;
    // begin
    //     "Line No" := xRec."Line No" + 1;
    // end;

    procedure Get_Count(): Integer
    var
        RTCBWLineRec: Record RTCBWLine;
    begin
        RTCBWLineRec.Reset();
        RTCBWLineRec.SetRange("No.", "No.");
        RTCBWLineRec.SetFilter("Line No", '<>%1', "Line No");
        if RTCBWLineRec.FindSet() then
            exit(RTCBWLineRec.Count)
        else
            exit(0);
    end;

}


