pageextension 50824 "Req.Worksheet Ext" extends "Req. Worksheet"
{
    layout
    {
        addafter("Location Code")
        {
            field("Department Name"; "Department Name")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addafter(CarryOutActionMessage)
        {
            action("Load Req. Items")
            {
                Caption = 'Load Req. Items';
                Image = AddAction;
                ApplicationArea = All;

                trigger OnAction();
                var
                    DeptReqHeaderRec: Record DeptReqSheetHeader;
                    DeptReqLineRec: Record DeptReqSheetLine;
                    RequLineRec: Record "Requisition Line";
                    RequLineRec1: Record "Requisition Line";
                    ReqLineNo: BigInteger;
                    NavAppSetupRec: Record "NavApp Setup";
                begin

                    NavAppSetupRec.Reset();
                    NavAppSetupRec.FindSet();

                    //Get max line no
                    RequLineRec.Reset();
                    RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Req Worksheet Template Name");
                    RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Req Journal Batch Name");

                    if RequLineRec.FindLast() then
                        ReqLineNo := RequLineRec."Line No.";

                    DeptReqLineRec.Reset();
                    DeptReqLineRec.SetCurrentKey("Item No");
                    DeptReqLineRec.Ascending(true);
                    DeptReqLineRec.SetFilter(DeptReqLineRec."Qty to Received", '>%1', 0);
                    if DeptReqLineRec.FindSet() then begin

                        repeat
                            DeptReqHeaderRec.Reset();
                            DeptReqHeaderRec.SetRange("Req No", DeptReqLineRec."Req No");
                            if DeptReqHeaderRec.FindSet() then begin

                                RequLineRec.Reset();
                                RequLineRec.SetCurrentKey("Worksheet Template Name", "Journal Batch Name", "No.");
                                RequLineRec.SetRange("Worksheet Template Name", NavAppSetupRec."Req Worksheet Template Name");
                                RequLineRec.SetRange("Journal Batch Name", NavAppSetupRec."Req Journal Batch Name");
                                RequLineRec.SetFilter(Type, '=%1', RequLineRec.Type::Item);
                                //RequLineRec.SetRange("Vendor No.", Supplier);                              
                                RequLineRec.SetRange("No.", DeptReqLineRec."Item No");
                                RequLineRec.SetRange("CP Req Code", DeptReqLineRec."Req No");

                                if not RequLineRec.FindSet() then begin    //Not existing items

                                    ReqLineNo += 1;
                                    RequLineRec1.Init();
                                    RequLineRec1."Worksheet Template Name" := NavAppSetupRec."Req Worksheet Template Name";
                                    RequLineRec1."Journal Batch Name" := NavAppSetupRec."Req Journal Batch Name";
                                    RequLineRec1."Line No." := ReqLineNo;
                                    RequLineRec1.Type := RequLineRec.Type::Item;
                                    RequLineRec1.Validate("No.", DeptReqLineRec."Item No");
                                    RequLineRec1."Action Message" := RequLineRec."Action Message"::New;
                                    RequLineRec1."Accept Action Message" := true;
                                    RequLineRec1."Ending Date" := Today + 7;
                                    RequLineRec1.Quantity := DeptReqLineRec."Qty to Received";
                                    RequLineRec1.Validate("Location Code", DeptReqHeaderRec."Factory Code");
                                    RequLineRec1."Department Code" := DeptReqHeaderRec."Department Code";
                                    RequLineRec1."Department Name" := DeptReqHeaderRec."Department Name";
                                    RequLineRec1.Validate("Shortcut Dimension 1 Code", DeptReqHeaderRec."Global Dimension Code");
                                    RequLineRec1.EntryType := RequLineRec1.EntryType::"Central Purchasing";
                                    RequLineRec1."CP Req Code" := DeptReqLineRec."Req No";
                                    RequLineRec1."CP Line" := DeptReqLineRec."Line No";
                                    RequLineRec1.Insert();
                                    // end
                                    // else begin  // Update existing item
                                    //     RequLineRec."Quantity" := RequLineRec."Quantity" + DeptReqLineRec.Qty;
                                    //     RequLineRec.Modify();
                                end;

                            end;
                        until DeptReqLineRec.Next() = 0;

                        CurrPage.Update();

                    end;
                end;
            }
        }

    }
}