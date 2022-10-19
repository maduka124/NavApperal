page 50710 "DepReqSheetListpart"
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
                field("Req No"; "Req No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Line No"; "Line No")
                {
                    ApplicationArea = All;
                    Caption = 'Seq No';
                }

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

                        DeptReqSheetLineRec.Reset();
                        DeptReqSheetLineRec.SetRange("Req No", "Req No");

                        if DeptReqSheetLineRec.FindSet() then begin
                            if "Item No" = "Item No" then
                                Error('This item already exist in line');
                        end;
                    end;
                }

                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Item';
                }

                field(Qty; Qty)
                {
                    ApplicationArea = All;
                }

                field(UOM; UOM)
                {
                    ApplicationArea = All;
                }

                field(Remarks; Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
        // area(Factboxes)
        // {

        // }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        inx: Integer;
    begin
        "Line No" := xRec."Line No" + 1;
    end;


    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //             trigger OnAction();
    //             begin

    //             end;
    //         }
    //     }
    // }
}