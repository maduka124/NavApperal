page 50746 RTCBWList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = RTCBWHeader;
    CardPageId = RTCBWCard;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    Caption = 'Document No';
                    ApplicationArea = All;
                }

                field("Req No"; "Req No")
                {
                    ApplicationArea = all;
                    Caption = 'Req. No';
                }

                field("CusTomer Name"; "CusTomer Name")
                {
                    Caption = 'Customer';
                    ApplicationArea = all;
                }

                field("Gate Pass"; "Gate Pass")
                {
                    ApplicationArea = all;
                }
            }
        }
    }


    trigger OnDeleteRecord(): Boolean
    var
        RTCBWLineRec: Record RTCBWLine;
        Samplereqline: Record "Washing Sample Requsition Line";
    begin
        Samplereqline.Reset();
        Samplereqline.SetRange("No.", "Req No");

        if Samplereqline.FindSet() then
            if Samplereqline."Return Qty (BW)" > 0 then
                Error('Returned quantity updated. Cannot delete.');

        RTCBWLineRec.Reset();
        RTCBWLineRec.SetRange("No.", "No.");
        if RTCBWLineRec.FindSet() then
            RTCBWLineRec.DeleteAll();
    end;
}