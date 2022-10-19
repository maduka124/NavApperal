page 50823 "DepReqSheetListpart"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = DeptReqSheetLine;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Item No"; "Item No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        itemRec: Record Item;
                        DeptReqSheetLineRec: Record DeptReqSheetLine;
                    begin
                        itemRec.Reset();
                        itemRec.SetRange("No.", "Item No");

                        if itemRec.FindSet() then begin
                            "Item Name" := itemRec.Description;
                            UOM := itemRec."Base Unit of Measure";
                        end;

                        // DeptReqSheetLineRec.Reset();
                        // DeptReqSheetLineRec.SetRange("Req No", "Req No");

                        // if DeptReqSheetLineRec.FindSet() then begin
                        //     repeat
                        //         if "Item No" = DeptReqSheetLineRec."Item No" then
                        //             Error('This item already exist in line');
                        //     until DeptReqSheetLineRec.Next() = 0;

                        // end;
                    end;
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item Description';
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        "Qty to Received" := Qty - "Qty Received";
                    end;
                }

                field(UOM; UOM)
                {
                    ApplicationArea = All;
                }

                field("Qty Received"; "Qty Received")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                    begin
                        "Qty to Received" := Qty - "Qty Received";
                    end;
                }

                field("Qty to Received"; "Qty to Received")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }

    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        inx: Integer;
    begin
        "Line No" := xRec."Line No" + 1;
    end;

}