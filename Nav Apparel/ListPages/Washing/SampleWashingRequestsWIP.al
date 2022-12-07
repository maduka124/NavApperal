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
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Washing Req. No';
                }

                field("Sample Req. No"; rec."Sample Req. No")
                {
                    ApplicationArea = All;
                }

                field("Style Name"; rec."Style Name")
                {
                    ApplicationArea = All;
                    Caption = 'Style';
                }

                field(Buyer; rec.Buyer)
                {
                    ApplicationArea = All;
                }

                field("Gament Type"; rec."Gament Type")
                {
                    ApplicationArea = All;
                }

                field("Wash Plant Name"; rec."Wash Plant Name")
                {
                    ApplicationArea = All;
                    Caption = 'Washing Plant';
                }

                field("Wash Type"; rec."Wash Type")
                {
                    ApplicationArea = All;
                }

                field("Fabric Description"; rec."Fabric Description")
                {
                    ApplicationArea = All;
                    Caption = 'Fabrication';
                }

                field("Color Name"; rec."Color Name")
                {
                    ApplicationArea = All;
                    Caption = 'Colour';
                }

                field(Size; rec.Size)
                {
                    ApplicationArea = All;
                }

                field("Req Qty"; rec."Req Qty")
                {
                    ApplicationArea = All;
                }

                field("Req Date"; rec."Req Date")
                {
                    ApplicationArea = All;
                }

                field("Unite Price"; rec."Unite Price")
                {
                    ApplicationArea = All;
                }

                field(Value; rec.Value)
                {
                    ApplicationArea = All;
                }

                field("BW QC Date"; rec."BW QC Date")
                {
                    ApplicationArea = All;
                }

                field("Req Qty BW QC Pass"; rec."Req Qty BW QC Pass")
                {
                    ApplicationArea = All;
                    Caption = 'BW QC Pass Qty';
                }

                field("Req Qty BW QC Fail"; rec."Req Qty BW QC Fail")
                {
                    ApplicationArea = All;
                    Caption = 'BW QC Failed Qty';
                }

                field("Return Qty (BW)"; rec."Return Qty (BW)")
                {
                    ApplicationArea = All;
                    Caption = 'BW Returned Qty';
                }

                field("AW QC Date"; rec."QC Date (AW)")
                {
                    ApplicationArea = All;
                }

                field("QC Pass Qty (AW)"; rec."QC Pass Qty (AW)")
                {
                    ApplicationArea = All;
                    Caption = 'AW QC Pass Qty';
                }

                field("QC Fail Qty (AW)"; rec."QC Fail Qty (AW)")
                {
                    ApplicationArea = All;
                    Caption = 'AW QC Failed Qty';
                }

                field("Return Qty (AW)"; rec."Return Qty (AW)")
                {
                    ApplicationArea = All;
                    Caption = 'AW Returned Qty';
                }

                field("Dispatch Qty"; rec."Dispatch Qty")
                {
                    ApplicationArea = All;
                    Caption = 'Final Dispatch Qty';
                }

                field(RemarkLine; rec.RemarkLine)
                {
                    Caption = 'Remark';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        LoginRec: Page "Login Card";
        LoginSessionsRec: Record LoginSessions;
    begin

        //Check whether user logged in or not
        LoginSessionsRec.Reset();
        LoginSessionsRec.SetRange(SessionID, SessionId());

        if not LoginSessionsRec.FindSet() then begin  //not logged in
            Clear(LoginRec);
            LoginRec.LookupMode(true);
            LoginRec.RunModal();

            // LoginSessionsRec.Reset();
            // LoginSessionsRec.SetRange(SessionID, SessionId());
            // if LoginSessionsRec.FindSet() then
            //     rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end
        else begin   //logged in
            //rec.SetFilter("Secondary UserID", '=%1', LoginSessionsRec."Secondary UserID");
        end;

    end;
}