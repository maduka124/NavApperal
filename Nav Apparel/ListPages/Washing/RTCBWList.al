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
}