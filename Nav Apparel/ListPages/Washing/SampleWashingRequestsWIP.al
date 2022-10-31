page 50829 SampleWashingRequestsWIP
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Washing Sample Requsition Line";
    Caption = 'Washing Requests WIP';
    SourceTableView = sorting("No.") order(descending);
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Washing Req. No';
                }

                field("Sample Req. No"; "Sample Req. No")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; "Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field(Buyer; Buyer)
                {
                    ApplicationArea = All;
                }

                field("Gament Type"; "Gament Type")
                {
                    ApplicationArea = All;
                }

                field("Wash Plant Name"; "Wash Plant Name")
                {
                    ApplicationArea = All;
                    Caption = 'Washing Plant';
                }

                field("Wash Type"; "Wash Type")
                {
                    ApplicationArea = All;
                }

                field("Fabric Description"; "Fabric Description")
                {
                    ApplicationArea = All;
                    Caption = 'Fabrication';
                }

                field("Color Name"; "Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Colour';
                }

                field(Size; Size)
                {
                    ApplicationArea = All;
                }

                field("Req Qty"; "Req Qty")
                {
                    ApplicationArea = All;
                }

                field("Req Date"; "Req Date")
                {
                    ApplicationArea = All;
                }

                field("Unite Price"; "Unite Price")
                {
                    ApplicationArea = All;
                }

                field(Value; Value)
                {
                    ApplicationArea = All;
                }

                field("BW QC Date"; "BW QC Date")
                {
                    ApplicationArea = All;
                }

                field("Req Qty BW QC Pass"; "Req Qty BW QC Pass")
                {
                    ApplicationArea = All;
                    Caption = 'BW QC Pass Qty';
                }

                field("Req Qty BW QC Fail"; "Req Qty BW QC Fail")
                {
                    ApplicationArea = All;
                    Caption = 'BW QC Failed Qty';
                }

                field("Return Qty (BW)"; "Return Qty (BW)")
                {
                    ApplicationArea = All;
                    Caption = 'BW Returned Qty';
                }

                field("AW QC Date"; "QC Date (AW)")
                {
                    ApplicationArea = All;
                }

                field("QC Pass Qty (AW)"; "QC Pass Qty (AW)")
                {
                    ApplicationArea = All;
                    Caption = 'AW QC Pass Qty';
                }

                field("QC Fail Qty (AW)"; "QC Fail Qty (AW)")
                {
                    ApplicationArea = All;
                    Caption = 'AW QC Failed Qty';
                }

                field("Return Qty (AW)"; "Return Qty (AW)")
                {
                    ApplicationArea = All;
                    Caption = 'AW Returned Qty';
                }

                field("Dispatch Qty"; "Dispatch Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Final Dispatch Qty';
                }

                field(RemarkLine; RemarkLine)
                {
                    Caption = 'Remark';
                    ApplicationArea = All;
                }
            }
        }
    }
}