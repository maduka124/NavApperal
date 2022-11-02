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
                field("Main Category Name"; "Main Category Name")
                {
                    ApplicationArea = All;
                    Caption = 'Main Category';

                    trigger OnValidate()
                    var
                        MainCategoryRec: Record "Main Category";
                    begin
                        MainCategoryRec.Reset();
                        MainCategoryRec.SetRange("Main Category Name", "Main Category Name");
                        if MainCategoryRec.FindSet() then
                            "Main Category No." := MainCategoryRec."No.";
                    end;
                }

                field("Item No"; "Item No")
                {
                    ApplicationArea = All;
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                        itemRec: Record Item;
                        DeptReqSheetLineRec: Record DeptReqSheetLine;
                    begin
                        if "Qty Received" > 0 then
                            Error('Cannot change the Item as Qty already received.');

                        if "PO Raized" then
                            Error('Cannot change the Item as PO already created by the central purchasing department.');

                        itemRec.Reset();
                        itemRec.SetRange("No.", "Item No");

                        if itemRec.FindSet() then begin
                            "Item Name" := itemRec.Description;
                            UOM := itemRec."Base Unit of Measure";
                        end;

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
                    Caption = 'Order Qty';
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                    begin
                        if "Qty Received" > 0 then
                            Error('Item: %1 already marked as received. Cannot change the order quantity.', "Item Name");

                        if "PO Raized" then
                            Error('Cannot change the order quantity as PO already created by the central purchasing department.');


                        "Qty to Received" := Qty - "Qty Received";
                    end;
                }

                field(UOM; UOM)
                {
                    ApplicationArea = All;
                    Editable = EditableGb;
                }

                field("Qty Received"; "Qty Received")
                {
                    ApplicationArea = All;
                    Editable = EditableGb;

                    trigger OnValidate()
                    var
                        DeptReqSheetLineRec: Record DeptReqSheetLine;
                        DeptReqSheetHeadRec: Record DeptReqSheetHeader;
                        Status: Boolean;
                    begin
                        if "Qty Received" > Qty then
                            Error('Qty Received is greater than the Order Qty.');


                        "Qty to Received" := Qty - "Qty Received";
                        CurrPage.Update();

                        //Check whether po fully received or not
                        DeptReqSheetLineRec.Reset();
                        DeptReqSheetLineRec.SetRange("Req No", "Req No");

                        if DeptReqSheetLineRec.FindSet() then begin
                            repeat
                                if DeptReqSheetLineRec."Qty to Received" > 0 then
                                    Status := true;
                            until DeptReqSheetLineRec.Next() = 0;
                        end;

                        //Update Header status
                        DeptReqSheetHeadRec.Reset();
                        DeptReqSheetHeadRec.SetRange("Req No", "Req No");
                        DeptReqSheetHeadRec.FindSet();

                        if Status = false then
                            DeptReqSheetHeadRec."Completely Received" := DeptReqSheetHeadRec."Completely Received"::Yes
                        else
                            DeptReqSheetHeadRec."Completely Received" := DeptReqSheetHeadRec."Completely Received"::No;

                        DeptReqSheetHeadRec.Modify();
                        CurrPage.Update();

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
                    Editable = EditableGb;
                }

                field("PO Raized"; "PO Raized")
                {
                    ApplicationArea = All;
                    Editable = false;
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


    trigger OnOpenPage()
    var
        DeptReqSheetHeader: Record DeptReqSheetHeader;
    begin
        if "Req No" <> '' then begin
            DeptReqSheetHeader.Get("Req No");

            if DeptReqSheetHeader."Completely Received" = DeptReqSheetHeader."Completely Received"::Yes then
                EditableGb := false
            else
                EditableGb := true;
        end;
    end;


    trigger OnAfterGetCurrRecord()
    var
        DeptReqSheetHeader: Record DeptReqSheetHeader;
    begin
        if "Req No" <> '' then begin
            DeptReqSheetHeader.Get("Req No");

            if DeptReqSheetHeader."Completely Received" = DeptReqSheetHeader."Completely Received"::Yes then
                EditableGb := false
            else
                EditableGb := true;
        end;
    end;


    var
        EditableGb: Boolean;

}