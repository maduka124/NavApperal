page 50746 RTCBWList
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = RTCBWHeader;
    CardPageId = RTCBWCard;
    SourceTableView = sorting("No.") order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; rec."No.")
                {
                    Caption = 'Document No';
                    ApplicationArea = All;
                }

                field("Req No"; rec."Req No")
                {
                    ApplicationArea = all;
                    Caption = 'Req. No';
                }

                field("CusTomer Name"; rec."CusTomer Name")
                {
                    Caption = 'Customer';
                    ApplicationArea = all;
                }

                field("Gate Pass"; rec."Gate Pass")
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
        Samplereqline.SetRange("No.",rec. "Req No");

        if Samplereqline.FindSet() then
            if Samplereqline."Return Qty (BW)" > 0 then
                Error('Returned quantity updated. Cannot delete.');

        RTCBWLineRec.Reset();
        RTCBWLineRec.SetRange("No.", rec."No.");
        if RTCBWLineRec.FindSet() then
            RTCBWLineRec.DeleteAll();
    end;
}