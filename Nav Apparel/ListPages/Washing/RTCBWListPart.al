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
                field("Line No"; rec."Line No")
                {
                    Caption = 'Seq No';
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Item; rec.Item)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        if Get_Count() > 1 then
                            Error('You cannot put more than one item');
                    end;
                }

                field(UOM; rec.UOM)
                {
                    ApplicationArea = All;
                }

                field(Qty; rec.Qty)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        WashSampleReqRec: Record "Washing Sample Requsition Line";
                    begin
                        WashSampleReqRec.Reset();
                        WashSampleReqRec.SetRange("No.", rec."Req No");
                        WashSampleReqRec.SetRange("Line no.", rec."Request Line No");
                        if WashSampleReqRec.FindSet() then begin

                            if WashSampleReqRec."Req Qty BW QC Fail" < rec.Qty then
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
        RTCBWLineRec.SetRange("No.", rec."No.");
        RTCBWLineRec.SetFilter("Line No", '<>%1', rec."Line No");
        if RTCBWLineRec.FindSet() then
            exit(RTCBWLineRec.Count)
        else
            exit(0);
    end;

}


