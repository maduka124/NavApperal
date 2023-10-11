page 51424 PendingAllocationCard
{
    Caption = 'PO Allocation To Wash';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = PendingAllocationWash;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group("Wash Allocation Colors")
            {
                part(POWashAllocated; POWashAllocation)
                {
                    ApplicationArea = All;
                    Caption = '  ';
                    SubPageLink = "Seq No" = field("Seq No");
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Allocate PO")
            {
                ApplicationArea = All;
                Image = Allocate;

                trigger OnAction()
                var
                    AllocatedPORec: Record AllocatedPoWash;
                    WashingMasterRec: Record WashingMaster;
                    LineNo: Integer;

                begin

                    WashingMasterRec.Reset();
                    WashingMasterRec.SetCurrentKey("Line No");
                    WashingMasterRec.Ascending(true);
                    if WashingMasterRec.FindLast() then
                        LineNo := WashingMasterRec."Line No";

                    AllocatedPORec.Reset();
                    AllocatedPORec.SetRange("Seq No", Rec."Seq No");

                    if AllocatedPORec.FindSet() then begin
                        repeat
                            if AllocatedPORec."Washing Plant" = '' then begin
                                Error('Wash Plant is Empty');
                                if AllocatedPORec."Wash Type" = '' then
                                    Error('Wash Type is Empty');
                            end
                            else begin
                                if AllocatedPORec."Wash Type" = '' then
                                    Error('Wash Type is Empty');
                            end;
                        until AllocatedPORec.Next() = 0;
                    end;

                    AllocatedPORec.Reset();
                    AllocatedPORec.SetRange("Seq No", Rec."Seq No");

                    if AllocatedPORec.FindSet() then begin
                        repeat

                            WashingMasterRec.Reset();
                            WashingMasterRec.SetRange("Style No", AllocatedPORec."Style No");
                            WashingMasterRec.SetRange("PO No", AllocatedPORec."PO No");
                            WashingMasterRec.SetRange(Lot, AllocatedPORec.Lot);
                            WashingMasterRec.SetRange("Color Code", AllocatedPORec."Color Code");

                            if Not WashingMasterRec.FindSet() then begin

                                WashingMasterRec.Init();
                                LineNo += 1;
                                WashingMasterRec."Line No" := LineNo;
                                WashingMasterRec."Buyer Code" := Rec."Buyer Code";
                                WashingMasterRec."Buyer Name" := Rec."Buyer Name";
                                WashingMasterRec."Style No" := Rec."Style No";
                                WashingMasterRec."Style Name" := Rec."Style Name";
                                WashingMasterRec."PO No" := Rec."PO No";
                                WashingMasterRec.Lot := Rec.Lot;
                                WashingMasterRec."Color Code" := AllocatedPORec."Color Code";
                                WashingMasterRec."Color Name" := AllocatedPORec."Color Name";
                                WashingMasterRec."Color Qty" := AllocatedPORec."Color Qty";
                                WashingMasterRec."PO Qty" := AllocatedPORec."PO Qty";
                                WashingMasterRec."Shipment Date" := Rec."Shipment Date";
                                WashingMasterRec."Sewing Factory Code" := Rec."Sewing Factory Code";
                                WashingMasterRec."Sewing Factory Name" := Rec."Sewing Factory Name";
                                WashingMasterRec."Plan Start Date" := Rec."Plan Start Date";
                                WashingMasterRec."Plan End Date" := rec."Plan End Date";
                                WashingMasterRec."Washing Plant" := AllocatedPORec."Washing Plant";
                                WashingMasterRec."Wash Type" := AllocatedPORec."Wash Type";
                                WashingMasterRec.Recipe := AllocatedPORec.Recipe;
                                WashingMasterRec."Plan Max Target" := Rec."Plan Max Target";
                                WashingMasterRec."Washing Plant Code" := AllocatedPORec."Washing Plant Code";
                                WashingMasterRec.Insert();
                            end;

                            AllocatedPORec."Wash Allocated Color" := true;
                            AllocatedPORec.Modify(true);

                        until AllocatedPORec.Next() = 0;

                        Rec."Wash Allocated" := true;
                        Rec.Modify(true);
                        Message('PO alloted to Wash');
                        CurrPage.Close();
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        AllocatedPORec: Record AllocatedPoWash;
        AssortmentDetailsRec: Record AssorColorSizeRatio;
        LocationRec: Record Location;
        LineNo: Integer;
    begin


        // Get Last Line 
        AllocatedPORec.Reset();
        AllocatedPORec.SetRange("Seq No", Rec."Seq No");

        if AllocatedPORec.FindLast() then
            LineNo := AllocatedPORec."Line No";

        AllocatedPORec.Reset();
        AllocatedPORec.SetRange("Style No", Rec."Style No");
        AllocatedPORec.SetRange("PO No", Rec."PO No");
        AllocatedPORec.SetRange(Lot, Rec.Lot);

        if not AllocatedPORec.FindSet() then begin

            AssortmentDetailsRec.Reset();
            AssortmentDetailsRec.SetRange("Style No.", Rec."Style No");
            AssortmentDetailsRec.SetRange("Lot No.", Rec.Lot);
            AssortmentDetailsRec.SetRange("PO No.", Rec."PO No");

            if AssortmentDetailsRec.FindSet() then begin

                repeat
                    if AssortmentDetailsRec."Colour Name" <> '*' then begin
                        if AssortmentDetailsRec."Colour Name" <> '' then begin
                            if AssortmentDetailsRec.Total <> 0 then begin
                                AllocatedPORec.Init();
                                LineNo += 1;
                                AllocatedPORec."Line No" := LineNo;
                                AllocatedPORec."Seq No" := Rec."Seq No";
                                AllocatedPORec."Style Name" := Rec."Style Name";
                                AllocatedPORec."Style No" := Rec."Style No";
                                AllocatedPORec."Buyer Code" := Rec."Buyer Code";
                                AllocatedPORec."Buyer Name" := Rec."Buyer Name";
                                AllocatedPORec.Lot := Rec.Lot;
                                AllocatedPORec."PO No" := Rec."PO No";
                                AllocatedPORec."Color Name" := AssortmentDetailsRec."Colour Name";
                                AllocatedPORec."Color Code" := AssortmentDetailsRec."Colour No";
                                AllocatedPORec."Color Qty" := AssortmentDetailsRec.Total;
                                AllocatedPORec."Shipment Date" := Rec."Shipment Date";
                                AllocatedPORec."Plan Start Date" := Rec."Plan Start Date";
                                AllocatedPORec."Plan End Date" := Rec."Plan End Date";
                                AllocatedPORec."Plan Max Target" := Rec."Plan Max Target";

                                LocationRec.Reset();
                                LocationRec.SetRange(Code, Rec."Sewing Factory Code");
                                if LocationRec.FindSet() then
                                    AllocatedPORec."Sewing Factory Name" := LocationRec.Name;

                                AllocatedPORec."Sewing Factory Code" := rec."Sewing Factory Code";

                                AllocatedPORec."PO Qty" := Rec."PO Qty";
                                AllocatedPORec.Insert()
                            end;
                        end;
                    end;
                until AssortmentDetailsRec.Next() = 0;
            end;
        end;
    end;

}